---
layout: documentation
menu: configuration
pill: validateMigrationNaming
subtitle: flyway.validateMigrationNaming
---

# Validate Migration Naming

## Description
Whether to ignore migration files whose names do not match the naming conventions.

If `false`, files with invalid names are ignored and Flyway continues normally. If `true`, Flyway fails fast and lists the offending files.

## Default
false

## Usage

### Commandline
```
./flyway -validateMigrationNaming="true" info
```

### Configuration File
```
flyway.validateMigrationNaming=true
```

### Environment Variable
```
FLYWAY_VALIDATE_MIGRATION_NAMING=true
```

### API
```
Flyway.configure()
    .validateMigrationNaming(true)
    .load()
```

### Gradle
```
flyway {
    validateMigrationNaming = true
}
```

### Maven
```
<configuration>
    <validateMigrationNaming>true</validateMigrationNaming>
</configuration>
```