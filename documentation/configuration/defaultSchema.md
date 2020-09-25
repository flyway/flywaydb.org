---
layout: documentation
menu: configuration
pill: defaultSchema
subtitle: flyway.defaultSchema
---

# Default Schema

## Description
The default schema managed by Flyway. This schema will be the one containing the schema history table.

This schema will also be the default for the database connection (provided the database supports this concept).

## Default
If [schemas](/documentation/configuration/schemas) is specified, the first schema in that list.

## Usage

### Commandline
```
./flyway -defaultSchema="schema2" info
```

### Configuration File
```
flyway.defaultSchema=schema2
```

### Environment Variable
```
FLYWAY_DEFAULT_SCHEMA=schema2
```

### API
```
flyway.configure()
    .defaultSchema("schema2")
    .load()
```

### Gradle
```
flyway {
    defaultSchema = 'schema2'
}
```

### Maven
```
<configuration>
    <defaultSchema>schema2</defaultSchema>
</configuration>
```