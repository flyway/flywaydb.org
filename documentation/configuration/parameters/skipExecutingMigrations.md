---
layout: documentation
menu: configuration
pill: skipExecutingMigrations
subtitle: flyway.skipExecutingMigrations
redirect_from: /documentation/configuration/skipExecutingMigrations
---

# Skip Executing Migrations
{% include teams.html %}

## Description
Whether Flyway should skip actually executing the contents of the migrations and only update the schema history table.
    
This should be used when you have applied a migration manually (via executing the sql yourself, or via an ide), and just want the schema history table to reflect this.

This is useful when executing an script against your database manually. For instance, when you apply an out-of-process change like a hotfix. The hotfix script can be turned into a migration and applied with `skipExecutingMigrations=true`. The schema history table will be updated, but the hotfix script won't be run gain.

When combined with [cherryPick](/documentation/configuration/parameters/cherryPick), you can gain a lot more control of how your deployments take place.

## Default
false

## Usage

### Commandline
```powershell
./flyway -skipExecutingMigrations="true" info
```

### Configuration File
```properties
flyway.skipExecutingMigrations=true
```

### Environment Variable
```properties
FLYWAY_SKIP_EXECUTING_MIGRATIONS=true
```

### API
```java
Flyway.configure()
    .skipExecutingMigrations(true)
    .load()
```

### Gradle
```groovy
flyway {
    skipExecutingMigrations = true
}
```

### Maven
```xml
<configuration>
    <skipExecutingMigrations>true</skipExecutingMigrations>
</configuration>
```