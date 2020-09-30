---
layout: documentation
menu: configuration
pill: jdbcProperties
subtitle: flyway.jdbcProperties
---

# JDBC Properties
{% include teams.html %}

## Description
JDBC properties to pass to the JDBC driver when establishing a connection.

For example to supply a property `property1` with the value `value1`, you can set `flyway.jdbcProperties.key1=value1`. Flyway will then set the `key1` property on the jdbc driver to `value1` when it establishes a connection.

## Usage

### Commandline
```powershell
./flyway -jdbcProperties.accessToken=my-access-token info
```

### Configuration File
```properties
flyway.jdbcProperties.accessToken=my-access-token
```

### Environment Variable
```properties
FLYWAY_JDBC_PROPERTIES_ACCESSTOKEN=access-token
```

### API
```java
Map<String, String> properties = new HashMap<>();
properties.put("accessToken", "access-token");

Flyway.configure()
    .jdbcProperties(properties)
    .load()
```

### Gradle
```groovy
flyway {
    jdbcProperties = ['accessToken' : 'access-token']
}
```

### Maven
```xml
<configuration>
    <jdbcProperties>
        <accessToken>access-token</accessToken>
    </jdbcProperties>
</configuration>
```