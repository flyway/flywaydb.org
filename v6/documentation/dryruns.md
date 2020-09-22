---
layout: documentation
menu: dryruns
subtitle: Dry Runs
---
# Dry Runs
{% include pro.html %}

When Flyway migrates a database, it looks for migrations that need to be applied, sorts them and applies them in order
directly against the database.

This default behavior is great for the vast majority of the cases.
 
There are however situations where you may want to
- preview the changes Flyway will make to the database
- submit the SQL statements for review to a DBA before applying them
- use Flyway to determine what needs updating, yet use a different tool to apply the actual database changes

Flyway Pro and Enterprise Edition give you a way to achieve all these scenarios using **Dry Runs**.

## Implementation

When doing a Dry Run, Flyway sets up a read-only connection to the database. It assesses what migrations need to run and
generates a single SQL file containing all statements it would have executed in case of a regular migration
run. This SQL file can then be reviewed. If satisfactory, Flyway can then be instructed to migrate the database and
all changes will be applied. Alternatively a separate tool of your choice can also be used to apply the dry run SQL file
directly to the database without using Flyway. This SQL file also contains the necessary statements to create and update Flyway's
[schema history table](/documentation/migrations#schema-history-table), ensuring that all schema changes are tracked the usual way.

This works transparently with all other Flyway features including SQL and Java migrations, both versioned and repeatable,
callbacks, undo migrations, etc.  

## Configuration

When using the Flyway [command-line tool](/documentation/commandline), [Maven plugin](/documentation/maven) or
[Gradle plugin](/documentation/gradle), a SQL file contained the output of the dry run can be configured using the 
[`flyway.dryRunOutput`](/documentation/commandline/migrate#dryRunOutput) property.

When using the API directly, the dry run output can be configured using a `java.io.OutputStream`, giving you additional
flexibility.

As soon as this property is set, Flyway kicks in dry run mode. The database is no longer modified and all SQL statements
that would have been applied are sent to the dry run output instead.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate <i class="fa fa-arrow-right"></i></a>
</p>