---
layout: documentation
menu: snowflake
subtitle: Snowflake
---
# Snowflake

## Supported Versions

- `4.x` versions up to 4.2
- `3.50` and later `3.x` versions

## Drivers

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:snowflake://<i>account</i>.snowflakecomputing.com/?db=<i>database</i>&warehouse=<i>warehouse</i>&role=<i>role</i></code>
(optionally <code>&schema=<i>schema</i></code> to specify current schema)</td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>net.snowflake:snowflake-jdbc:3.6.23</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>3.6.23</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>net.snowflake.client.jdbc.SnowflakeDriver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **;**

### Compatibility

- DDL exported by the Snowflake web GUI can be used unchanged in a Flyway migration
- Any SQL script executed by Flyway, can be executed by the Snowflake web GUI (after the placeholders have been replaced)
- The Snowflake driver requires Java 8+. There is no support from Snowflake for Java 7 users.

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
</pre>

## Limitations

- *None*

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sqlite">SQLite <i class="fa fa-arrow-right"></i></a>
</p>