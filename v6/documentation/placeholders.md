---
layout: documentationv6
menu: placeholders
subtitle: Placeholders
---
# Placeholders
In addition to regular SQL syntax, Flyway also supports placeholder replacement with configurable pre- and suffixes.
By default it looks for Ant-style placeholders like `${myplaceholder}`. This can be very useful to abstract differences between environments.

Changing the value of placeholders will cause repeatable migrations to be re-applied on next migrate.

Flyway also provides default placeholders, whose values are automatically populated:

- `${flyway:defaultSchema}` = The default schema for Flyway
- `${flyway:user}` = The user Flyway will use to connect to the database
- `${flyway:database}` = The name of the database from the connection url
- `${flyway:timestamp}` = The time that Flyway parsed the migration, formatted as 'yyyy-MM-dd HH:mm:ss'

### Example
Here is a small example of the supported syntax:

```sql
/* Single line comment */
CREATE TABLE test_user (
  name VARCHAR(25) NOT NULL,
  PRIMARY KEY(name)
);

/*
Multi-line
comment
*/

-- Default placeholders
GRANT SELECT ON SCHEMA ${flyway:defaultSchema} TO ${flyway:user};

-- User defined placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');
```

<p class="next-steps">
  <a class="btn btn-primary" href="v6/documentation/scriptconfigfiles">Script Config Files <i class="fa fa-arrow-right"></i></a>
</p>