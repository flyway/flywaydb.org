---
layout: documentation
menu: configuration
pill: ignoreFutureMigrations
subtitle: flyway.ignoreFutureMigrations
redirect_from: /documentation/configuration/ignoreFutureMigrations
---

# Ignore Future Migrations

## Description
Ignore future migrations when reading the [schema history table](/documentation/concepts/migrations#schema-history-table). These are migrations that were performed by a newer deployment of the application that are not yet available in this version. 

For example: we have migrations available on the classpath up to version `3.0`. The schema history table indicates that a migration to version `4.0` (unknown to us) has already been applied. Instead of bombing out (fail fast) with an exception, a warning is logged and Flyway continues normally. This is useful for situations where one must be able to redeploy an older version of the application after the database has been migrated by a newer one.

## Default
true

## Usage

### Commandline
```powershell
./flyway -ignoreFutureMigrations="false" validate
```

### Configuration File
```properties
flyway.ignoreFutureMigrations=false
```

### Environment Variable
```properties
FLYWAY_IGNORE_FUTURE_MIGRATIONS=false
```

### API
```java
Flyway.configure()
    .ignoreFutureMigrations(false)
    .load()
```

### Gradle
```groovy
flyway {
    ignoreFutureMigrations = false
}
```

### Maven
```xml
<configuration>
    <ignoreFutureMigrations>false</ignoreFutureMigrations>
</configuration>
```