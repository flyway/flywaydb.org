---
layout: documentation
pill: group
subtitle: flyway.group
---

# Group

## Description
Whether to group all pending migrations together in the same transaction when applying them (only recommended for databases with support for DDL transactions)

## Default
false

## Usage

### Commandline
```
./flyway -group="true" info
```

### Configuration File
```
flyway.group=true
```

### Environment Variable
```
FLYWAY_GROUP=true
```

### API
```
flyway.configure()
    .group(true)
    .load()
```

### Gradle
```
flyway {
    group = true
}
```

### Maven
```
<configuration>
    <group>true</group>
</configuration>
```