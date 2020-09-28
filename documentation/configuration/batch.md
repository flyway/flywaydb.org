---
layout: documentation
menu: configuration
pill: batch
subtitle: flyway.batch
---

# Batch
{% include teams.html %}

## Description
Whether to batch SQL statements when executing them. Batching can save up to 99 percent of network roundtrips by sending up to 100 statements at once over the network to the database, instead of sending each statement individually. 

This is particularly useful for very large SQL migrations composed of multiple MB or even GB of reference data, as this can dramatically reduce the network overhead. 

This is supported for INSERT, UPDATE, DELETE, MERGE, and UPSERT statements. All other statements are automatically executed without batching.

## Default
false

## Usage

### Commandline
```
./flyway -batch="true" info
```

### Configuration File
```
flyway.batch=true
```

### Environment Variable
```
FLYWAY_BATCH=true
```

### API
```
Flyway.configure()
    .batch(true)
    .load()
```

### Gradle
```
flyway {
    batch = true
}
```

### Maven
```
<configuration>
    <batch>true</batch>
</configuration>
```