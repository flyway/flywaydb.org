---
layout: documentation
menu: configuration
pill: configFileEncoding
subtitle: flyway.configFileEncoding
redirect_from: /documentation/configuration/configFileEncoding
---

# Config File Encoding

## Description
The file encoding to use when loading [Flyway configuration files](/documentation/configuration/configFiles).

## Default
UTF-8

## Usage

### Commandline
```powershell
./flyway -configFileEncoding="UTF-16" info
```

### Configuration File
Not available

### Environment Variable
```properties
FLYWAY_configFileEncoding=UTF-16
```

### API
Not available

### Gradle
```groovy
flyway {
    configFileEncoding = 'UTF-16'
}
```

### Maven
```xml
<configuration>
    <configFileEncoding>UTF-16</configFileEncoding>
</configuration>
```