---
layout: blog
subtitle: Introducing the shouldExecute script configuration option
permalink: /blog/shouldExecute.html
author: ajay
---

Have you ever wanted more customizable control over when your migrations are executed?

In Flyway 7.3.0 we released the `shouldExecute` script configuration option which lets you achieve just that!

## What is the shouldExecute option?

`shouldExecute` is a new script configuration option, and if you aren't already familiar with this concept you can read about it [here](/documentation/configuration/scriptconfigfiles).

With this new option, you gain the power to easily customize when a migration should execute. Unlike [skipExecutingMigrations](/documentation/configuration/parameters/skipExecutingMigrations), this will _not_ update the schema history table. 

In order to use this option, you first have to create a script configuration file which contains the line:

<pre><code>shouldExecute=<i>expression</i></code></pre>

_expression_ must evaluate to a boolean value, and it can be either `true`, `false`, or `A==B` where `A` and `B` are themselves values and not expressions.

At first glance `A==B` doesn't seem useful, but the power and customizability comes from... _drum roll_... placeholder replacement!

## Placeholders in expressions

If you'd like to brush up on your knowledge of placeholders, you can read about them [here](/documentation/configuration/placeholder).

The `shouldExecute` script configuration option supports placeholders within expressions. This means that the execution of migrations can be customized based on the values of easily modifiable placeholders. The `A==B` expression format begins to shine here, as it can be used with placeholders to control the execution of your migrations.

What better way to see this in action than with some examples!

## Examples

### Executing migrations in a specific schema

To control the execution of migrations based on the schema, we can use the `${flyway:defaultSchema}` default placeholder.

Let's say we have the following migrations:

```
V1__A_migration_1.sql
V2__B_migration_1.sql
V3__A_migration_2.sql
```

Migrations `V1` and `V3` should only be executed against schema `A`, and `V2` against schema `B`. We can achieve this by creating a script configuration file `V1__A_migration_1.sql.conf` for `V1` which contains the line `shouldExecute=${flyway:defaultSchema}==A`, and similarly for `V3`. The script configuration file for `V2` would have the line `shouldExecute=${flyway:defaultSchema}==B`.

With this, if we run `flyway migrate` then only `V1` and `V3` will be executed, and `V2` will be ignored.

### Customize execution with placeholders - injecting environments

When working with databases you often have different environments such as test, development, or production. In each of these environments you might want to execute different migrations, and this can now be achieved by injecting the environment with a placeholder!

Once again, let's say we have the following migrations:

```
V1__tst_migration_1.sql
V2__dev_migration_1.sql
V3__prd_migration_1.sql
```

Migration `V1` should only be executed in the `test` environment, `V2` in the `development` environment, and `V3` in the `production` environment. Migration `V1`'s script configuration file would need to contain the line `shouldExecute=${environment}==test`. `V2`'s will need the line `shouldExecute=${environment}==development` and `V3`'s will need the line `shouldExecute=${environment}==production`.

Now, if we set the value of the `${environment}` placeholder to contain the environment we are running Flyway in, we can achieve our desired result.

Running `flyway -placeholders.environment=test migrate` will only apply `V1`. Similarly `flyway -placeholders.environment=development migrate` will only apply `V2`, and `flyway -placeholders.environment=production migrate` will only apply `V3`.

### The benefit of setting `shouldExecute=false`

Initially it may not be obvious how hardcoding `false` for `shouldExecute` would be useful, since this just has the same effect as using [cherryPick](/documentation/configuration/parameters/cherryPick) with all of the migrations you do want to execute.

However, we quite often want to defer the execution of a long running migration so that it can run, for example, overnight. Using `cherryPick` can become unwieldy when the number of migrations you do want to execute is large. `cherryPick` also requires changing how you execute Flyway, which makes it less desirable in fully automated pipelines. Let's see how you can achieve this with `shouldExecute`!

For the last time, let's say we have the following migrations:

```
V1__shrt_migration_1.sql
V2__long_migration_1.sql
V3__shrt_migration_2.sql
```

In this example, let's also assume that we have a basic automated pipeline running `flyway migrate` on each commit to version control.

Since migration `V2` takes too long to execute during a work day, we decide to execute it overnight, but don't want to delay executing `V1` and `V3`. We can still execute migrations `V1` and `V3`, but first need to create a script configuration file `V2__long_migration_1.sql.conf` for `V2` with the line `shouldExecute=false`. When we commit this to version control, migrations `V1` and `V3` will automatically be applied, ignoring `V2`. 

When we reach the end of the day and decide it's time to apply `V2`, we can modify the script configuration file and remove the line containing `shouldExecute=false` since the default value is `true`. We also need to modify the Flyway configuration file and set `outOfOrder=true`. Once we commit this, migration `V2` will automatically begin execution in our pipeline.

We have successfully deferred migration execution in an automated pipeline without changing how we call Flyway!

## Try it out!

You can do some pretty cool things with `shouldExecute`! If you're an existing Flyway Teams user, try it out! If this is something you'd like to experiment with, head on over to [download](/download/) in order to start your free trial today!
