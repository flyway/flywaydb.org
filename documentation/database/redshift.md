---
layout: documentation
menu: redshift
subtitle: Redshift
---
# Redshift

## Driver

<table class="table">
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
<th>Supported versions</th>
<td><code>1.2.10.1009</code> and later v1</td>
</tr>
<tr>
<th></th>
<td><code>2.0</code> and later (see below)</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.amazon.redshift.jdbc42.Driver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/concepts/migrations#sql-based-migrations#syntax) with statement delimiter **;**
- Stored procedures (CREATE FUNCTION with $$ escapes)

### Compatibility

- DDL exported by pg_dump can be used unchanged in a Flyway migration. Please note that Redshift does not support exporting data using
        pg_dump, so you must export only the schema, using <code>pg_dump -s</code>.
- Any Redshift SQL script executed by Flyway,
        can be executed by the PostgreSQL command-line tool and other PostgreSQL-compatible tools,
        such as SQL Workbench/J (after the placeholders have been replaced).

#### v2 Driver issues

- The v2 JDBC driver is available as source from [Github](https://github.com/aws/amazon-redshift-jdbc-driver) rather
than Maven Central. There appear to be issues with it at the time of writing which mean that transactions cannot be used,
and it is therefore not a direct substitute for the v1 driver. We do not recommend its use.

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
INSERT INTO test_data (value) VALUES ('Hello');

CREATE VIEW value_only AS SELECT value FROM test_data;

CREATE TABLE another_table AS SELECT 'some-data' as name;

CREATE FUNCTION add(integer, integer) RETURNS integer
     IMMUTABLE
    AS $$
    select $1 + $2;
$$ LANGUAGE sql;

-- Placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');</pre>

## Limitations

Due to Redshift limitations `ALTER TABLE` and `DROP TABLE` for **external tables** cannot run within a transaction, yet Flyway doesn't
autodetect this. You can work around this limitation and successfully execute such a statement by including a `VACUUM`
statement in the same SQL file as this will force Flyway to run the entire migration without a transaction.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/cockroachdb">CockroachDB <i class="fa fa-arrow-right"></i></a>
</p>