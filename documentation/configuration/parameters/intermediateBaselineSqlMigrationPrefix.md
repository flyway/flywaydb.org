---
layout: documentation
menu: configuration
pill: intermediateBaselineSqlMigrationPrefix
subtitle: flyway.intermediateBaselineSqlMigrationPrefix
---

# Intermediate Baseline SQL Migration Prefix
{% include teams.html %}

## Description
The file name prefix for intermedate baseline SQL migrations.

Intermediate baseline SQL migrations represent all migrations with `version <= current intermediate baseline version` while keeping older migrations if needed for upgrading older deployments.

They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to IB1.1__My_description.sql

## Default
IB

## Usage

### Commandline
```powershell
./flyway -intermediateBaselineSqlMigrationPrefix="NB" info
```

### Configuration File
```properties
flyway.intermediateBaselineSqlMigrationPrefix=NB
```

### Environment Variable
```properties
FLYWAY_INTERMEDIATE_BASELINE_SQL_MIGRATION_PREFIX=NB
```

### API
```java
Flyway.configure()
    .intermediateBaselineSqlMigrationPrefix("NB")
    .load()
```

### Gradle
```groovy
flyway {
    intermediateBaselineSqlMigrationPrefix = 'NB'
}
```

### Maven
```xml
<configuration>
    <intermediateBaselineSqlMigrationPrefix>NB</intermediateBaselineSqlMigrationPrefix>
</configuration>
```
