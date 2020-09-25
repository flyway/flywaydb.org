---
layout: documentation
menu: configuration
pill: password
subtitle: flyway.password
---

# Password

## Description
The password to use to connect to the database

This can be omitted if the password is baked into the [url](/documentation/configuration/url) (See [Sql Server](/documentation/database/sqlserver#windows-authentication) for an example), or if password is provided through another means (such as [aws secrets](/documentation/awsSecretsManager)).

## Usage

### Commandline
```
./flyway -password=mysecretpassword info
```

### Configuration File
```
flyway.password=mysecretpassword
```

### Environment Variable
```
FLYWAY_PASSWORD=mysecretpassword
```

### API
```
flyway.configure()
    .password("mysecretpassword")
    .load()
```

### Gradle
```
flyway {
    password = 'mysecretpassword'
}
```

### Maven
```
<configuration>
    <password>mysecretpassword</password>
</configuration>
```