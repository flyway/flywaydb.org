---
layout: documentation
menu: configuration
pill: installedBy
subtitle: flyway.installedBy
---

# Installed By

## Description
The username that will be recorded in the schema history table as having applied the migration.

## Default
<i>Current database user</i>

## Usage

### Commandline
```
./flyway -installedBy="ci-pipeline" clean
```

### Configuration File
```
flyway.installedBy=ci-pipeline
```

### Environment Variable
```
FLYWAY_INSTALLED_BY=ci-pipeline
```

### API
```
Flyway.configure()
    .installedBy("ci-pipeline")
    .load()
```

### Gradle
```
flyway {
    installedBy = 'ci-pipeline'
}
```

### Maven
```
<configuration>
    <installedBy>ci-pipeline</installedBy>
</configuration>
```