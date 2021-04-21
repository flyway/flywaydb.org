---
layout: documentation
menu: configuration
pill: ignoreMigrationPatterns
subtitle: flyway.ignoreMigrationPatterns
---

# Ignore Migration Patterns
{% include teams.html %}

## Description
Ignore migrations during `validate` according to a given list of [patterns](https://flywaydb.org/documentation/configuration/parameters/ignoreMigrationPatterns#patterns).

### Patterns
Patterns are of the form `type`:`status` with `*` matching `type` or `status`.

`type` must be one of (*case insensitive*):

* `repeatable`
* `versioned`
* `*` *(will match any of the above)*

`status` must be one of (*case insensitive*):

* `Missing`
* `Pending`
* `Ignored`
* `Future`
* `*` *(will match any of the above)*

For example, the pattern to ignore missing repeatables is:
```
repeatable:missing
```

Patterns are comma seperated. For example, to ignore missing repeatables and pending versioned migrations:
```
repeatable:missing,versioned:pending
```

The `*` wild card is also supported, thus:
```
*:missing
```
will ignore missing migrations no matter their type and:
```
repeatable:*
```
will ignore repeatables regardless of their state.

## Default
empty

## Usage

### Commandline
```powershell
./flyway -ignoreMigrationPatterns="repeatable:missing" validate
```

### Configuration File
```properties
flyway.ignoreMigrationPatterns="repeatable:missing"
```

### Environment Variable
```properties
FLYWAY_IGNORE_MIGRATION_PATTERNS="repeatable:missing"
```

### API
```java
Flyway.configure()
    .ignoreMigrationPatterns("repeatable:missing")
    .load()
```

### Gradle
```groovy
flyway {
    ignoreMigrationPatterns = ['repeatable:missing']
}
```

### Maven
```xml
<configuration>
    <ignoreMigrationPatterns>
        <ignoreMigrationPattern>repeatable:missing</ignoreMigrationPattern>
    </ignoreMigrationPatterns>
</configuration>
```
