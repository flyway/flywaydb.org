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

