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
```
./flyway -encoding="UTF-16" info
```

### Configuration File
```
flyway.encoding=UTF-16
```

### Environment Variable
```
FLYWAY_ENCODING=UTF-16
```

### API
```
flyway.configure()
    .encoding("UTF-16")
    .load()
```

### Gradle
```
flyway {
    encoding = 'UTF-16'
}
```

### Maven
```
<configuration>
    <encoding>UTF-16</encoding>
</configuration>
```