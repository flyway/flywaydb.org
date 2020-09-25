---
layout: documentation
menu: configuration
pill: user
subtitle: flyway.user
---

# User

## Description
The user to use to connect to the database.

This can be omitted if the user is baked into the [url](/documentation/configuration/url) (See [Sql Server](/documentation/database/sqlserver#windows-authentication) for an example).

## Usage

### Commandline
```
./flyway -user=myuser info
```

### Configuration File
```
flyway.user=myuser
```

### Environment Variable
```
FLYWAY_USER=myuser
```

### API
```
Flyway.configure()
    .user("myuser")
    .load()
```

### Gradle
```
flyway {
    user = 'myuser'
}
```

### Maven
```
<configuration>
    <user>myuser</user>
</configuration>
```