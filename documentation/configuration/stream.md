---
layout: documentation
menu: configuration
pill: stream
subtitle: flyway.stream
---

# Stream
{% include teams.html %}

## Description
Whether to stream SQL migrations when executing them. Streaming doesn't load the entire migration in memory at once. Instead each statement is loaded individually. 

This is particularly useful for very large SQL migrations composed of multiple MB or even GB of reference data, as this dramatically reduces Flyway's memory consumption.

## Default
false

## Usage

### Commandline
```
./flyway -stream="true" info
```

### Configuration File
```
flyway.stream=true
```

### Environment Variable
```
FLYWAY_STREAM=true
```

### API
```
flyway.configure()
    .stream(true)
    .load()
```

### Gradle
```
flyway {
    stream = true
}
```

### Maven
```
<configuration>
    <stream>true</stream>
</configuration>
```