---
layout: documentation
menu: configuration
pill: daprUrl
subtitle: flyway.daprUrl
---

# Dapr URL
{% include teams.html %}

## Description
The REST API URL of your [Dapr](https://docs.dapr.io/developing-applications/building-blocks/secrets/secrets-overview/) sidecar, 

Example: `http://localhost:3500/v1.0/secrets/my-secrets-store`

## Usage

### Commandline
```powershell
./flyway -dapr.url="http://localhost:3500/v1.0/secrets/my-secrets-store" info
```

### Configuration File
```properties
flyway.dapr.url=http://localhost:3500/v1.0/secrets/my-secrets-store
```

### Environment Variable
```properties
FLYWAY_DAPR_URL=http://localhost:3500/v1.0/secrets/my-secrets-store
```

### API
```java
Configuration configuration = new ClassicConfiguration();
DaprApiExtension apiExtension = configuration.getExtensionConfiguration(DaprApiExtension.class);
apiExtension.setVaultUrl("http://localhost:3500/v1.0/secrets/my-secrets-store");
```

### Gradle
```groovy
flyway {
    daprConfiguration {
        daprUrl = 'http://localhost:3500/v1.0/secrets/my-secrets-store'
    }
}
```

### Maven
```xml
<configuration>
    <daprConfiguration>
        <daprUrl>http://localhost:3500/v1.0/secrets/my-secrets-store</daprUrl>
    </daprConfiguration>
</configuration>
```
