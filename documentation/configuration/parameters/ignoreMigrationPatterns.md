---
layout: documentation
menu: configuration
pill: ignoreMigrationPatterns
subtitle: flyway.ignoreMigrationPatterns
---

# Ignore Migration Patterns
{% include teams.html %}

## Description
Ignore specified migrations during validate.

### Pattern
Patterns are in the form `type`:`status`, with `*` wildcards being valid for each `type` and `status`.

Type is one of (*case insensitive*):

* `repeatable`
* `versioned`
* `*` *(wild card, will match either of the above)*

Status is one of (*case insensitive*):

* `Missing`
* `Pending`
* `Ignored`
* `Future`
* `*` *(wild card, will match any of the above)*

For example, the pattern to ignore missing repeatables is:
```
repeatable:missing
```

Patterns are comma seperated. For example, to ignore missing repeatables and pending versioned migrations:
```
repeatable:missing,versioned:pending
```

Wildcards are supported, thus:
```
*:missing
```
will ignore missing files, no matter their type and:
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