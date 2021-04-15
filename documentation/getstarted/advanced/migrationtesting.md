---
layout: documentation
menu: migrationtesting
subtitle: 'Tutorial: Testing Flyway migrations in a CI pipeline'
redirect_from:
- /getStarted/migrationtesting/
- /documentation/getstarted/migrationtesting/
---
# Tutorial: Testing Flyway migrations in a CI pipeline

This tutorial will guide you through the process of setting up Flyway migration tests in a CI pipeline using [Spawn](spawn.cc) to provision a database on the fly.

## Prerequisites

Install Spawn by visiting the [getting started documentation](https://www.spawn.cc/docs/getting-started.html) and following the installation steps.

This tutorial will assume you have a database with flyway migrations already set up, and migration scripts stored in your repository.

## Introduction

Testing your database migrations before they reach production is critical. There are a few scenarios which result in a breaking change: you could write a migration which doesn't work on a database with data in, you could have 2 developers both merge a versioned migration into production at the same time, and someone could write some SQL which leads to data loss. You can read more about the importance of testing your database migrations [here](get link to cheppells blog).

We will work through a step-by-step guide on setting up migration tests for the [PostgreSQL Pagila demo database](https://github.com/devrimgunduz/pagila) stored in [Amazon RDS](https://aws.amazon.com/rds/), in a [GitHub Actions](https://github.com/features/actions) pipeline. The logic can be applied to any other CI pipeline, and also SQL Server and MySQL databases.

All examples used can be found in [this demo repo](https://github.com/red-gate/flyway-spawn-demo) which you can clone and use as appropriate.

## Create a backup of your database

Firstly, we want to get a backup of our production database. This will ultimately be used to run migrations against later. Testing against real data will catch problems which may not arise from testing against an empty database.

1. Lets create a folder which will hold our backup file:

    <pre class="console"><span>&gt;</span> mkdir backups</pre>

1. Following the [PostgreSQL docs](https://www.postgresql.org/docs/current/app-pgdump.html), we'll run the following to get a database backup file saved to our folder as `pagila.sql`:

    <pre class="console"><span>&gt;</span> export PGPASSWORD=&lt;Password&gt;</pre>
    <pre class="console"><span>&gt;</span> pg_dump -h &lt;Host&gt; -p &lt;Port&gt; -U &lt;Username&gt; --file backups/pagila.sql</pre>

1. Using Spawn, we can turn this into a [data image](https://www.spawn.cc/docs/concepts-data-image) from our backup file, following the instructions [here](https://www.spawn.cc/docs/source-configuration-backup-postgres). First, we will create a source file `pagila-backup.yaml` **in the directory which contains the `backups` folder** with the following content:

    ```
    name: Pagila
    engine: postgresql
    version: 12.0
    sourceType: backup
    backup:
      folder: ./backups/
      file: pagila.sql
      format: plain
    tags:
      - prod
      - latest
    ```

1. The source file describes where the data and schema comes from. We can now create a data image from this:

    <pre class="console"><span>&gt;</span> spawnctl create data-image --file ./pagila-backup.yaml</pre>

This set up will allow us to create databases from the backup file - we'll come back to this later on in the tutorial.

## Write a GitHub Actions workflow

Lets create and set up our GitHub Actions workflow to test database migrations.

### Set up access token for Spawn

1. To access `spawnctl` in the pipeline, we will first need to create an [access token](https://spawn.cc/docs/spawnctl-accesstoken-create#tutorial) so that we won't be prompted to authenticate with Spawn in our CI environment:

    <pre class="console"><span>&gt;</span> spawnctl create access-token --purpose "CI system Spawn access token"
    Access token generated: &lt;access-token-string&gt;</pre>

1. Copy the `<access-token-string>` into your clipboard; you won't be able to retrieve it again. Now lets add it as a secret variable called `SPAWNCTL_ACCESS_TOKEN` in GitHub Actions by following this [tutorial](https://docs.github.com/en/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository).

### Create GitHub workflow

1. In your repository, add a file underneath the folder `.github/workflows` called `migration-test.yml`

1. Copy and paste the yaml below, then commit and push the new file:

    ```
    name: Database migration test

    on: workflow_dispatch

    jobs:
      run_migration_test:
        name: Run Flyway migration tests
        runs-on: ubuntu-latest
        steps:
          - name: Checkout
            uses: actions/checkout@v2
          - name: Run database migrations
            run: migration-test-prod.sh
            env:
              SPAWNCTL_ACCESS_TOKEN: ${{ secrets.SPAWNCTL_ACCESS_TOKEN }} 
    ```

1. This workflow is referencing a bash script `migration-test-prod.sh` which can be called from any CI pipeline as it is, and just work. Lets go ahead and create that script by copying the code below and saving the file at the root level of our directory:

    ```
    #!/bin/bash

    set -e

    echo "Downloading and installing spawnctl..."
    curl -sL https://run.spawn.cc/install | sh
    export PATH=$HOME/.spawnctl/bin:$PATH

    export SPAWN_PAGILA_IMAGE_NAME=Pagila:prod

    echo "Creating Pagila backup Spawn data container from image '$SPAWN_PAGILA_IMAGE_NAME'..."
    pagilaContainerName=$(spawnctl create data-container --image $SPAWN_PAGILA_IMAGE_NAME --lifetime 10m --accessToken $SPAWNCTL_ACCESS_TOKEN -q)

    pagilaJson=$(spawnctl get data-container $pagilaContainerName -o json)
    pagilaHost=$(echo $pagilaJson | jq -r '.host')
    pagilaPort=$(echo $pagilaJson | jq -r '.port')
    pagilaUser=$(echo $pagilaJson | jq -r '.user')
    pagilaPassword=$(echo $pagilaJson | jq -r '.password')

    echo "Successfully created Spawn data container '$pagilaContainerName'"

    docker run --net=host --rm -v $PWD/sql:/flyway/sql flyway/flyway migrate -url="jdbc:postgresql://$pagilaHost:$pagilaPort/pagila" -user=$pagilaUser -password=$pagilaPassword

    echo "Successfully migrated 'Pagila' database"

    spawnctl delete data-container $pagilaContainerName --accessToken $SPAWNCTL_ACCESS_TOKEN -q

    echo "Successfully cleaned up the Spawn data container '$pagilaContainerName'"
    ```    

1. Before committing and pushing this file to the repository, lets give it executable permissions:

    <pre class="console"><span>&gt;</span> chmod +x migration-test-prod.sh</pre>

This script accomplishes a few things. We are:
  * Installing Spawn to give us access to the `spawnctl` command from the pipeline agent
  * Creating a [Spawn data container](https://www.spawn.cc/docs/concepts-data-container) from the data image we created locally named `Pagila:prod`
  * Using the official [Flyway docker image](https://hub.docker.com/r/flyway/flyway) to run `flyway migrate` on our data container, using migration scripts stored under the `sql` folder
  * Automating the cleanup of the database

That it - that is our migration test. We have quickly provisioned a database instance from our back up using Spawn, and set the flyway connection details to point to that database and run the migration scripts in our repository. Any errors will be apparent here and show up on the developers Pull Request that this ran against.

Note: There is a [Flyway Migration action](https://github.com/marketplace/actions/flyway-migration) in the GitHub Marketplace which you can copy from. But using the code in `migrate-test.sh` is using generic bash and will work across all CI pipelines.

### Run Flyway migration tests

Once you've pushed all your changes to GitHub, you can now manually run the migration test workflow by navigating to the Actions tab in GitHub and clicking on 'Database migration test', then 'Run workflow'. Or, a more likely scenario, we want this to automatically run on a PR request so the development team can test that any new migrations will run against master before merging.

Add the following to the top of your `migration-test.yml` file:

```
# Controls when the action will run. 
on:
  # Triggers the workflow on push or pull request events but only for the main branch
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch
```
