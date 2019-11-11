---
layout: documentation
menu: skip
subtitle: Skip
---
# Skip

Mark versioned migrations to skip in the schema history table. Skipped migrations will be ignored for every subsequent `migrate`. The migrations to skip are configured with the `skipVersions` configuration option.

![Skip](/assets/balsamiq/command-skip.png)

Skip is useful in situations where you have applied ad-hoc changes to a production database. You may then write a migration 
that reproduces these changes and apply them with Flyway in your development and test environments; marking them as
skipped on the production database prevents them being re-applied.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/">Command-line <i class="fa fa-arrow-right"></i></a>
</p>