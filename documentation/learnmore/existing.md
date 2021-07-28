---
layout: documentation
menu: existing
subtitle: Existing Database Setup
redirect_from: /documentation/existing/
---

# Existing Database Setup

These are the steps to follow to successfully integrate Flyway into a project with existing databases.

To guide you through the process, we'll show examples using [Spawn](/documentation/spawn){:target="_blank"} to quickly provision database instances that will represent our Development and Production environments.

## Prerequisites

If you are new to Flyway, read through our [getting started](/documentation/getstarted/) section first.

To follow along with the examples, [install Spawn](/documentation/spawn/firststeps/installation){:target="_blank"} and run the following commands to create our Development and Production instances:

<pre class="console">&gt; spawnctl create data-container \
  --image postgres:flyway-existing-database \
  --name flyway-container-dev \
  --lifetime 24h</pre>

<pre class="console">&gt; spawnctl create data-container \
  --image postgres:flyway-existing-database \
  --name flyway-container-prod \
  --lifetime 24h</pre>

This will return connection string details for each PostgreSQL instance which are used when connecting with Flyway and can be queried with your normal tools:

<pre class="console">Data container 'flyway-container-dev' created!
-> Host=instances.spawn.cc;Port=&lt;DevPort&gt;;Username=&lt;DevUsername&gt;;Database=pagila;Password=&lt;DevPassword&gt;</pre>

<pre class="console">Data container 'flyway-container-prod' created!
-> Host=instances.spawn.cc;Port=&lt;ProdPort&gt;;Username=&lt;ProdUsername&gt;;Database=pagila;Password=&lt;ProdPassword&gt;</pre>

You can retrieve these details at any time by running:

<pre class="console">&gt; spawnctl get data-containers -o yaml</pre>

We now have two identical but isolated and disposable database instances to use in our examples. Under each section below, you will find an `Example` section with steps to follow.

## Extract the DDL and reference data from production

First start by taking a snapshot of your most important database: production. This will be the starting point for migrations.

Generate a SQL script that includes the entire DDL (including indexes, triggers, procedures ...) of the production database. To do this you will need to add insert statements for all of the reference data present in the database.

This script will form your baseline migration. Save it in a location specified in the [locations](/documentation/configuration/parameters/locations) property. Give it a relevant version number and description such as `V1__baseline_migration.sql`.

### Example

You can download a sample baseline migration for our example database [here](/assets/tutorial/V1__baseline_migration.sql). Create a new directory `flyway-tutorial`, download the migration into the new directory and switch to it:

<pre class="console">&gt; cd flyway-tutorial</pre>

## Clean all databases containing data you don't mind losing

Now comes the point where we have to make sure that the migrations meant for production will work everywhere with the [clean](/documentation/command/clean) command.

For all databases with unimportant data that you don't mind losing, execute:
<pre class="console">&gt; flyway clean</pre>
by altering the [url](/documentation/configuration/parameters/url) to completely remove their contents.

### Example

In this example, we don't mind losing data in the Development database so we will [clean](/documentation/command/clean) it. Using the connection details from our `flyway-container-dev` container we can run:

<pre class="console">&gt; flyway clean -url="jdbc:postgresql://instances.spawn.cc:&lt;DevPort&gt;/pagila" \
  -user="&lt;DevUsername&gt;" -password="&lt;DevPassword&gt;"</pre>

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;DevPort&gt;/pagila (PostgreSQL 11.0)
Successfully dropped pre-schema database level objects (execution time 00:00.001s)
Successfully cleaned schema "public" (execution time 00:01.404s)
Successfully dropped post-schema database level objects (execution time 00:00.000s)</pre>

## Align the databases not cleaned with production

Now you need to check all remaining databases (e.g. test). You must make sure that their structure (DDL) and reference data matches production exactly. This step is important, as all scripts destined for production will likely be applied to these databases first. For the scripts to succeed, the objects they migrate must be identical to what is present in production.

### Example

We only have the Production database that isn't being cleaned and therefore have nothing to align.

### Give these databases a baseline version

Now comes the time to [baseline](/documentation/command/baseline) the databases that contain data (including production) with a baseline version. Use the same version and description you used for the baselined migration above (`V1__baseline_migration.sql`).

You can accomplish it like this:
<pre class="console">&gt; flyway -baselineVersion="1" -baselineDescription="baseline_migration" baseline</pre>
You must perform this step for each database that hasn't been cleaned by altering the [url](/documentation/configuration/parameters/url) again.

### Example

The Production database needs to be baselined in our example, for which we can run:

<pre class="console">&gt; flyway baseline -baselineVersion="1" -baselineDescription="baseline_migration" \
  -url="jdbc:postgresql://instances.spawn.cc:&lt;ProdPort&gt;/pagila" \
  -user="&lt;ProdUsername&gt;" -password="&lt;ProdPassword&gt;" -locations="filesystem:."</pre>

This should give an output similar to:

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;ProdPort&gt;/pagila (PostgreSQL 11.0)
Creating Schema History table "public"."flyway_schema_history" with baseline ...
Successfully baselined schema with version: 1</pre>

## Done!

Congratulations! You are now ready.

When you execute:

<pre class="console">&gt; flyway migrate</pre>

against the empty databases (by altering the [url](/documentation/configuration/parameters/url)), they will be migrated to the state of production and the others will be left as is.

As soon as you add a new migration, it can be applied identically to any of your databases.

### Example

Looking at our databases, we have Production baselined and in line with our migration scripts. The Development database has been cleaned and so is not in line. If we now run migrate against each database it will align them. Migrate isn't strictly needed at this point for Production, however it will highlight that there is no work to be done as the baseline has been configured correctly.

First we should migrate our Development database:

<pre class="console">&gt; flyway migrate -url="jdbc:postgresql://instances.spawn.cc:&lt;DevPort&gt;/pagila" \
  -user="&lt;DevUsername&gt;" -password="&lt;DevPassword&gt;" -locations="filesystem:."</pre>

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;Port&gt;/pagila (PostgreSQL 11.0)
Successfully validated 1 migration (execution time 00:00.087s)
Creating Schema History table "public"."flyway_schema_history" ...
Current version of schema "public": << Empty Schema >>
Migrating schema "public" to version "1 - baseline migration"

...

Successfully applied 1 migration to schema "public", now at version v1 (execution time 00:04.962s)</pre>

As expected, Flyway recognised that the database has an empty schema and therefore created the `flyway_schema_history` table and ran our baseline migration.

Now to migrate the Production database:

<pre class="console">&gt; flyway migrate -url="jdbc:postgresql://instances.spawn.cc:&lt;ProdPort&gt;/pagila" \
  -user="&lt;ProdUsername&gt;" -password="&lt;ProdPassword&gt;" -locations="filesystem:."</pre>

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;Port&gt;/pagila (PostgreSQL 11.0)
Successfully validated 1 migration (execution time 00:00.111s)
Current version of schema "public": 1
Schema "public" is up to date. No migration necessary.</pre>

We can see that our Production database is already at version `1` which matches the `-baselineVersion` we specified to the `baseline` command. This means it is up to date with our migration scripts and nothing needs to be run.

### Next steps

If you have followed our examples and are ready to integrate Flyway into your own database, don't forget that [Spawn](https://spawn.cc) is available for free to create fast, isolated copies for development and testing of your own databases. This enables you to perfect the baselining process on a copy of Production before touching the real database. You can find out how to create a data image of your own database [here](https://spawn.cc/docs/source-configuration-backup-postgres).

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/configuration/envvars">Environment Variables<i class="fa fa-arrow-right"></i></a>
</p>
