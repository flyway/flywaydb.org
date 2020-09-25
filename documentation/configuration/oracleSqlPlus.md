---
layout: documentation
menu: configuration
pill: oracleSqlPlus
subtitle: flyway.oracleSqlPlus
---

# Oracle SQL*Plus
{% include teams.html %}

## Description
Enable Flyway's support for [Oracle SQL*Plus commands](/documentation/database/oracle#sqlplus-commands).

## Default
false

## Usage

### Commandline
```
./flyway -oracleSqlplus="true" info
```

### Configuration File
```
flyway.oracle.sqlplus=true
```

### Environment Variable
```
FLYWAY_ORACLE_SQLPLUS=true
```

### API
```
flyway.configure()
    .oracleSqlplus(true)
    .load()
```

### Gradle
```
flyway {
    oracleSqlplus = true
}
```

### Maven
```
<configuration>
    <oracleSqlplus>true</oracleSqlplus>
</configuration>
```