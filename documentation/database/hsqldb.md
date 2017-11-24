---
layout: documentation
menu: hsqldb
subtitle: HSQLDB
---
# HSQLDB

## Supported Versions

- `2.4`
- `2.3`
- `2.2`
- `2.0`
- `1.8` {% include enterprise.html %}

## Driver

<table class="table">
<thead>
<tr>
<th></th>
<th>HSQLDB</th>
</tr>
</thead>
<tr>
<th>Supported versions</th>
<td><code>1.8</code> and later</td>
</tr>
<tr>
<th>URL format</th>
<td><code>jdbc:hsqldb:file:<i>file</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>org.hsqldb:hsqldb:1.4.196</code></td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>org.hsqldb.jdbcDriver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migration/sql#syntax) with statement delimiter **;**
- Triggers with `BEGIN ATOMIC ... END;` block

### Compatibility
    
- DDL exported by HSQLDB can be used unchanged in a Flyway migration
- Any HSQLDB SQL script executed by Flyway, can be executed by the Hsql tools (after the placeholders have been replaced)

### Example

<pre class="prettyprint">/* Single line comment */
CREATE TABLE test_data (
  value VARCHAR(25) NOT NULL PRIMARY KEY
);

/*
Multi-line
comment
*/

-- Sql-style comment

-- Placeholder
INSERT INTO ${tableName} (name) VALUES (&#x27;Mr. T&#x27;);

CREATE TRIGGER uniqueidx_trigger BEFORE INSERT ON usertable
	REFERENCING NEW ROW AS newrow
    FOR EACH ROW WHEN (newrow.name is not null)
	BEGIN ATOMIC
      IF EXISTS (SELECT * FROM usertable WHERE usertable.name = newrow.name) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'duplicate name';
      END IF;
    END;</pre>

## Limitations

- No concurrent migration support (to make Flyway cluster-safe) with HSQLDB 1.8, as this version does not properly support `SELECT ... FOR UPDATE` locking

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/derby">Derby <i class="fa fa-arrow-right"></i></a>
</p>