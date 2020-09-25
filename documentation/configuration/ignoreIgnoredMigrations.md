---
layout: documentation
pill: ignoreIgnoredMigrations
subtitle: flyway.ignoreIgnoredMigrations
---

# Ignore Ignored Migrations

## Description
Ignore ignored migrations when reading the schema history table. 

These are migrations that were added in between already migrated migrations in this version. 

For example: we have migrations available on the classpath with versions from `1.0` to `3.0`. The schema history table indicates that version `1` was finished on `1.0.15`, and the next one was `2.0.0`. But with the next release a new migration was added to version `1`: `1.0.16`. Such scenario is ignored by migrate command, but by default is rejected by validate. 

When `ignoreIgnoredMigrations` is enabled, such case will not be reported by validate command. This is useful for situations where one must be able to deliver complete set of migrations in a delivery package for multiple versions of the product, and allows for further development of older versions.

## Default
false

## Usage

### Commandline
```
./flyway -ignoreIgnoredMigrations="true" validate
```

### Configuration File
```
flyway.ignoreIgnoredMigrations=true
```

### Environment Variable
```
FLYWAY_IGNORE_IGNORED_MIGRATIONS=true
```

### API
```
flyway.configure()
    .ignoreIgnoredMigrations(true)
    .load()
```

### Gradle
```
flyway {
    ignoreIgnoredMigrations = true
}
```

### Maven
```
<configuration>
    <ignoreIgnoredMigrations>true</ignoreIgnoredMigrations>
</configuration>
```