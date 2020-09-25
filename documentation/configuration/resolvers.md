---
layout: documentation
pill: resolvers
subtitle: flyway.resolvers
---

# Resolver

## Description
Comma-separated list of fully qualified class names of custom [MigrationResolver](/documentation/api/javadoc/org/flywaydb/core/api/resolver/MigrationResolver) implementations to be used in addition to the built-in ones for resolving Migrations to apply.

You must ensure that the resolver is available on the classpath (see [Adding to the classpath](/documentation/addingToTheClasspath)).

## Usage

### Commandline
```
./flyway -resolvers="my.resolver.MigrationResolver" info
```

### Configuration File
```
flyway.resolvers=my.resolver.MigrationResolver
```

### Environment Variable
```
FLYWAY_RESOLVERS=my.resolver.MigrationResolver
```

### API
```
flyway.configure()
    .resolvers("my.resolver.MigrationResolver")
    .load()
```

### Gradle
```
flyway {
    resolvers = 'my.resolver.MigrationResolver'
}
```

### Maven
```
<configuration>
    <resolvers>my.resolver.MigrationResolver</resolvers>
</configuration>
```