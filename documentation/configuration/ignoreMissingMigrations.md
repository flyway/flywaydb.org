---
layout: documentation
menu: configuration
pill: ignoreMissingMigrations
subtitle: flyway.ignoreMissingMigrations
---

# Ignore Missing Migrations

## Description
Ignore missing migrations when reading the [schema history table](/documentation/migrations#schema-history-table). 

These are migrations that were performed by an older deployment of the application that are no longer available in this version. 

For example: we have migrations available on the classpath with versions `1.0` and `3.0`. The schema history table indicates that a migration with version `2.0` (unknown to us) has also been applied. Instead of bombing out (fail fast) with an exception, a warning is logged and Flyway continues normally. This is useful for situations where one must be able to deploy a newer version of the application even though it doesn't contain migrations included with an older one anymore.

Note: If the most recently applied migration is removed, Flyway has no way to know it is missing and will mark it as future instead.

## Default
false

## Usage

### Commandline
```powershell
./flyway -ignoreMissingMigrations="true" validate
```

### Configuration File
```properties
flyway.ignoreMissingMigrations=true
```

### Environment Variable
```properties
FLYWAY_IGNORE_MISSING_MIGRATIONS=true
```

### API
```java
Flyway.configure()
    .ignoreMissingMigrations(true)
    .load()
```

### Gradle
```groovy
flyway {
    ignoreMissingMigrations = true
}
```

### Maven
```xml
<configuration>
    <ignoreMissingMigrations>true</ignoreMissingMigrations>
</configuration>
```