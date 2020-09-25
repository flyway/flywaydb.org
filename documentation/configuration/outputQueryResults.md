---
layout: documentation
menu: configuration
pill: outputQueryResults
subtitle: flyway.outputQueryResults
---

# Output Query Results
{% include teams.html %}

## Description
Controls whether Flyway should output a table with the results of queries when executing migrations. 

## Default
true

## Usage

### Commandline
```
./flyway -outputQueryResults="false" info
```

### Configuration File
```
flyway.outputQueryResults=false
```

### Environment Variable
```
FLYWAY_OUTPUT_QUERY_RESULTS=false
```

### API
```
Flyway.configure()
    .outputQueryResults(false)
    .load()
```

### Gradle
```
flyway {
    outputQueryResults = false
}
```

### Maven
```
<configuration>
    <outputQueryResults>false</outputQueryResults>
</configuration>
```