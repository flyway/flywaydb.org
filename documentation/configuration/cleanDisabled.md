---
layout: documentation
menu: configuration
pill: cleanDisabled
subtitle: flyway.cleanDisabled
---

# Clean Disabled

## Description
Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.

## Default
false

## Usage

### Commandline
```
./flyway -cleanDisabled="true" clean
```

### Configuration File
```
flyway.cleanDisabled=true
```

### Environment Variable
```
FLYWAY_CLEAN_DISABLED=true
```

### API
```
flyway.configure()
    .cleanDisabled(true)
    .load()
```

### Gradle
```
flyway {
    cleanDisabled = true
}
```

### Maven
```
<configuration>
    <cleanDisabled>true</cleanDisabled>
</configuration>
```