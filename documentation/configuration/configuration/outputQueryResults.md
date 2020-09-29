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
```powershell
./flyway -outputQueryResults="false" info
```

### Configuration File
```properties
flyway.outputQueryResults=false
```

### Environment Variable
```properties
FLYWAY_OUTPUT_QUERY_RESULTS=false
```

### API
```java
Flyway.configure()
    .outputQueryResults(false)
    .load()
```

### Gradle
```groovy
flyway {
    outputQueryResults = false
}
```

### Maven
```xml
<configuration>
    <outputQueryResults>false</outputQueryResults>
</configuration>
```