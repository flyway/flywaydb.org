---
layout: documentation
pill: configFileEncoding
subtitle: flyway.configFileEncoding
---

# Config File Encoding

## Description
The file encoding to use when loading [Flyway configuration files](/documentation/configFiles).

## Default
UTF-8

## Usage

### Commandline
```
./flyway -configFileEncoding="UTF-16" info
```

### Configuration File
Not available

### Environment Variable
```
FLYWAY_configFileEncoding=UTF-16
```

### API
Not available

### Gradle
```
flyway {
    configFileEncoding = 'UTF-16'
}
```

### Maven
```
<configuration>
    <configFileEncoding>UTF-16</configFileEncoding>
</configuration>
```