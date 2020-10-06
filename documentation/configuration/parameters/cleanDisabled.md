---
layout: documentation
menu: configuration
pill: cleanDisabled
subtitle: flyway.cleanDisabled
redirect_from: /documentation/configuration/cleanDisabled
---

# Clean Disabled

## Description
Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.

## Default
false

## Usage

### Commandline
```powershell
./flyway -cleanDisabled="true" clean
```

### Configuration File
```properties
flyway.cleanDisabled=true
```

### Environment Variable
```properties
FLYWAY_CLEAN_DISABLED=true
```

### API
```java
Flyway.configure()
    .cleanDisabled(true)
    .load()
```

### Gradle
```groovy
flyway {
    cleanDisabled = true
}
```

### Maven
```xml
<configuration>
    <cleanDisabled>true</cleanDisabled>
</configuration>
```