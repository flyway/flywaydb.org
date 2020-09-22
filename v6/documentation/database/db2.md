---
layout: documentation
menu: db2
subtitle: DB2
---
# DB2

## Supported Variants

- LUW

## Supported Versions

- `11.5`
- `11.1`
- `10.5` {% include enterprise.html %}
- `10.1` {% include enterprise.html %}
- `9.8` {% include enterprise.html %}
- `9.7` {% include enterprise.html %}


## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:db2://<i>host</i>:<i>port</i>/<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Download</th>
<td>Follow instructuctions on <a href="http://www-01.ibm.com/support/docview.wss?uid=swg21363866">ibm.com</a></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>4.16.53</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.ibm.db2.jcc.DB2Driver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/v6/documentation/migrations#sql-based-migrations#syntax)
- DB2 SQL-PL
- Terminator changes

### Compatibility

- DDL exported by DB2 can be used unchanged in a Flyway migration
- Any DB2 SQL script executed by Flyway, can be executed by db2 (after the placeholders have been replaced).

### Example

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

-- Placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');

-- SQL-PL
CREATE TRIGGER uniqueidx_trigger BEFORE INSERT ON usertable
	REFERENCING NEW ROW AS newrow
    FOR EACH ROW WHEN (newrow.name is not null)
	BEGIN ATOMIC
      IF EXISTS (SELECT * FROM usertable WHERE usertable.name = newrow.name) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duplicate name';
      END IF;
    END;

-- Terminator changes
--#SET TERMINATOR @
CREATE FUNCTION TEST_FUNC(PARAM1 INTEGER, PARAM2 INTEGER)
  RETURNS INTEGER
LANGUAGE SQL
  RETURN
  1@   
--#SET TERMINATOR ;
CREATE FUNCTION TEST_FUNC(PARAM1 INTEGER, PARAM2 INTEGER, PARAM3 INTEGER)
  RETURNS INTEGER
LANGUAGE SQL
  RETURN
  1;
```
 
## Limitations

- *None*

<p class="next-steps">
    <a class="btn btn-primary" href="/v6/documentation/database/mysql">MySQL<i class="fa fa-arrow-right"></i></a>
</p>