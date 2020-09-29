---
layout: documentation
menu: configFiles
subtitle: Config Files
---
# Config Files

Flyway supports loading configuration via config files.

## Loading

By default Flyway will load configuration files from the following locations:
- <i>installDir<i>/conf/flyway.conf
- <i>userhome<i>/flyway.conf
- <i>workingDir<i>/flyway.conf

### Commandline
```powershell
./flyway -configFiles="my.conf" info
```

## Structure

### Environment Variable
```properties
FLYWAY_CONFIG_FILES=my.conf
```

```properties
# Settings are simple key-value pairs
flyway.key=value
# Single line comment start with a hash

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
