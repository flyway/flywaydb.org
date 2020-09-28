---
layout: documentation
menu: configuration
pill: outOfOrder
subtitle: flyway.outOfOrder
---

# Out Of Order

## Description
Allows migrations to be run "out of order".

If you already have versions `1.0` and `3.0` applied, and now a version `2.0` is found, it will be applied too instead of being ignored.

## Default
false

## Usage

### Commandline
```
./flyway -outOfOrder="true" info
```

### Configuration File
```
flyway.outOfOrder=true
```

### Environment Variable
```
FLYWAY_OUT_OF_ORDER=true
```

### API
```
Flyway.configure()
    .outOfOrder(true)
    .load()
```

### Gradle
```
flyway {
    outOfOrder = true
}
```

### Maven
```
<configuration>
    <outOfOrder>true</outOfOrder>
</configuration>
```