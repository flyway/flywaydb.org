---
layout: documentation
menu: tut_batch
subtitle: 'Tutorial: Batch'
---
# Tutorial: Batching
{% include teams.html %}

This brief tutorial will teach you **how to use the flyway batch command**.

## Introduction

Batching allows multiple `INSERT`, `UPDATE`, `DELETE`, `MERGE`, and `UPSERT` statements in a migration script to be sent over the wire to the database server in one go.

Batching can save up to 99 percent of network roundtrips by sending up to 100 statements at once over the network to the database, instead of sending each statement individually.

This is particularly useful for very large SQL migrations composed of multiple MB or even GB of reference data, as this can dramatically reduce the network overhead.

## Setting up the database

We will use [Spawn](https://spawn.cc) to create a database for this tutorial. Run the following command:

<pre class="console"><span>&gt;</span> spawnctl create data-container \
  --image postgres:flyway-getting-started \
  --name flyway-batch \
  --lifetime 24h</pre>

This will return the connection string details which are used to connect and query using your normal tools:

<pre class="console">Data container 'flyway-container' created!
-> Host=instances.spawn.cc;Port=xxxxx;Username=xxxx;Database=foobardb;Password=xxxxxxxxx</pre>

You can retrieve these details at any time by running:

<pre class="console"><span>&gt;</span> spawnctl get data-container flyway-container -o yaml</pre>

Configure Flyway by editing `./flyway.conf` with your Spawn data container connection details, like this:

```properties
flyway.url=jdbc:postgresql://instances.spawn.cc:<Port>/foobardb
flyway.user=<User>
flyway.password=<Password>
```

Flyway is now configured to use the correct database.

## Create a batchable migration

First, create a `./sql` directory in your current working directory and create a flyway migration called `V1__create-person-table.sql`:

```sql
CREATE TABLE Person (
    ID int not null,
    NAME varchar(100) not null
);
```

Apply the migration with `flyway migrate`:

```bash
$ flyway migrate
```

Now that we have applied the migration we can save the state of the database so that we can revert back to this state later:

```bash
$ spawnctl save data-container flyway-container
```

Next, we will use a short script, `generate.sh` , to generate a large migration script suitable for batching:

```bash
#! /bin/sh

numRows=${1:-100}

i=1
while [ $i -le $numRows ]; do
  echo "INSERT INTO Person (ID, NAME) values ($i, 'Person $i');"
  i=$((i+1))
done
```

Execute the script with an argument of 1000 to generate a migration script:

```bash
$ ./generate.sh 1000 > ./sql/V2__insert-data.sql
```

The script might take a few seconds to run and will generate a migration script containing 1000 `INSERT` statements.

## Apply the script without batching

To demonstrate the value of batching a migration, we will first run the migration without batching:

```bash
$ time flyway migrate
```

This will produce output similar to the following (your timings will vary slightly):
<pre class="console">
Flyway Teams Edition 7.11.2 by Redgate
Database: jdbc:postgresql://instances.spawn.cc:32014/ (PostgreSQL 11.0)
----------------------------------------
Flyway Teams features are enabled by default for the next 27 days. Learn more at https://flywaydb.org?ref=v7.11.2_teams
----------------------------------------
Successfully validated 2 migrations (execution time 00:00.097s)
Current version of schema "public": 1
Migrating schema "public" to version "2 - insert data"
Successfully applied 1 migration to schema "public", now at version v2 (execution time 00:20.544s)

real    0m24.051s
user    0m5.258s
sys     0m0.538s</pre>

This shows that appyling the migration without batching took 24 seconds.

Running `flyway info` will now show that both migrations have been run:

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:31585/ (PostgreSQL 11.0)

+-----------+---------+---------------------+------+---------------------+---------+----------+
| Category  | Version | Description         | Type | Installed On        | State   | Undoable |
+-----------+---------+---------------------+------+---------------------+---------+----------+
| Versioned | 1       | Create person table | SQL  | 2017-12-17 19:57:28 | Success | No       |
| Versioned | 2       | Insert data         | SQL  | 2017-12-17 20:01:13 | Success | No       |
+-----------+---------+---------------------+------+---------------------+---------+----------+</pre>

## Apply the script using batching

We'll revert the database back to the state before we applied the `./sql/V2__insert-data.sql` migration:

```bash
$ spawnctl reset data-container flyway-container
```

Rerunning `flyway info` once again shows that only the first migration has been applied:

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:31585/ (PostgreSQL 11.0)

+-----------+---------+---------------------+------+---------------------+---------+----------+
| Category  | Version | Description         | Type | Installed On        | State   | Undoable |
+-----------+---------+---------------------+------+---------------------+---------+----------+
| Versioned | 1       | Create person table | SQL  | 2017-12-17 19:57:28 | Success | No       |
| Versioned | 2       | Insert data         | SQL  |                     | Pending | No       |
+-----------+---------+---------------------+------+---------------------+---------+----------+</pre>

Now edit the `/flyway.conf` file to enable batching by appending this line to the end of the file:

```properties
flyway.batch=true
```

And rerun `flyway migrate`:

```bash
$ time flyway migrate
```

<pre class="console">
Flyway Teams Edition 7.11.2 by Redgate
Database: jdbc:postgresql://instances.spawn.cc:32014/ (PostgreSQL 11.0)
----------------------------------------
Flyway Teams features are enabled by default for the next 27 days. Learn more at https://flywaydb.org?ref=v7.11.2_teams
----------------------------------------
Successfully validated 2 migrations (execution time 00:00.089s)
Current version of schema "public": 1
Migrating schema "public" to version "2 - insert data"
Successfully applied 1 migration to schema "public", now at version v2 (execution time 00:01.005s)

real    0m4.814s
user    0m4.541s
sys     0m0.399s</pre>

With batching enabled the migration only took ~5 seconds to run.

## Summary

In this brief tutorial we saw how to:
* use flyway [batch](https://flywaydb.org/documentation/configuration/parameters/batch) to batch migration scripts for better performance.
* use [Spawn](https://spawn.cc) to save and reset databases.

