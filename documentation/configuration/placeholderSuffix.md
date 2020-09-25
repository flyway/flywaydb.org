---
layout: documentation
menu: configuration
pill: placeholderSuffix
subtitle: flyway.placeholderSuffix
---

# Placeholder Suffix

## Description
The suffix of every [placeholder](/documentation/placeholders)

## Default
}

## Usage

### Commandline
```
./flyway -placeholderSuffix="$$" info
```

### Configuration File
```
flyway.placeholderSuffix=$$
```

### Environment Variable
```
FLYWAY_PLACEHOLDER_SUFFIX=$$
```

### API
```
Flyway.configure()
    .placeholderSuffix("$$")
    .load()
```

### Gradle
```
flyway {
    placeholderSuffix = '$$'
}
```

### Maven
```
<configuration>
    <placeholderSuffix>$$</placeholderSuffix>
</configuration>
```