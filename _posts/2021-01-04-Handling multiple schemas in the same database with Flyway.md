_Originally published 04 January 2021 by Julia Hayward on flywaydb.org_

We've had some users ask recently about multi-schema deployments. There are a number of possible scenarios, some of which are supported naturally by Flyway and some not. This blog post summarises the current state of play on the matter, but we're keen to make sure we cover popular use cases. If you have any feedback for us, there's an ongoing discussion on [Github Issues](https://github.com/flyway/flyway/issues/2995).

## Configuration

There are two main configuration parameters: `flyway.schemas` and `flyway.defaultSchema`. In this post we'll talk about them as being in `flyway.conf`, but of course the same will apply whether you choose to use them in configuration files, environment variables, the Java API or command line parameters.

### flyway.defaultSchema

This parameter sets the default schema for the connection. That is, if we put an unqualified object name in our migration, it will be assumed to be in the default schema. So a migration:

    CREATE TABLE MyTable (id INT);

run with `flyway.defaultSchema=julia` is equivalent to `CREATE TABLE julia.MyTable (...)`. If we want to interact with other schemas, we need to use fully-qualified object names. This schema is also where we will put our schema history table.

Not all databases have a concept of a default schema, and perhaps more awkwardly, some have gotchas - SQL Server, for example, has a concept of a default schema but it's not applicable to all users and it's [quietly ignored](https://docs.microsoft.com/en-us/sql/t-sql/statements/alter-user-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15) if you are a member of the sysadmin server role such as `sa`. Flyway will warn you if you're trying to use a default schema when the database doesn't support it. However, regardless of whether it is supported, the configuration parameter is still useful, as it is used to populate the corresponding Flyway placeholder. So, the following migration will still create our table in the relevant schema:

    CREATE TABLE ${flyway:defaultSchema}.MyTable (id INT);

### flyway.schemas

This parameter doesn't affect migrations, unless you've chosen not to specify `defaultSchema` (in which case the first schema in this list is treated as the default). It is useful mostly in a development scenario; when you first `migrate`, all these schemas will be created if they didn't already exist, and when you `clean` Flyway will empty them again.

## Many different schemas, many histories

This is the simplest scenario, as all our schemas are effectively separate entities and can happily co-exist in different states. Each schema will be built up from a different set of scripts, which is probably best served by building up separate configuration files for each schema:
```
    flyway.defaultSchema=foo
    flyway.locations=c:\src\migrations\foo\
```

and then migrating each one in turn:
```
    # Powershell
    $schemas = @('foo', 'bar')
    foreach ($schema in $schemas) { flyway migrate -configFiles="c:\src\config\$schema.conf" }

    #!/bin/bash
    schemas=(foo bar)
    for schema in "${schemas[@]}"
    do
        flyway migrate -configFiles="/src/config/$schema.conf" 
    done
```

## One desired schema structure, many histories

Now suppose we have a multi-tenant database where we want all schemas to have an identical structure. Now, we no longer need separate sets of scripts - and moreover, we no longer _want_ separate sets of scripts, as having a single set will enforce that uniformity for us. Instead of iterating over configurations, we can iterate instead over the schemas, using the `${flyway:defaultSchema}` placeholder in any script that needs a fully qualified name:
```
    # Powershell
    $schemas = @('foo', 'bar')
    foreach ($schema in $schemas) { flyway migrate -configFiles="c:\src\config\flyway.conf" -defaultSchema="$schema" }
```
Having a separate history table in each schema appears redundant in that the same sequence of migrations will be recorded in each table, and calling `migrate` repeatedly like this will migrate each schema up to the same state (assuming no new migrations are created while Flyway is busy!). However, it does mean that when we need a new schema with the same structure, we can simply add it to the list, and Flyway will create it automatically and migrate it forwards through the same sequence as all the others until it has reached the latest structure.

This method is also failure-resistant - if Flyway fails on one schema, the history tables contain enough information that once the failure is cleared, Flyway will do the right thing on future runs.

It is possible to do similar iterations with Maven and Gradle; in addition in Maven there is the [`iterator-maven-plugin`](https://github.com/khmarbaise/iterator-maven-plugin) which makes iterating over a collection of values significantly easier.

## One desired schema structure, one history

This is the most tricky scenario, as it requires each migration to handle the iteration across schemas - which makes the migrations more complex as they will need to use dynamic SQL. Adding a new schema is also much more complex; suppose we've run three migrations on schemas `foo` and `bar`, and now we want to add schema `baz`. The history table tells us we've run three migrations, but not which schemas were involved. So to get `baz` up to the correct state we need another migration, #4 - and that migration now needs to check each schema in turn, and if they are not at the right state, re-run migrations #1, #2 and #3 somehow.

The prospect of errors during the catch-up process complicates things further. What happens if something fails while schema `baz` is being brought up to the current state? We have no way of reflecting that in the history table as it stands, and so we would need more SQL to figure out what state it was in.

So, we can't recommend this approach.

## But that's not the end of the story...

We recognise that databases with large numbers of identical schemas are an increasingly common situation. We'd like to hear from you if you have such a database! Do the above iterative methods work for you? If not, how could we best support you? Let us know either at [Github Issues](https://github.com/flyway/flyway/issues/2995) or in the comments below; we would really value your feedback as we figure out what would be the best way to implement support for you.