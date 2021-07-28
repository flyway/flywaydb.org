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
Configuration configuration = new ClassicConfiguration();
VaultApiExtension apiExtension = configuration.getExtensionConfiguration(VaultApiExtension.class);
apiExtension.setVaultToken("s.abcdefghijklmnopqrstuvwx");
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
