---
layout: documentation
menu: configuration
pill: skipDefaultCallbacks
subtitle: flyway.skipDefaultCallbacks
---

# Skip Default Callbacks

## Description
Whether default built-in callbacks (sql) should be skipped. If true, only [custom callbacks](/documentation/configuration/callbacks) are used.

## Default
false

## Usage

### Commandline
```
./flyway -skipDefaultCallbacks="true" info
```

### Configuration File
```
flyway.skipDefaultCallbacks=true
```

### Environment Variable
```
FLYWAY_SKIP_DEFAULT_CALLBACKS=true
```

### API
```
flyway.configure()
    .skipDefaultCallbacks(true)
    .load()
```

### Gradle
```
flyway {
    skipDefaultCallbacks = true
}
```

### Maven
```
<configuration>
    <skipDefaultCallbacks>true</skipDefaultCallbacks>
</configuration>
```