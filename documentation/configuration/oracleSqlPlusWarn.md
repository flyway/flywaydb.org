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
```
./flyway -oracleSqlplusWarn="true" info
```

### Configuration File
```
flyway.oracle.sqlplus=true
```

### Environment Variable
```
FLYWAY_ORACLE_SQLPLUS_WARN=true
```

### API
```
flyway.configure()
    .oracleSqlplusWarn(true)
    .load()
```

### Gradle
```
flyway {
    oracleSqlplusWarn = true
}
```

### Maven
```
<configuration>
    <oracleSqlplusWarn>true</oracleSqlplusWarn>
</configuration>
```