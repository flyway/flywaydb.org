---
layout: documentation
menu: configuration
pill: stateScriptPrefix
subtitle: flyway.stateScriptPrefix
---

# State Script Prefix
{% include teams.html %}

## Description
The file name prefix for state scripts.

State scripts represent all migrations with `version <= current state script version` while keeping older migrations if needed for upgrading older deployments.

They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix, which using the defaults translates to S1.1__My_description.sql

## Default
S

## Usage

### Commandline
```powershell
./flyway -stateScriptPrefix="IB" info
```

### Configuration File
```properties
flyway.stateScriptPrefix=IB
```

### Environment Variable
```properties
FLYWAY_STATE_SCRIPT_PREFIX=IB
```

### API
```java
Flyway.configure()
    .stateScriptPrefix("IB")
    .load()
```

### Gradle
```groovy
flyway {
    stateScriptPrefix = 'IB'
}
```

### Maven
```xml
<configuration>
    <stateScriptPrefix>IB</stateScriptPrefix>
</configuration>
```
