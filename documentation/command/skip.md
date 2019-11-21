---
layout: documentation
menu: skip
subtitle: Skip
---
# Skip

Mark all pending versioned migrations to skip in the schema history table. Skipped migrations will be ignored on next `migrate`.

Note that the pending migrations are determined by the `target` configuration option.

![Skip](/assets/balsamiq/command-skip.png)

### Ad-hoc changes

Skip allows you to bring an ad-hoc change into a Flyway migration. It supports the following workflow:

- Run a script manually against a database (e.g. a hotfix)
- Add a new Flyway migration which represents these changes
- Run `flyway skip` against the database

The new migration will be ignored only on the database `flyway skip` is run against. Therefore the new migration can still be run in other environments.

## Use Skip instead of Baseline

The Baseline command is now deprecated.

Baseline was for introducing Flyway to [existing databases](/documentation/existing). It allowed a specific version to be set as the 'baseline'. This would cause [Migrate](/documentation/command/migrate) to ignore all migrations up to and including the baseline version. Newer migrations would then be applied as usual.

The equivalent behavior can be achieved with Skip:

`flyway baseline -baselineVersion=3` => `flyway skip -target=3`

Baseline allowed any version as the `baselineVersion`, whether or not a migration existed for that version. Skip requires a migration to exist in order for it to be marked as skipped. Therefore, for a deployment against an existing database, migrations that represent the 'baseline' must exist in order for them to be marked as skipped.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/">Command-line <i class="fa fa-arrow-right"></i></a>
</p>