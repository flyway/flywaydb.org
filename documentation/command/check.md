---
layout: documentation
menu: check
subtitle: Check
---

# Check

{% include enterprise.html %}

`check` produces reports to increase confidence in your migrations.

For `-changes` and `-drift`, Flyway migrates against a build database and compares this against the target database in order to generate a report.
**This build database will be cleaned before it is used, so you must ensure it does not contain anything of importance.**

You can read more about the `check` concept [here](/documentation/concepts/check).

#### Requirements
- .NET 6 is required in order to generate reports. You can download it from [here](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).
- `sqlfluff` is required for Code Analysis (`-code`). You can install it by running `pip3 install sqlfluff`.

#### Flags:
- _One or more flags must be present_

| Parameter                     | Description
| ----------------------------- | --------------------------------------------------------------
|    -changes                   |  Include pending changes that will be applied to the database
|    -drift                     |  Include changes applied out of process to the database
|    -code                      |  **In Preview** Performs code analysis on your migrations
|    -dryrun                    |  Performs a [dry run](/documentation/concepts/dryruns), showing what changes would be applied in a real deployment

#### Configuration parameters:
 _Format: -key=value_

| Parameter                     | Description
| ----------------------------- | -----------------------------------------------------------
|    check.buildUrl             | URL for a build database.
|    check.buildUser            | Username for the build database. Defaults to 'flyway.user'
|    check.buildPassword        | Password for the build database. Defaults to 'flyway.password'
|    check.reportFilename       | **[REQUIRED]** Destination filename for reports
|    check.nextSnapshot         | A snapshot containing all migrations including those that are pending (generated via [`snapshot`](/documentation/command/snapshot))
|    check.deployedSnapshot     | A snapshot containing all applied migrations and thus matching what should be in the target (generated via [`snapshot`](/documentation/command/snapshot))
|    check.appliedMigrations    | A comma-separated list of migration ids (migration versions or repeatable descriptions) to apply to create snapshots (generated via [`info`](/documentation/command/info))

#### `check.reportFilename`

If this filename does not have the `.html` suffix, Flyway will add it for you. Flyway also produces a `json` result for programmatic consumption.

#### Usage Example:
```
flyway check -changes -url=jdbc:example:database -user=username -password=password -check.buildUrl=jdbc:example:build_database
```

##### Example configuration file

```properties
flyway.url=jdbc:example:database
flyway.user=username
flyway.password=password
flyway.check.buildUrl=jdbc:example:build_database
flyway.check.reportFilename=change_report
```

#### Database Support

##### `-changes` and `-drift`

Change and drift reports work on the following databases:

- SQL Server
- PostgreSQL
- Oracle
- SQLite

##### `-code` and `-dryrun`

Code analysis and Dry run reports work on any database supported by Flyway.

##### Check for Oracle

When using Check with an Oracle database there are additional requirements.

If no schemas are specified in the configuration `flyway.schemas`, then the database connection username will be used as the default schema, otherwise `flyway.schemas` will be used.
These schema names are case-sensitive.
