---
layout: documentation
menu: configuration
pill: detectEncoding
subtitle: flyway.detectEncoding
---

# Detect Encoding
{% include teams.html %}

## Description
Will attempt to autodetect the file encoding of each migration. It can ascertain each of the following formats:

* UTF-8
* ISO-8859-1
* UTF-16 BOMless
* UTF-16 LE
* UTF-16 BE

When it fails to detect, it will failover to the configured encoding if set, UTF-8 if not.

Can be overridden in script level configurations if needed; if per script configuration defines an encoding, auto detection will be skipped.

## Default
false

## Usage

### Commandline
```powershell
./flyway -detectEncoding="true" info
```

### Configuration File
```properties
flyway.detectEncoding=true
```

### Environment Variable
```properties
FLYWAY_DETECT_ENCODING=true
```

### API
```java
Flyway.configure()
    .detectEncoding(true)
    .load()
```

### Gradle
```groovy
flyway {
    detectEncoding = true
}
```

### Maven
```xml
<configuration>
    <detectEncoding>true</detectEncoding>
</configuration>
```