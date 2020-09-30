---
layout: documentation
menu: configuration
pill: placeholders
subtitle: flyway.placeholders
---

# Placeholders

## Description
[Placeholders](/documentation/configuration/placeholders) to replace in SQL migrations. 

For example to replace a placeholder named `key1` with the value `value1`, you can set `flyway.placeholders.key1=value1`. 
Flyway will take the `key1` part, and long with the [placeholder prefix](/documentation/configuration/parameters/placeholderPrefix) and the [placeholder suffix](/documentation/configuration/parameters/placeholderSuffix) construct a placeholder replacement, which by default would look like `${key}`. Then in your SQL migrations and instances of this will be replaced with `value1`. 

Placeholder matching is case insensitive, so a placeholder of `flyway.placeholders.key1` will match `${key1}` and `${KEY1}`.

## Usage

### Commandline
```
./flyway -flyway.placeholders.key1=value1 -flyway.placeholders.key2=value2 info
```

### Configuration File
```
flyway.placeholders.key1=value1
flyway.placeholders.key2=value2
```

### Environment Variable
```
FLYWAY_PLACEHOLDERS_KEY1=value1
FLYWAY_PLACEHOLDERS_KEY2=value2
```

### API
```
Map<String, String> placeholders = new HashMap<>();
placeholders.put("key1", "value1");
placeholders.put("key2", "value2");

Flyway.configure()
    .placeholders(placeholders)
    .load()
```

### Gradle
```
flyway {
    placeholders = ['key1' : 'value1', 'key2' : 'value2']
}
```

### Maven
```
<configuration>
    <placeholders>
        <key1>value1</key1>
        <key2>value2</key2>
    </placeholders>
</configuration>
```