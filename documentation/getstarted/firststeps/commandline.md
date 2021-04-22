---
layout: documentation
menu: commandline
subtitle: Flyway Command-line - First Steps
redirect_from: /getStarted/firststeps/commandline/
---

# First Steps: Command-line

This brief tutorial will teach **how to get up and running with the Flyway Command-line tool**. It will take you through the
steps on how to configure it and how to write and execute your first few database migrations, using [Spawn](https://spawn.cc/)
to provision a database instance without the need for installing any database engines onto your own machine. You can create MySQL,
MSSQL and PostgreSQL databases with Spawn that will work with Flyway.

This tutorial should take you about **10 minutes** to complete.

## Prerequisites

Start by [downloading the Flyway Command-line Tool](/download) for your platform and extract it.

Install Spawn by visiting the [getting started documentation](https://www.spawn.cc/docs/getting-started.html) and following
the installation steps.

## Configuring Flyway

To configure Flyway, we first need a database we can connect to. We’ll use Spawn to create your own, isolated database environment
from which you can run migrations against. This will create you your first data container, which is your database instance. Here we
are specifying a PostgreSQL database but you can also specify `mysql:flyway-getting-started` or `mssql:flyway-getting-started`:

<pre class="console"><span>&gt;</span> spawnctl create data-container --image postgres:flyway-getting-started --name flyway-container</pre>

This will return connection string details which is used to connect and query using your normal tools:

<pre class="console">Data container 'flyway-container' created!
-> Host=instances.spawn.cc;Port=xxxxx;Username=xxxx;Database=foobardb;Password=xxxxxxxxx</pre>

You can retrieve these details at any time by running:

<pre class="console"><span>&gt;</span> spawnctl get data-container flyway-container -o yaml</pre>

Let's now jump into our new directory created from downloading Flyway:

<pre class="console"><span>&gt;</span> cd flyway-{{ site.flywayVersion }}</pre>

Configure Flyway by editing `/conf/flyway.conf` with your Spawn data container connection details, like this:

```properties
flyway.url=jdbc:postgresql://instances.spawn.cc:<Port>/foobardb
flyway.user=<User>
flyway.password=<Password>
```

## Creating the first migration

Now create your first migration in the `/sql` directory called `V1__Create_person_table.sql`:

```sql
create table PERSON (
    ID int not null,
    NAME varchar(100) not null
);
```

## Migrating the database

It's now time to execute Flyway to migrate your database:

<pre class="console"><span>flyway-{{ site.flywayVersion }}&gt;</span> flyway <strong>migrate</strong></pre>

If all went well, you should see the following output:

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;Port&gt;/foobardb (PostgreSQL 11.0)
Successfully validated 1 migration (execution time 00:00.008s)
Creating Schema History table: "PUBLIC"."flyway_schema_history"
Current version of schema "PUBLIC": << Empty Schema >>
Migrating schema "PUBLIC" to version 1 - Create person table
Successfully applied 1 migration to schema "PUBLIC" (execution time 00:00.033s)</pre>

## Adding a second migration

If you now add a second migration to the `/sql` directory called `V2__Add_people.sql`:

<pre class="prettyprint">insert into PERSON (ID, NAME) values (1, 'Axel');
insert into PERSON (ID, NAME) values (2, 'Mr. Foo');
insert into PERSON (ID, NAME) values (3, 'Ms. Bar');</pre>

and execute it by issuing:

<pre class="console"><span>flyway-{{ site.flywayVersion }}&gt;</span> flyway <strong>migrate</strong></pre>

You now get:

<pre class="console">Database: jdbc:postgresql://instances.spawn.cc:&lt;Port&gt;/foobardb (PostgreSQL 11.0)
Successfully validated 2 migrations (execution time 00:00.018s)
Current version of schema "PUBLIC": 1
Migrating schema "PUBLIC" to version 2 - Add people
Successfully applied 1 migration to schema "PUBLIC" (execution time 00:00.016s)</pre>

Any time you want to reset your database back to its original state, in this case an empty instance, you can run a
reset command on your Spawn data container:

<pre class="console"><span>&gt;</span> spawnctl reset data-container flyway-container</pre>

You can then re-run `migrate` on your database.

## Summary

In this brief tutorial we saw how to:
- install the Flyway Command-line tool and Spawn
- configure it so it can talk to our Spawn database
- write our first couple of migrations

These migrations were then successfully found and executed.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/usage/commandline">Read the documentation <i class="fa fa-arrow-right"></i></a>
</p>
