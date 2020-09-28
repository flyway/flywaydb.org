---
layout: documentation
menu: configuration
pill: cherryPick
subtitle: flyway.cherryPick
---

# Cherry Pick
{% include teams.html %}

## Description
A Comma separated list of migrations that Flyway should consider when migrating, undoing, or repairing. Leave blank to consider all discovered migrations.

Each item in the list must either be a valid migration version (e.g `2.1`) or a valid migration description (e.g. `create_table`).

For example:
- Create migrations `V1__create_table1.sql`, `V2__create_table2.sql`, and `R__create_view.sql`
- Run `flyway migrate -cherryPick="1,create_view"`

The schema history table now shows migration `V1` and `create_view` as being successfully applied. However `V2` has been skipped and is marked as 'ignored'. `V2__create_table2.sql` can be cherry picked for deployment at a later time.

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
Flyway.configure()
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