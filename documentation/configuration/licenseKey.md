---
layout: documentation
menu: configuration
pill: licenseKey
subtitle: flyway.licenseKey
---

# Oracle SQL*Plus Warn
{% include teams.html %}

## Description
Your Flyway license key (FL01...). Not yet a Flyway Teams Edition customer? Request your <a href="" data-toggle="modal" data-target="#flyway-trial-license-modal">Flyway trial license key</a> to try out Flyway Teams Edition features free for 30 days.

## Usage

### Commandline
```
./flyway -licenseKey="FL01..." info
```

### Configuration File
```
flyway.licenseKey=FL01...
```

### Environment Variable
```
FLYWAY_LICENSE_KEY=FL01...
```

### API
```
Flyway.configure()
    .licenseKey("FL01...")
    .load()
```

### Gradle
```
flyway {
    licenseKey = 'FL01...'
}
```

### Maven
```
<configuration>
    <licenseKey>FL01...</licenseKey>
</configuration>
```