---
layout: documentation
menu: configuration
pill: tablespace
subtitle: flyway.tablespace
---

# Tablespace

## Description
The tablespace where to create the schema history table that will be used by Flyway.

This setting is only relevant for databases that do support the notion of tablespaces. Its value is simply ignored for all others.

## Usage

### Commandline
```
./flyway -tablespace="xyz" info
```

### Configuration File
```
flyway.tablespace=xyz
```

### Environment Variable
```
FLYWAY_TABLESPACE=xyz
```

### API
```
Flyway.configure()
    .tablespace("xyz")
    .load()
```

### Gradle
```
flyway {
    tablespace = 'xyz'
}
```

### Maven
```
<configuration>
    <tablespace>xyz</tablespace>
</configuration>
```