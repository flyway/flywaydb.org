---
layout: documentation
menu: configuration
pill: vaultUrl
subtitle: flyway.vaultUrl
---

# Vault URL
{% include teams.html %}

## Description
The REST API URL of your [Vault](https://www.vaultproject.io/) server, including the API version. Currently only supports API version v1.

Example: `http://localhost:8200/v1/`

## Usage

### Commandline
```powershell
./flyway -vault.url="http://localhost:8200/v1/" info
```

### Configuration File
```properties
flyway.vault.url=http://localhost:8200/v1/
```

### Environment Variable
```properties
FLYWAY_VAULT_URL=http://localhost:8200/v1/
```

### API
```java
Configuration configuration = new ClassicConfiguration();
VaultApiExtension apiExtension = configuration.getExtensionConfiguration(VaultApiExtension.class);
apiExtension.setVaultUrl("http://localhost:8200/v1/");
```

### Gradle
```groovy
flyway {
    vaultUrl = 'http://localhost:8200/v1/'
}
```

### Maven
```xml
<configuration>
    <vaultUrl>http://localhost:8200/v1/</vaultUrl>
</configuration>
```
