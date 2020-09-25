---
layout: documentation
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
FLYWAY_PLACEHOLDER_PREFIX=$$
```

### API
```
flyway.configure()
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