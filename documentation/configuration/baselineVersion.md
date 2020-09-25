---
layout: documentation
menu: configuration
pill: baselineVersion
subtitle: flyway.baselineVersion
---

# Baseline Version

## Description
The version to tag an existing schema with when executing [baseline](/documentation/command/baseline).

## Default
1

## Usage

### Commandline
```
./flyway -baselineVersion="0.0" baseline
```

### Configuration File
```
flyway.baselineVersion=0.0
```

### Environment Variable
```
FLYWAY_BASELINE_VERSION=0.0
```

### API
```
flyway.configure()
    .baselineVersion("0.0")
    .load()
```

### Gradle
```
flyway {
    baselineVersion = '0.0'
}
```

### Maven
```
<configuration>
    <baselineVersion>0.0</baselineVersion>
</configuration>
```