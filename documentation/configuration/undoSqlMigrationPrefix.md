---
layout: documentation
pill: undoSqlMigrationPrefix
subtitle: flyway.undoSqlMigrationPrefix
---

# Undo SQL Migration Prefix
{% include teams.html %}

## Description
The file name prefix for undo SQL migrations.

Undo SQL migrations are responsible for undoing the effects of the versioned migration with the same version.

They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to U1.1__My_description.sql

## Default
U

## Usage

### Commandline
```
./flyway -undoSqlMigrationPrefix="B" info
```

### Configuration File
```
flyway.undoSqlMigrationPrefix=B
```

### Environment Variable
```
FLYWAY_UNDO_SQL_MIGRATION_PREFIX=B
```

### API
```
flyway.configure()
    .undoSqlMigrationPrefix("B")
    .load()
```

### Gradle
```
flyway {
    undoSqlMigrationPrefix = 'B'
}
```

### Maven
```
<configuration>
    <undoSqlMigrationPrefix>B</undoSqlMigrationPrefix>
</configuration>
```