---
layout: documentation
menu: configuration
pill: vaultToken
subtitle: flyway.vaultToken
---

# Vault Token
{% include teams.html %}

## Description
The [Vault](https://www.vaultproject.io/) token required to access your secrets.

## Usage

### Commandline
```powershell
./flyway -vault.token="s.abcdefghijklmnopqrstuvwx" info
```

### Configuration File
```properties
flyway.vault.token=s.abcdefghijklmnopqrstuvwx
```

### Environment Variable
```properties
FLYWAY_VAULT_TOKEN=s.abcdefghijklmnopqrstuvwx
```

### API
```java
Flyway.configure()
    .vaultToken("s.abcdefghijklmnopqrstuvwx")
    .load()
```

### Gradle
```groovy
flyway {
    vaultConfiguration {
        vaultToken = 's.abcdefghijklmnopqrstuvwx'
    }
}
```

### Maven
```xml
<configuration>
    <vaultConfiguration>
        <vaultToken>s.abcdefghijklmnopqrstuvwx</vaultToken>
    </vaultConfiguration>
</configuration>
```
