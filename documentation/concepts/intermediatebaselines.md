---
layout: documentation
menu: intermediatebaselines
subtitle: Intermediate Baselines
---
# Intermediate Baselines
{% include teams.html %}

Over the lifetime of a project, many database objects may be created and destroyed across many migrations which leaves behind a lengthy history of migrations that need to be applied in order to bring a new environment up to speed.

Instead, you might wish to add a single, cumulative migration that represents the state of your database after all of those migrations have been applied without disrupting existing environments.

[Flyway Teams Edition](/try-flyway-teams-edition) gives you a way to achieve this using **Intermediate Baseline Migrations**.

## How it works

Once you decide it's time to add such a cumulative migration, instead of making it a regular [versioned migration](/documentation/concepts/migrations#versioned-migrations) it should be an intermediate baseline migration, which is prefixed with `IB` instead of `V`.

With this prefix, these new migrations won't disrupt existing deployment pipelines and new environments will choose the latest intermediate baseline migration as the starting point when you run `migrate`. Every migration with a version below the latest intermediate baseline migration's version is marked as `below baseline`. <br/>
Note that repeatable migrations are executed as normal.

This mechanism is fully automated and requires no modification in your pipeline to begin using. Simply add your intermediate baseline migrations when you need them and they will be utilized.

## Configuration

The `IB` prefix is configurable with the [intermediateBaselineSqlMigrationPrefix](/documentation/configuration/parameters/intermediateBaselineSqlMigrationPrefix) parameter.

## Tutorial

Click [here](/documentation/tutorials/intermediateBaselines) to see a tutorial on using intermediate baselines.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate<i class="fa fa-arrow-right"></i></a>
</p>
