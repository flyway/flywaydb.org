---
layout: documentation
menu: configuration
pill: dryRunOutput
subtitle: flyway.dryRunOutput
---

# Dry Run Output
{% include teams.html %}

## Description
The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent directory, Flyway will create all directories and parent directories as needed.

Omit to use the default mode of executing the SQL statements directly against the database.

See See [dry runs](/documentation/dryruns) for more details.

## Default
<i>Execute directly against the database</i>

## Usage

### Commandline
```
./flyway -dryRunOutput="/my/output/file.sql" clean
```

### Configuration File
```
flyway.dryRunOutput=/my/output/file.sql
```

### Environment Variable
```
FLYWAY_DRYRUN_OUTPUT=/my/output/file.sql
```

### API
```
flyway.configure()
    .dryRunOutput("/my/output/file.sql")
    .load()
```

### Gradle
```
flyway {
    dryRunOutput = '/my/output/file.sql'
}
```

### Maven
```
<configuration>
    <dryRunOutput>/my/output/file.sql</dryRunOutput>
</configuration>
```