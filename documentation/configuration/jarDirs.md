---
layout: documentation
menu: configuration
pill: jarDirs
subtitle: flyway.jarDirs
---

# Jar Dirs

## Description
Comma-separated list of directories containing JDBC drivers and Java-based migrations.

## Default
<nobr><i>&lt;install-dir&gt;</i>/jars</nobr>

## Usage

This configuration parameter will only be used in the command line version of Flyway.

### Commandline
```
./flyway -jarDirs="/my/jar/dir" info
```

### Configuration File
Not available

### Environment Variable
```
FLYWAY_JAR_DIRS=/my/jar/dir
```

### API
Not available

### Gradle
Not available

### Maven
Not available