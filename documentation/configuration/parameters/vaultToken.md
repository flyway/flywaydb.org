---
layout: documentation
menu: configuration
pill: vaultToken
subtitle: flyway.vaultToken
---

# Vault Token
{% include teams.html %}

## Description
The Vault token required to access your secrets.

## Usage

### Commandline
```powershell
./flyway -vaultToken="s.abcdefghijklmnopqrstuvwx" info
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
    vaultToken = 's.abcdefghijklmnopqrstuvwx'
}
```

### Maven
```xml
<configuration>
    <vaultToken>s.abcdefghijklmnopqrstuvwx</vaultToken>
</configuration>
```
