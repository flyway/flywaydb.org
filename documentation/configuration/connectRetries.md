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
```powershell
./flyway -connectRetries=50 info
```

### Configuration File
```properties
flyway.connectRetries=50
```

### Environment Variable
```properties
FLYWAY_CONNECT_RETRIES=50
```

### API
```java
Flyway.configure()
    .connectRetries(50)
    .load()
```

### Gradle
```groovy
flyway {
    connectRetries = 50
}
```

### Maven
```xml
<configuration>
    <connectRetries>50</connectRetries>
</configuration>
```