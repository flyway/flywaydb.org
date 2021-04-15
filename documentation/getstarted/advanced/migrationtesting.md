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

