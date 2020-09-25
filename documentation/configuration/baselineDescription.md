---
layout: documentation
menu: configuration
pill: baselineDescription
subtitle: flyway.baselineDescription
---

# Baseline Description

## Description
The Description to tag an existing schema with when executing [baseline](/documentation/command/baseline).

## Default
<nobr>&lt;&lt; Flyway Baseline &gt;&gt;</nobr>

## Usage

### Commandline
```
./flyway -baselineDescription="Baseline" baseline
```

### Configuration File
```
flyway.baselineDescription=Baseline
```

### Environment Variable
```
FLYWAY_BASELINE_DESCRIPTION=Baseline
```

### API
```
Flyway.configure()
    .baselineDescription("Baseline")
    .load()
```

### Gradle
```
flyway {
    baselineDescription = 'Baseline'
}
```

### Maven
```
<configuration>
    <baselineDescription>Baseline</baselineDescription>
</configuration>
```