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

Once you decide it's time to add such a cumulative script, instead of making it a regular [versioned migration](/documentation/concepts/migrations#versioned-migrations) it should be a state script, which is prefixed with `S` instead of `V`.

With this prefix, these new scripts won't disrupt existing deployment pipelines and new environments will choose the latest state script as the starting point when you run `migrate`. Every migration with a version below the latest state script's version is marked as `below baseline`. <br/>
Note that repeatable migrations are executed as normal.

This mechanism is fully automated and requires no modification in your pipeline to begin using. Simply add your state scripts when you need them and they will be utilized.

## Configuration

The `S` prefix is configurable with the [stateScriptsPrefix](/documentation/configuration/parameters/stateScriptsPrefix) parameter.

## Tutorial

Click [here](/documentation/tutorials/stateScripts) to see a tutorial on using state scripts.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate<i class="fa fa-arrow-right"></i></a>
</p>
