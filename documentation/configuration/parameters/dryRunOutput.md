---
layout: documentation
menu: configuration
pill: dryRunOutput
subtitle: flyway.dryRunOutput
redirect_from: /documentation/configuration/dryRunOutput/
---

# Dry Run Output
{% include teams.html %}

## Description
The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent directory, Flyway will create all directories and parent directories as needed.

Omit to use the default mode of executing the SQL statements directly against the database.

See [dry runs](/documentation/concepts/dryruns) for more details.

## Default
<i>Execute directly against the database</i>

## Usage

### Commandline
```powershell
./flyway -dryRunOutput="/my/output/file.sql" clean
```

### Configuration File
```properties
flyway.dryRunOutput=/my/output/file.sql
```

### Environment Variable
```properties
FLYWAY_DRYRUN_OUTPUT=/my/output/file.sql
```

### API
```java
Flyway.configure()
    .dryRunOutput("/my/output/file.sql")
    .load()
```

### Gradle
```groovy
flyway {
    dryRunOutput = '/my/output/file.sql'
}
```

### Maven
```xml
<configuration>
    <dryRunOutput>/my/output/file.sql</dryRunOutput>
</configuration>
```

## Use Cases

### Preview changes without altering the database

Quite often a migration may be making use of [placeholders](http://localhost:4000/documentation/configuration/parameters/placeholders), such as in the statement `INSERT INTO table1(name) VALUES(${name})`. There may also be callbacks executing as part of your migration process which you might not be aware of when developing migrations. Instead of risking errors when migrating against your actual database with these unknowns, you can use dry runs to generate the SQL that would be executed in order to preview what would happen without altering the database. For example, you may notice that the placeholder `${name}` isn't what you expected, or that there is a callback being executed before your migration which you aren't accounting for.
