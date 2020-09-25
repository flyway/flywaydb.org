---
layout: documentation
pill: placeholderReplacement
subtitle: flyway.placeholderReplacement
---

# Placeholder Replacement

## Description
Whether [placeholders](/documentation/placeholders) should be replaced

## Default
true

## Usage

### Commandline
```
./flyway -placeholderReplacement="false" info
```

### Configuration File
```
flyway.placeholderReplacement=false
```

### Environment Variable
```
FLYWAY_PLACEHOLDER_REPLACEMENT=false
```

### API
```
flyway.configure()
    .placeholderReplacement(false)
    .load()
```

### Gradle
```
flyway {
    placeholderReplacement = false
}
```

### Maven
```
<configuration>
    <placeholderReplacement>false</placeholderReplacement>
</configuration>
```