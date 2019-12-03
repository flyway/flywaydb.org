---
layout: configuration
menu: placeholders
subtitle: Placeholders
pill: placeholders
---
# Placeholder Replacement
In addition to regular SQL syntax, Flyway also supports placeholder replacement with configurable pre- and suffixes.
By default it looks for Ant-style placeholders like `${myplaceholder}`. This can be very useful to abstract differences between environments.

Flyway also provides default placeholders, whose values are automatically populated:

- `${flyway:defaultSchema}`
- `${flyway:user}`
- `${flyway:database}`

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
  <a class="btn btn-primary" href="/documentation/scriptconfig">Script Config Files <i class="fa fa-arrow-right"></i></a>
</p>
