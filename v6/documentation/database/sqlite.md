---
layout: documentationv6
menu: sqlite
subtitle: SQLite
---
# SQLite

## Supported Versions

- `3.7` and later `3.x` versions

## Drivers

<table class="table">
<thead>
<tr>
<th></th>
<th>Java (Xerial)</th>
<th>Android (SQLDroid)</th>
</tr>
</thead>
<tr>
<th>URL format</th>
<td><code>jdbc:sqlite:<i>database</i></code></td>
<td><code>jdbc:sqlite:<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
<td>No</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>org.xerial:sqlite-jdbc:3.30.1</code></td>
<td><code>org.sqldroid:sqldroid:1.1.0-rc1</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>3.7</code> and later</td>
<td><code>1.1.0-rc1</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>org.sqlite.JDBC</code></td>
<td><code>org.sqldroid.SQLDroidDriver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](v6/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **;**
- Triggers with `BEGIN ... END;` block

### Compatibility

- DDL exported by SQLite can be used unchanged in a Flyway migration
- Any SQLite SQL script executed by Flyway, can be executed by the SQLite tools (after the placeholders have been replaced)

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
INSERT INTO ${tableName} (name) VALUES ('Mr. T');

CREATE TRIGGER update_customer_address UPDATE OF address ON customers
  BEGIN
    UPDATE orders SET address = new.address WHERE customer_name = old.name;
  END;</pre>

## Limitations

- No concurrent migration as SQLite does not support `SELECT ... FOR UPDATE` locking
- No support for multiple schemas or changing the current schema, as SQLite doesn't support schemas
- No support for `CREATE TRANSACTION` and `COMMIT` statements within a migration, as SQLite doesn't support nested transactions

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/database/firebird">Firebird <i class="fa fa-arrow-right"></i></a>
</p>