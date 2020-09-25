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
flyway.configure()
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