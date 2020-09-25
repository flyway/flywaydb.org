---
layout: documentation
menu: configuration
pill: table
subtitle: flyway.table
---

# Table

## Description
The name of Flyway's schema history table.

By default (single-schema mode) the schema history table is placed in the default schema for the connection provided by the datasource.

When the [defaultSchema](/documentation/configuration/defaultSchema) or [schemas](/documentation/configuration/schemas) property is set (multi-schema mode), the schema history table is placed in the specified default schema.

## Default
flyway_schema_history

## Usage

### Commandline
```
./flyway -table="my_schema_history_table" info
```

### Configuration File
```
flyway.table=my_schema_history_table
```

### Environment Variable
```
FLYWAY_TABLE=my_schema_history_table
```

### API
```
Flyway.configure()
    .table("my_schema_history_table")
    .load()
```

### Gradle
```
flyway {
    table = 'my_schema_history_table'
}
```

### Maven
```
<configuration>
    <table>my_schema_history_table</table>
</configuration>
```