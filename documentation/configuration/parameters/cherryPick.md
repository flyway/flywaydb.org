---
layout: documentation
menu: configuration
pill: cherryPick
subtitle: flyway.cherryPick
redirect_from: /documentation/configuration/cherryPick/
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
```powershell
./flyway -cherryPick="2.0" migrate
```

### Configuration File
```properties
flyway.cherryPick=2.0
```

### Environment Variable
```properties
FLYWAY_CHERRY_PICK=2.0
```

### API
```java
Flyway.configure()
    .cherryPick("2.0")
    .load()
```

### Gradle
```groovy
flyway {
    cherryPick = '2.0'
}
```

### Maven
```xml
<configuration>
    <cherryPick>2.0</cherryPick>
</configuration>
```

## Use Cases

### Deferred migration execution

Let's say you have a project with 3 migrations:

```
V1__fastCreate1.sql
V2__slowInsert2.sql
V3__fastCreate3.sql
```

Migration `V2` takes a tremendously large amount of time to execute so you decide executing it overnight would be better, but still need to execute migrations `V1` and `V3`. Without `cherryPick` this would involve deleting `V2` from disk and adding it back when needed which is a tedious and error prone task. Using `cherryPick` we can simply migrate `V1` and `V3` immediately:

```
flyway migrate -cherryPick="1,3"
```

When it comes to migrating `V2`, we can utilise [outOfOrder](http://localhost:4000/documentation/configuration/parameters/outOfOrder) as follows:

```
flyway migrate -cherryPick="2" -outOfOrder="true"
```
