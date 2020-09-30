---
layout: documentation
menu: configuration
pill: configFiles
subtitle: flyway.configFiles
---

# Config Files

## Description
The [Flyway configuration](/documentation/configfiles) files to load.

These files will be relative to the [Working Directory](/documentation/configuration/workingDirectory).

## Usage

### Commandline
```powershell
./flyway -configFiles="my.conf" info
```

### Configuration File
Not available

### Environment Variable
```properties
FLYWAY_CONFIG_FILES=my.conf
```

### API
Not available

### Gradle
```groovy
flyway {
    configFiles = ['my.conf']
}
```

### Maven
```xml
<configuration>
    <configFiles>
        <configFile>my.conf</configFile>
    </configFiles>
</configuration>
```