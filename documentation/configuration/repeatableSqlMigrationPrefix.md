---
layout: documentation
menu: configuration
pill: repeatableSqlMigrationPrefix
subtitle: flyway.repeatableSqlMigrationPrefix
---

# Repeatable SQL Migration Prefix

## Description
The file name prefix for repeatable SQL migrations.

Repeatable SQL migrations have the following file name structure: prefixSeparatorDESCRIPTIONsuffix, which using the defaults translates to R__My_description.sql

## Default
R

## Usage

### Commandline
```
./flyway -repeatableSqlMigrationPrefix="A" info
```

### Configuration File
```
flyway.repeatableSqlMigrationPrefix=A
```

### Environment Variable
```
FLYWAY_REPEATABLE_SQL_MIGRATION_PREFIX=A
```

### API
```
flyway.configure()
    .repeatableSqlMigrationPrefix("A")
    .load()
```

### Gradle
```
flyway {
    repeatableSqlMigrationPrefix = 'A'
}
```

### Maven
```
<configuration>
    <repeatableSqlMigrationPrefix>A</repeatableSqlMigrationPrefix>
</configuration>
```