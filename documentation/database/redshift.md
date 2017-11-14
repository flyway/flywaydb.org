---
layout: documentation
menu: redshift
subtitle: Redshift
---
# Redshift

## Driver

<table class="table">
<thead>
<tr>
<th></th>
<th>Redshift</th>
</tr>
</thead>
<tr>
<th>Supported versions</th>
<td><code>1.2.10.1009</code> and later</td>
</tr>
<tr>
<th>URL format</th>
<td><code>jdbc:redshift://<i>host</i>:<i>port</i>/<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Download</th>
<td>Follow the instructions at <a href="http://docs.aws.amazon.com/redshift/latest/mgmt/configure-jdbc-connection.html#download-jdbc-driver">docs.aws.amazon.com</a></td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.amazon.redshift.jdbc42.Driver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migration/sql#syntax) with statement delimiter **;**
- Stored procedures (CREATE FUNCTION with $$ escapes)

### Compatibility

- DDL exported by pg_dump can be used unchanged in a Flyway migration. Please note that Redshift does not support exporting data using
        pg_dump, so you must export only the schema, using <code>pg_dump -s</code>.
- Any Redshift SQL script executed by Flyway,
        can be executed by the PostgreSQL command-line tool and other PostgreSQL-compatible tools,
        such as SQL Workbench/J (after the placeholders have been replaced).

### Example

<pre class="prettyprint">/* Single line comment */
CREATE TABLE test_data (
  test_id INT IDENTITY NOT NULL PRIMARY KEY,
  value VARCHAR(25) NOT NULL
);

/*
Multi-line
comment
*/
INSERT INTO test_data (value) VALUES (&#x27;Hello&#x27;);

CREATE VIEW value_only AS SELECT value FROM test_data;

CREATE TABLE another_table AS SELECT &#x27;some-data&#x27; as name;

CREATE FUNCTION add(integer, integer) RETURNS integer
     IMMUTABLE
    AS $$
    select $1 + $2;
$$ LANGUAGE sql;

-- Placeholder
INSERT INTO ${tableName} (name) VALUES (&#x27;Mr. T&#x27;);</pre>

## Limitations

- *None*

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sybasease">Sybase ASE <i class="fa fa-arrow-right"></i></a>
</p>