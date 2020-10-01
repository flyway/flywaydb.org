---
layout: documentation
menu: placeholders
subtitle: Placeholders
redirect_from: /documentation/placeholders
---
# Placeholders
In addition to regular SQL syntax, Flyway also supports placeholder replacement with configurable pre- and suffixes.
By default it looks for Ant-style placeholders like `${myplaceholder}`. This can be very useful to abstract differences between environments.
Changing the value of placeholders will cause repeatable migrations to be re-applied on next migrate.

## How to configure
Placeholders can be configured through a number of different ways.
- Via environment variables. `FLYWAY_PLACEHOLDERS_MYPLACEHOLDER=value`
- Via configuration parameters. `flyway.placeholders.myplaceholder=value`
- Via the api. `.placeholders(Map.of("myplaceholder", "value"))`

Placeholders are case insensitive, so a placeholder like `${myplaceholder}` can be specified with any of the above techniques.

See [configuration](/documentation/configuration/parameters/#placeholders) for placeholder specific configuration parameters. 

## Default placeholders
Flyway also provides default placeholders, whose values are automatically populated:

### Commandline
```powershell
./flyway -flyway.placeholders.key1=value1 -flyway.placeholders.key2=value2 info
```

### Configuration File
```properties
flyway.placeholders.key1=value1
flyway.placeholders.key2=value2
```

### Environment Variable
```properties
FLYWAY_PLACEHOLDERS_KEY1=value1
FLYWAY_PLACEHOLDERS_KEY2=value2
```

### API
```java
Map<String, String> placeholders = new HashMap<>();
placeholders.put("key1", "value1");
placeholders.put("key2", "value2");

-- Default placeholders
GRANT SELECT ON SCHEMA ${flyway:defaultSchema} TO ${flyway:user};

### Gradle
```groovy
flyway {
    placeholders = ['key1' : 'value1', 'key2' : 'value2']
}
```

### Maven
```xml
<configuration>
    <placeholders>
        <key1>value1</key1>
        <key2>value2</key2>
    </placeholders>
</configuration>
```
