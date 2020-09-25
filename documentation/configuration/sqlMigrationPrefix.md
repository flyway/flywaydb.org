---
layout: documentation
menu: configuration
pill: sqlMigrationPrefix
subtitle: flyway.sqlMigrationPrefix
---

# SQL Migration Prefix

## Description
The file name prefix for versioned SQL migrations.

Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to V1.1__My_description.sql

## Default
V

## Usage

### Commandline
```
./flyway -sqlMigrationPrefix="M" info
```

### Configuration File
```
flyway.sqlMigrationPrefix=M
```

### Environment Variable
```
FLYWAY_SQL_MIGRATION_PREFIX=M
```

### API
```
flyway.configure()
    .sqlMigrationPrefix("M")
    .load()
```

### Gradle
```
flyway {
    sqlMigrationPrefix = 'M'
}
```

### Maven
```
<configuration>
    <sqlMigrationPrefix>M</sqlMigrationPrefix>
</configuration>
```