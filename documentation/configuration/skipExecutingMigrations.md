---
layout: documentation
menu: configuration
pill: skipExecutingMigrations
subtitle: flyway.skipExecutingMigrations
---

# Skip Executing Migrations
{% include teams.html %}

## Description
Whether Flyway should skip actually executing the contents of the migrations and only update the schema history table.
    
This should be used when you have applied a migration manually (via executing the sql yourself, or via an ide), and just want the schema history table to reflect this.

This is useful when executing an script against your database manually. For instance, when you apply an out-of-process change like a hotfix. The hotfix script can be turned into a migration and applied with `skipExecutingMigrations=true`. The schema history table will be updated, but the hotfix script won't be run gain.

When combined with [cherryPick](/documentation/configuration/cherryPick), you can gain a lot more control of how your deployments take place.

## Default
false

## Usage

### Commandline
```
./flyway -skipExecutingMigrations="true" info
```

### Configuration File
```
flyway.skipExecutingMigrations=true
```

### Environment Variable
```
FLYWAY_SKIP_EXECUTING_MIGRATIONS=true
```

### API
```
Flyway.configure()
    .skipExecutingMigrations(true)
    .load()
```

### Gradle
```
flyway {
    skipExecutingMigrations = true
}
```

### Maven
```
<configuration>
    <skipExecutingMigrations>true</skipExecutingMigrations>
</configuration>
```