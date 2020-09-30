---
layout: documentation
menu: configuration
pill: oracleSqlPlusWarn
subtitle: flyway.oracleSqlPlusWarn
---

# Oracle SQL*Plus Warn
{% include teams.html %}

## Description
Whether Flyway should issue a warning instead of an error whenever it encounters an [Oracle SQL*Plus statement](/documentation/database/oracle#sqlplus-commands) it doesn't yet support.

## Default
false

## Usage

### Commandline
```powershell
./flyway -oracleSqlplusWarn="true" info
```

### Configuration File
```properties
flyway.oracle.sqlplus=true
```

### Environment Variable
```properties
FLYWAY_ORACLE_SQLPLUS_WARN=true
```

### API
```java
Flyway.configure()
    .oracleSqlplusWarn(true)
    .load()
```

### Gradle
```groovy
flyway {
    oracleSqlplusWarn = true
}
```

### Maven
```xml
<configuration>
    <oracleSqlplusWarn>true</oracleSqlplusWarn>
</configuration>
```