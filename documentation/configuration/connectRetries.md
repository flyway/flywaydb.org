---
layout: documentation
menu: configuration
pill: connectRetries
subtitle: flyway.connectRetries
---

# Connect Retries

## Description
The maximum number of retries when attempting to connect to the database. After each failed attempt, Flyway will wait 1 second before attempting to connect again, up to the maximum number of times specified by connectRetries.

## Default
0

## Usage

### Commandline
```
./flyway -connectRetries=50 info
```

### Configuration File
```
flyway.connectRetries=50
```

### Environment Variable
```
FLYWAY_CONNECT_RETRIES=50
```

### API
```
Flyway.configure()
    .connectRetries(50)
    .load()
```

### Gradle
```
flyway {
    connectRetries = 50
}
```

### Maven
```
<configuration>
    <connectRetries>50</connectRetries>
</configuration>
```