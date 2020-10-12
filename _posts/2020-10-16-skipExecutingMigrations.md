---
layout: blog
subtitle: Skip Executing Migrations Examples
permalink: /blog/skipExecutingMigrations.html
author: philip
---

As you've likely seen we recently released **Flyway 7.0.0**, containing a lot of new features (read more about what features are available in the [blog post](/blog/flyway-7.0.0)).

One of the new features is the new **Flyway Teams** configuration parameter [skipExecutingMigrations](/documentation/configuration/parameters/skipExecutingMigrations). This configuration parameter changes migrate to skip executing the contents of the migrations during a `flyway migrate` or `flyway undo`, instead just updating the schema history table. In this blog post we want to go into more details on some example uses of this parameter.

## Hotfixes

In an ideal world, every change to the databases managed by Flyway would be done via a migration. This ensures consistency across all databases in the pipeline, and stops there being any drift. However, in practice this is difficult to achieve. There are always cases where something goes wrong in production, and a hotfix needs to be applied. 

For example, consider this setup:

The Flyway project has 3 migrations
```
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
```

And 3 environments, each with all 3 migrations applied
```
dev: 1,2,3
test: 1,2,3
prod: 1,2,3
```

Now it turns out that `V3` has a critical flaw not caught by the test environment, and a hotfix needs to be applied directly to production to minimize the delay in fixing it. Prod has how drifted away from the other environments, and to continue development the other environments need to be brought back into sync.

Ideally, the changes made for the hotfix would be added to a new migration (e.g. `V3.1__view_hotfix.sql`). This could then be added to the other migrations, and a `flyway migrate` would then bring the other environments into sync.

```
Migrations:
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
V3.1__view_hotfix.sql

Environments:
dev: 1,2,3,3.1
test: 1,2,3,3.1
prod: 1,2,3 -- error!
```

However, when you then try to `migrate` on prod, the migration would fail, as the changes applied by the hotfix already exist!

This is where `skipExecutingMigrations` comes in. On prod instead of running a normal `migrate`, instead run `migrate -skipExecutingMigrations=true`. Now Flyway will not actually try to execute the contents of the migration on this environment, instead just updating the schema history to say it's been applied. Now all the environments are back in sync, and development can continue.

```
Migrations:
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
V3.1__view_hotfix.sql

Environments:
dev: 1,2,3,3.1
test: 1,2,3,3.1
prod: 1,2,3,3.1
```

## Migration Generation

In some cases developers don't want to write SQL themselves, preferring to edit a database using an IDE like [Oracle SQL Developer](https://www.oracle.com/database/technologies/appdev/sqldeveloper-landing.html), [SQL Server Management Studio](https://docs.microsoft.com/en-us/sql/ssms/sql-server-management-studio-ssms?view=sql-server-ver15), or similar. The issue with this approach, however, is that when those changes are turned into a migration (maybe by using a tool such as [Schema Compare for Oracle](https://www.red-gate.com/products/oracle-development/schema-compare-for-oracle/) or [SQL Compare](https://www.red-gate.com/products/sql-development/sql-compare/)) they cannot be applied to the same database they were created from, as the changes already exist. Using `skipExecutingMigrations` Flyway can now support this workflow.

Consider the following project, consisting of 3 migrations.

```
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
```

Now a developer can check out this project, and apply the changes to a local dev database. Then they can open the database in an IDE of their choice and make edits to it. Once they are satisfied with the changes they can use a tool to generate a migration script from their changes, and save it as a new migration on disk.

```
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
V4__new_changes.sql
```

Migration `V4` can't be applied to the developer's own database as the changes already exist. In this case the developer can then run `migrate -skipExecutingMigrations=true` to mark the migration as applied locally. The migration can then be committed to VCS, and any other developer can update and apply the migration without a problem to their own dev instances.


## Deferred migration execution

In more complex projects, it is sometimes desirable to have more control over *when* a migration is executed (such as during down time), out of order from the other migrations. This could be because the migration takes a long time to execute, it's deemed too risky by the dba and wants to be skipped for now, or many other reasons. 

Consider the following project, with 4 migrations, along with corresponding undo migrations.

```
V13__perform_a_very_slow_operation.sql
V14__create_more_things.sql
V15__shuffle_things.sql
V16__create_things.sql

U13__undo_a_very_slow_operation.sql
U14__delete_more_things.sql
U15__unshuffle_things.sql
U16__delete_things.sql
```

In this example, `V13` takes a very long time to execute, and the DBA decided that the best time to execute the migration is during the quiet period at the weekend. However, the rest of the migrations still need to be applied immediately.

Before Flyway 7.0.0, the only answer would be to delete the migration from disk (and VCS, just in case an accidental `migrate` applies it before the DBA is ready), and reintroduce it once it is desirable again to apply it. Pretty fiddly!

With `skipExecutingMigrations` however this is much easier to manage. First, the DBA can mark the migration to be skipped: 

`migrate -target=13 -skipExecutingMigrations=true`. 

Then a `migrate` can be used to apply the rest of the migrations.

Now, when the time comes to actually run the migration for real, the DBA can selectively undo the skipped migrations using [cherryPick](/documentation/configuration/parameters/cherryPick) and `skipExecutingMigrations`, marking it as pending once again without actually running any of the undo script:

`flyway undo -cherryPick=13 -skipExecutingMigrations=true`

Now a `migrate -outOfOrder=true` will execute the `V13` migration that was delayed.


## Intermediate baseline

As a project grows in size, constructing the databases used in various temporary environments (such as dev or test) becomes harder to manage via a normal `migrate`. Instead of applying a vast number of migrations to setup the database, it may become more desirable to create the database via other means. This could be a new migration that does the same thing all the previous migrations did in a more efficient way, restoring from some form of image or backup, or something else. No matter what method is chosen, the problem of what to do with the existing migration files remains.

The simplest solution would be to delete the old migrations, but this abandons all support for existing databases that have not yet been migrated beyond this new 'baseline' point. It could also introduce confusion on the version naming (e.g. "Why do our migrations start from version 8.2?"). Luckily `skipExecutingMigrations` can provide a better solution.

Lets say we have a project with 6 migrations:
```
V1__create_tables.sql
V2__modify_tables.sql
V3__create_views.sql
V3.1__view_hotfix.sql
V3.2__another_hotfix.sql
V4__create_everything_properly.sql
```

In this project we have made a `V4` do everything that `V1` -> `V3.2` did, but more efficiently and cleaner. When we create a new dev environment we don't want to run anything before `V4`.

First we run `migrate -target=3.2 -skipExecutingMigrations=true`. This marks everything before `V4` as applied, without actually executing the contents of the migrations. Now we can just run `migrate` normally to apply everything `V4` and beyond normally.

You could also further configure the migrations to skip using [cherryPick](/documentation/configuration/parameters/cherryPick).


\- philip