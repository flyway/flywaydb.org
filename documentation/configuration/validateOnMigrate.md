---
layout: documentation
menu: configuration
pill: validateOnMigrate
subtitle: flyway.validateOnMigrate
---

# Validate On Migrate

## Description
Whether to automatically call [validate](/documentation/command/validate) or not when running migrate.

## Default
true

## Usage

### Commandline
```
./flyway -validateOnMigrate="false" migrate
```

### Configuration File
```
flyway.validateOnMigrate=false
```

### Environment Variable
```
FLYWAY_VALIDATE_ON_MIGRATE=false
```

### API
```
Flyway.configure()
    .validateOnMigrate(false)
    .load()
```

### Gradle
```
flyway {
    validateOnMigrate = false
}
```

### Maven
```
<configuration>
    <validateOnMigrate>false</validateOnMigrate>
</configuration>
```