---
layout: documentation
menu: configuration
pill: callbacks
subtitle: flyway.callbacks
---

# Callbacks

## Description
Comma-separated list of fully qualified class names of [Callback](/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback) implementations to use to hook into the Flyway lifecycle, or packages to scan for these classes. Ensure the class or package is available on the classpath (see [Adding to the classpath](/documentation/addingToTheClasspath)).

Note: SQL callbacks matching the correct name pattern are loaded from locations (see [Callbacks](/documentation/callbacks)). This configuration parameter is only used for loading java callbacks. To disable loading sql callbacks, see [skipDefaultCallbacks](/documentation/configuration/skipDefaultCallbacks).

## Default
db/callback

## Usage

### Commandline
```
./flyway -callbacks="my.callback.FlywayCallback,my.package.to.scan" info
```

### Configuration File
```
flyway.callbacks=my.callback.FlywayCallback,my.package.to.scan
```

### Environment Variable
```
FLYWAY_CALLBACKS=my.callback.FlywayCallback,my.package.to.scan
```

### API
```
flyway.configure()
    .callbacks("my.callback.FlywayCallback", "my.package.to.scan")
    .load()
```

### Gradle
```
flyway {
    callbacks = ['my.callback.FlywayCallback', 'my.package.to.scan']
}
```

### Maven
```
<configuration>
    <callbacks>my.callback.FlywayCallback,my.package.to.scan</callbacks>
</configuration>
```