---
layout: documentation
menu: statescripts
subtitle: State Scripts
---
# State Scripts
{% include teams.html %}

Over the lifetime of a project, many database objects may be created and destroyed across many migrations which leaves behind a lengthy history of migrations that need to be applied in order to bring a new environment up to speed.

Instead, you might wish to add a single, cumulative script that represents the state of your database after all of those migrations have been applied without disrupting existing environments.

[Flyway Teams Edition](/try-flyway-teams-edition) gives you a way to achieve this using **State Scripts**.

## How it works

State scripts are prefixed with `S` followed by the version of your database they represent. For example: `S5__my_database.sql` represents the state of your database after applying all versioned migrations up to and including `V5`.

State scripts are only used when deploying to new environments. If used in an environment where some Flyway migrations have already been applied, state scripts will be ignored. New environments will choose the latest state script as the starting point when you run `migrate`. Every migration with a version below the latest state script's version is marked as `ignored`. <br/>
Note that:
- repeatable migrations are executed as normal
- state scripts do not replace versioned migrations - you can have both a state script and a versioned migration at the same version

This mechanism is fully automated and requires no modification in your pipeline to begin using. Simply add your state scripts when you need them and they will be utilized.

## Configuration

The `S` prefix is configurable with the [stateScriptsPrefix](/documentation/configuration/parameters/stateScriptsPrefix) parameter.

## Tutorial

Click [here](/documentation/tutorials/stateScripts) to see a tutorial on using state scripts.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate<i class="fa fa-arrow-right"></i></a>
</p>
