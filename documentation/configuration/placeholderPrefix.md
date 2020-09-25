---
layout: documentation
pill: placeholderPrefix
subtitle: flyway.placeholderPrefix
---

# Placeholder Prefix

## Description
The prefix of every [placeholder](/documentation/placeholders)

## Default
${

## Usage

### Commandline
```
./flyway -placeholderPrefix="$$" info
```

### Configuration File
```
flyway.placeholderPrefix=$$
```

### Environment Variable
```
FLYWAY_PLACEHOLDER_PREFIX=$$
```

### API
```
flyway.configure()
    .placeholderPrefix("$$")
    .load()
```

### Gradle
```
flyway {
    placeholderPrefix = '$$'
}
```

### Maven
```
<configuration>
    <placeholderPrefix>$$</placeholderPrefix>
</configuration>
```