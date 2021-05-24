---
layout: documentation
menu: configuration
pill: target
subtitle: flyway.target
redirect_from: /documentation/configuration/target/
---

# Target

## Description

The target version up to which Flyway should consider migrations. If set to a value other than `current` or `latest`, 
this must be a valid migration version (e.g. `2.1`).

When migrating forwards, Flyway will apply all migrations up to and including the target version. Migrations with a 
higher version number will be ignored. If the target is `current`, then no versioned migrations will be
applied but repeatable migrations will be, together with any callbacks.

When undoing migrations, Flyway will apply all undo scripts up to and including the target version. Undo scripts with a 
lower version number will be ignored. Specifying a target version should be done with care, as undo scripts typically
destroy database objects.

Special values:
<ul>
  <li><code>current</code>: designates the current version of the schema</li>
  <li><code>latest</code>: the latest version of the schema, as defined by the migration with the highest version</li>
</ul>

## Fuzzy Matching
{% include teams.html %}

Appending a version number with a `?` character will enable _"fuzzy matching"_ where Flyway will match the closest version available (specified number or below for `migrate`, specified number or above for `undo`) rather than throwing an exception.


## Default

`latest` for versioned migrations, `current` for undo migrations.

## Usage

### Commandline
```powershell
./flyway -target="2.0" migrate
```

### Commandline with fuzzy matching
{% include teams.html %}
```powershell
./flyway -target="2.0?" migrate
```

### Configuration File
```properties
flyway.target=2.0
```

### Configuration File with fuzzy matching
{% include teams.html %}
```properties
flyway.target=2.0?
```

### Environment Variable
```properties
FLYWAY_TARGET=2.0
```

### Environment Variable with fuzzy matching
{% include teams.html %}
```properties
FLYWAY_TARGET=2.0?
```

### API
```java
Flyway.configure()
    .target("2.0")
    .load()
```

### API with fuzzy matching
{% include teams.html %}
```java
Flyway.configure()
    .target("2.0?")
    .load()
```

### Gradle
```groovy
flyway {
    target = '2.0'
}
```

### Gradle with fuzzy matching
{% include teams.html %}
```groovy
flyway {
    target = '2.0?'
}
```

### Maven
```xml
<configuration>
    <target>2.0</target>
</configuration>
```


### Maven with fuzzy matching
{% include teams.html %}
```xml
<configuration>
    <target>2.0?</target>
</configuration>
```