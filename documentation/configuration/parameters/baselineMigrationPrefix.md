---
layout: documentation
menu: configuration
pill: baselineMigrationPrefix
subtitle: flyway.baselineMigrationPrefix
---

# Baseline Migration Prefix
{% include teams.html %}

## Description
The file name prefix for baseline migrations.

Baseline migrations represent all migrations with `version <= current baseline migration version` while keeping older migrations if needed for upgrading older deployments.

They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to B1.1__My_description.sql

## Default
B

## Usage

### Commandline
```powershell
./flyway -baselineMigrationPrefix="IB" info
```

### Configuration File
```properties
flyway.baselineMigrationPrefix=IB
```

### Environment Variable
```properties
FLYWAY_BASELINE_MIGRATION_PREFIX=IB
```

### API
```java
Flyway.configure()
    .baselineMigrationPrefix("IB")
    .load()
```

### Gradle
```groovy
flyway {
    baselineMigrationPrefix = 'IB'
}
```

### Maven
```xml
<configuration>
    <baselineMigrationPrefix>IB</baselineMigrationPrefix>
</configuration>
```
