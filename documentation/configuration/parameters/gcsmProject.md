---
layout: documentation
menu: configuration
pill: gcsmProject
subtitle: flyway.gcsm.project
---

# Google Cloud Secret Manager Project
{% include teams.html %}

## Description
The GCSM Project that you are storing secrets in

Example: `quixotic-ferret-345678`

## Usage

### Commandline
```powershell
./flyway -gcsm.project="quixotic-ferret-345678" info
```

### Configuration File
```properties
flyway.gcsm.project=quixotic-ferret-345678
```

### Environment Variable
```properties
FLYWAY_GCSM_PROJECT=quixotic-ferret-345678
```

### API
```java
Configuration configuration = new ClassicConfiguration();
GcsmApiExtension apiExtension = configuration.getExtensionConfiguration(GcsmApiExtension.class);
apiExtension.setGcsmProject("quixotic-ferret-345678");
```

### Gradle
```groovy
flyway {
    gcsmConfiguration {
        gcsmProject = 'quixotic-ferret-345678'
    }
}
```

### Maven
```xml
<configuration>
    <gcsmConfiguration>
        <gcsmProject>quixotic-ferret-345678</gcsmProject>
    </gcsmConfiguration>
</configuration>
```
