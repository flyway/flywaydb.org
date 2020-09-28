---
layout: documentation
menu: configuration
pill: edition
subtitle: flyway.edition
---

# Edition
{% include teams.html %}

## Description
The version of flyway to use. This config parameter only applies to the Command Line version of Flyway. To change the edition of the Gradle or Maven plugins, simply change the dependency to the teams one (e.g. `compile "org.flywaydb:flyway-core:{{ site.flywayVersion }}"` -> `compile "org.flywaydb.enterprise:flyway-core:{{ site.flywayVersion }}"`).

## Usage

### Commandline
```
./flyway -teams info
```

### Configuration File
Not available

### Environment Variable
```
FLYWAY_EDITION=teams
```

### API
Not available

### Gradle
Not available

### Maven
Not available