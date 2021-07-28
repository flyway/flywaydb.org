---
layout: documentation
menu: configuration
pill: vaultSecrets
subtitle: flyway.vaultSecrets
---

# Vault Secrets
{% include teams.html %}

## Description
A comma-separated list of paths to key-value secrets in [Vault](https://www.vaultproject.io/) that contain Flyway configurations. This must start with the name of the engine and end with the name of the secret.

The resulting form is `{engine_name}/data/{path}/{to}/{secret_name}` for the key-value V2 engine, and `{engine_name}/{path}/{to}/{secret_name}` for the key-value V1 engine.
If multiple secrets specify the same configuration parameter, then the last secret takes precedence.

Example: `kv/data/flyway/flywayConfig`

## Usage

### Commandline
```powershell
./flyway -vault.secrets="kv/data/flyway/flywayConfig1,kv/flyway/flywayConfig2" info
```

### Configuration File
```properties
flyway.vault.secrets=kv/data/flyway/flywayConfig1,kv/flyway/flywayConfig2
```

### Environment Variable
```properties
FLYWAY_VAULT_SECRETS=kv/data/flyway/flywayConfig1,kv/flyway/flywayConfig2
```

### API
```java
Configuration configuration = new ClassicConfiguration();
VaultApiExtension apiExtension = configuration.getExtensionConfiguration(VaultApiExtension.class);
apiExtension.setVaultSecrets("kv/data/flyway/flywayConfig1", "kv/flyway/flywayConfig2");
```

### Gradle
```groovy
flyway {
    vaultSecrets = 'kv/data/flyway/flywayConfig1,kv/flyway/flywayConfig2'
}
```

### Maven
```xml
<configuration>
    <vaultSecrets>kv/data/flyway/flywayConfig1,kv/flyway/flywayConfig2</vaultSecrets>
</configuration>
```
