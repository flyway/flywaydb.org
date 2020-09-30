---
layout: documentation
menu: configuration
pill: encoding
subtitle: flyway.encoding
---

# Encoding

## Description
The encoding of Sql migrations

## Default
UTF-8

## Usage

### Commandline
```powershell
./flyway -encoding="UTF-16" info
```

### Configuration File
```properties
flyway.encoding=UTF-16
```

### Environment Variable
```properties
FLYWAY_ENCODING=UTF-16
```

### API
```java
Flyway.configure()
    .encoding("UTF-16")
    .load()
```

### Gradle
```groovy
flyway {
    encoding = 'UTF-16'
}
```

### Maven
```xml
<configuration>
    <encoding>UTF-16</encoding>
</configuration>
```