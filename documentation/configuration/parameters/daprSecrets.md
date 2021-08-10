---
layout: documentation
menu: configuration
pill: daprSecrets
subtitle: flyway.daprSecrets
---

# Dapr Secrets
{% include teams.html %}

## Description
A comma-separated list of paths to key-value secrets in a
[Dapr](https://docs.dapr.io/developing-applications/building-blocks/secrets/secrets-overview/) Secret Store that contain 
Flyway configurations. 

If multiple secrets specify the same configuration parameter, then the last secret takes precedence.

Example: `secret1,secret2`

## Usage

### Commandline
```powershell
./flyway -dapr.secrets="secret1,secret2" info
```

### Configuration File
```properties
flyway.dapr.secrets=secret1,secret2
```

### Environment Variable
```properties
FLYWAY_DAPR_SECRETS=secret1,secret2
```

### API
```java
Configuration configuration = new ClassicConfiguration();
DaprApiExtension apiExtension = configuration.getExtensionConfiguration(DaprApiExtension.class);
apiExtension.setVaultSecrets("secret1", "secret2");
```

### Gradle
```groovy
flyway {
    daprConfiguration {
        daprSecrets = ['secret1', 'secret2']
    }
}
```

### Maven
```xml
<configuration>
    <daprConfiguration>
        <daprSecrets>
            <daprSecret>secret1</daprSecret>
            <daprSecret>secret2</daprSecret>
        </daprSecrets>
    </daprConfiguration>
</configuration>
```
