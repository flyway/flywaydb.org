---
layout: documentation
menu: configuration
pill: ignorePendingMigrations
subtitle: flyway.ignorePendingMigrations
---

# Ignore Pending Migrations

## Description
Ignore pending migrations when reading the [schema history table](/documentation/migrations#schema-history-table). These are migrations that are available but have not yet been applied. 

This can be useful for verifying that in-development migration changes don't contain any validation-breaking changes of migrations that have already been applied to a production environment, e.g. as part of a CI/CD process, without failing because of the existence of new migration versions.

## Default
false

## Usage

### Commandline
```powershell
./flyway -ignorePendingMigrations="true" validate
```

### Configuration File
```properties
flyway.ignorePendingMigrations=true
```

### Environment Variable
```properties
FLYWAY_IGNORE_PENDING_MIGRATIONS=true
```

### API
```java
Flyway.configure()
    .ignorePendingMigrations(true)
    .load()
```

### Gradle
```groovy
flyway {
    ignorePendingMigrations = true
}
```

### Maven
```xml
<configuration>
    <ignorePendingMigrations>true</ignorePendingMigrations>
</configuration>
```