---
layout: documentation
menu: oracle
subtitle: Oracle
---
# Oracle

## Supported Versions

- `12.2`
- `12.1`
- `11.2` <span class="label label-primary">Flyway Enterprise</span>
- `11.1` <span class="label label-primary">Flyway Enterprise</span>
- `10.2` <span class="label label-primary">Flyway Enterprise</span>
- `10.1` <span class="label label-primary">Flyway Enterprise</span>

All editions are supported, including XE.

## Driver

<table class="table">
<thead>
<tr>
<th></th>
<th>Oracle</th>
</tr>
</thead>
<tr>
<th>Supported versions</th>
<td><code>11.2</code> and later</td>
</tr>
<tr>
<th>URL format</th>
<td><code>jdbc:oracle:thin:@//<i>host</i>:<i>port</i>/<i>service</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Download</th>
<td>Follow instructuctions on <a href="http://www.oracle.com/technetwork/database/features/jdbc/index.html">oracle.com</a></td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>oracle.jdbc.OracleDriver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migration/sql#syntax) with statement delimiter **;**
- PL/SQL blocks starting with DECLARE or BEGIN and finishing with END; /

### Compatibility

- DDL exported by Oracle can be used unchanged in a Flyway migration
- Any Oracle SQL script executed by Flyway, can be executed by SQL*Plus
        and other Oracle-compatible tools (after the placeholders have been replaced)

### Example

<pre class="prettyprint">/* Single line comment */
CREATE TABLE test_user (
 name VARCHAR(25) NOT NULL,
 PRIMARY KEY(name)
);

/*
Multi-line
comment
*/
-- PL/SQL block
CREATE TRIGGER test_trig AFTER insert ON test_user
BEGIN
   UPDATE test_user SET name = CONCAT(name, &#x27; triggered&#x27;);
END;
/

-- Placeholder
INSERT INTO ${tableName} (name) VALUES (&#x27;Mr. T&#x27;);</pre>

## Limitations

- SPATIAL EXTENSIONS: sdo_geom_metadata can only be cleaned for the user currently logged in
- No support for SQL*Plus-specific commands that have no JDBC equivalent (SET DEFINE OFF, ...)
- No support for executing external scripts referenced with @other.script, as supported by SQL*Plus

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sqlserver">SQL Server <i class="fa fa-arrow-right"></i></a>
</p>