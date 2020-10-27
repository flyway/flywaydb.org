---
layout: documentation
menu: dryruns
subtitle: Dry Runs
redirect_from: /documentation/dryruns/
---
# Dry Runs
{% include teams.html %}

When Flyway migrates a database, it looks for migrations that need to be applied, sorts them and applies them in order
directly against the database.

This default behavior is great for the vast majority of the cases.
 
There are however situations where you may want to
- preview the changes Flyway will make to the database
- submit the SQL statements for review to a DBA before applying them
- use Flyway to determine what needs updating, yet use a different tool to apply the actual database changes

Flyway Teams Edition give you a way to achieve all these scenarios using **Dry Runs**.

## How it works

When doing a Dry Run, Flyway sets up a read-only connection to the database. It assesses what migrations need to run and
generates a single SQL file containing all statements it would have executed in case of a regular migration
run. This SQL file can then be reviewed. If satisfactory, Flyway can then be instructed to migrate the database and
all changes will be applied. Alternatively a separate tool of your choice can also be used to apply the dry run SQL file
directly to the database without using Flyway. This SQL file also contains the necessary statements to create and update Flyway's
[schema history table](/documentation/concepts/migrations#schema-history-table), ensuring that all schema changes are tracked the usual way.

It is not advised to change a dry run script after it's been generated. Instead, any changes should be made to the migrations and a new dry run script generated. This is to ensure the changes executed match what's in your migrations.

### Exceptions

Not every change is intercepted in a Dry Run. Some changes cannot be intercepted and will be executed as normal. Details are provided;

#### Intercepted in Dry Run

These changes are intercepted and written into a file as explained above.

- SQL versioned migrations
- SQL repeatable migrations
- SQL callbacks

#### Not intercepted in Dry Run

These changes will be executed as normal during a Dry Run. **The schema history table will not be updated, so Flyway will have no record of execution.** Be sure you're aware of the side effects when performing a Dry Run if you Flyway project contains such changes.

- [Arbitrary script migrations](/documentation/concepts/migrations#script-migrations)
- [Arbitrary script callbacks](/documentation/concepts/migrations#script-migrations)
- [Java migrations](/documentation/concepts/migrations#java-based-migrations)

## Configuration

When using the Flyway [command-line tool](/documentation/usage/commandline), [Maven plugin](/documentation/usage/maven) or
[Gradle plugin](/documentation/usage/gradle), a SQL file contained the output of the dry run can be configured using the 
[`flyway.dryRunOutput`](/documentation/configuration/parameters/dryRunOutput) property.

When using the API directly, the dry run output can be configured using a `java.io.OutputStream`, giving you additional
flexibility.

As soon as this property is set, Flyway kicks in dry run mode. The database is no longer modified and all SQL statements
that would have been applied are sent to the dry run output instead.

## Tutorial

Click [here](/documentation/getstarted/advanced/dryruns) to see a tutorial on using dry runs.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate <i class="fa fa-arrow-right"></i></a>
</p>