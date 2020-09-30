---
layout: documentation
menu: configuration
pill: configFiles
subtitle: flyway.configFiles
---

# Config Files

## Description
The [Flyway configuration](/documentation/configuration/configfiles) files to load.

These files will be relative to the [Working Directory](/documentation/configuration/parameters/workingDirectory).

## Usage

### Commandline
```
./flyway -configFiles="my.conf" info
```

### Configuration File
Not available

### Environment Variable
```
FLYWAY_CONFIG_FILES=my.conf
```

### API
Not available

### Gradle
```
flyway {
    configFiles = ['my.conf']
}
```

### Maven
```
<configuration>
    <configFiles>
        <configFile>my.conf</configFile>
    </configFiles>
</configuration>
```