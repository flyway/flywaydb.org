---
layout: documentation
menu: configuration
pill: cherryPick
subtitle: flyway.cherryPick
---

# Cherry Pick
{% include teams.html %}

## Description
A Comma separated list of migrations that Flyway should consider when migrating. Leave blank to consider all discovered migrations.

Each item in the list must either be a valid migration version (e.g `2.1`) or a valid migration description (e.g. `create_table`).

## Usage

### Commandline
```
./flyway -cherryPick="2.0" migrate
```

### Configuration File
```
flyway.cherryPick=2.0
```

### Environment Variable
```
FLYWAY_CHERRY_PICK=2.0
```

### API
```
flyway.configure()
    .cherryPick("2.0")
    .load()
```

### Gradle
```
flyway {
    cherryPick = '2.0'
}
```

### Maven
```
<configuration>
    <cherryPick>2.0</cherryPick>
</configuration>
```