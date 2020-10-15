---
layout: documentation
menu: configuration
pill: licenseKey
subtitle: flyway.licenseKey
redirect_from: /documentation/configuration/licenseKey
---

# License Key
{% include teams.html %}

## Description
Your Flyway license key (`FL01...`) when using Flyway Teams. This should be 516 alpha numeric characters, beginning with `FL`.

Not yet a Flyway Teams Edition customer? Request your <a href="" data-toggle="modal" data-target="#flyway-trial-license-modal">Flyway trial license key</a> to try out Flyway Teams Edition features free for 28 days.

## Usage

### Commandline
```powershell
./flyway -licenseKey="FL01..." info
```

### Configuration File
```properties
flyway.licenseKey=FL01...
```

### Environment Variable
```properties
FLYWAY_LICENSE_KEY=FL01...
```

### API
```java
Flyway.configure()
    .licenseKey("FL01...")
    .load()
```

### Gradle
```groovy
flyway {
    licenseKey = 'FL01...'
}
```

### Maven
```xml
<configuration>
    <licenseKey>FL01...</licenseKey>
</configuration>
```