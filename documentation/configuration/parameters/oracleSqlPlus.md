---
layout: documentation
menu: configuration
pill: oracleSqlPlus
subtitle: flyway.oracleSqlPlus
redirect_from: /documentation/configuration/oracleSqlPlus/
---

# Oracle SQL*Plus
{% include teams.html %}

## Description
Enable Flyway's support for [Oracle SQL*Plus commands](/documentation/database/oracle#sqlplus-commands).

## Default
false

## Usage

### Commandline
```powershell
./flyway -oracleSqlplus="true" info
```

### Configuration File
```properties
flyway.oracle.sqlplus=true
```

### Environment Variable
```properties
FLYWAY_ORACLE_SQLPLUS=true
```

### API
```java
Flyway.configure()
    .oracleSqlplus(true)
    .load()
```

### Gradle
```groovy
flyway {
    oracleSqlplus = true
}
```

### Maven
```xml
<configuration>
    <oracleSqlplus>true</oracleSqlplus>
</configuration>
```