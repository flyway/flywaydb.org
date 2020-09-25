---
layout: documentation
menu: configuration
pill: sqlMigrationSeparator
subtitle: flyway.sqlMigrationSeparator
---

# SQL Migration Separator

## Description
The file name separator for Sql migrations.

Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to V1.1__My_description.sql

## Default
__

## Usage

### Commandline
```
./flyway -sqlMigrationSeparator="-" info
```

### Configuration File
```
flyway.sqlMigrationSeparator=-
```

### Environment Variable
```
FLYWAY_SQL_MIGRATION_SEPARATOR=-
```

### API
```
Flyway.configure()
    .sqlMigrationSeparator("-")
    .load()
```

### Gradle
```
flyway {
    sqlMigrationSeparator = '-'
}
```

### Maven
```
<configuration>
    <sqlMigrationSeparator>-</sqlMigrationSeparator>
</configuration>
```