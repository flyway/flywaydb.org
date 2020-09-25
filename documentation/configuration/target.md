---
layout: documentation
menu: configuration
pill: target
subtitle: flyway.target
---

# Target

## Description
The target version up to which Flyway should consider migrations. Migrations with a higher version number will be ignored. If set to a value other than `current` or `latest`, this must be a valid migration version (e.g. `2.1`).

Special values:
<ul>
  <li><code>current</code>: designates the current version of the schema</li>
  <li><code>latest</code>: the latest version of the schema, as defined by the migration with the highest version</li>
</ul>

## Default
latest

## Usage

### Commandline
```
./flyway -target="2.0" migrate
```

### Configuration File
```
flyway.target=2.0
```

### Environment Variable
```
FLYWAY_TARGET=2.0
```

### API
```
flyway.configure()
    .target("2.0")
    .load()
```

### Gradle
```
flyway {
    target = '2.0'
}
```

### Maven
```
<configuration>
    <target>2.0</target>
</configuration>
```