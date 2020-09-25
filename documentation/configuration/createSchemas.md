---
layout: documentation
menu: configuration
pill: createSchemas
subtitle: flyway.createSchemas
---

# Create Schemas

## Description
Whether Flyway should attempt to create the schemas specified in the schemas property. [See this page for more details](/documentation/migrations#the-createschemas-option-and-the-schema-history-table)

## Default
true

## Usage

### Commandline
```
./flyway -createSchemas="false" info
```

### Configuration File
```
flyway.createSchemas=false
```

### Environment Variable
```
FLYWAY_SCHEMAS=false
```

### API
```
flyway.configure()
    .createSchemas(false)
    .load()
```

### Gradle
```
flyway {
    createSchemas = false
}
```

### Maven
```
<configuration>
    <createSchemas>false</createSchemas>
</configuration>
```