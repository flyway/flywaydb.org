---
layout: documentation
menu: oracle
subtitle: Oracle
---
# Oracle

## Supported Versions

- `18.3`
- `12.2`
- `12.1` {% include enterprise.html %}
- `11.2` {% include enterprise.html %}
- `11.1` {% include enterprise.html %}
- `10.2` {% include enterprise.html %}
- `10.1` {% include enterprise.html %}

All editions are supported, including XE.

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:oracle:thin:@//<i>host</i>:<i>port</i>/<i>service</i></code><br>
<code>jdbc:oracle:thin:@<i>tns_entry</i></code> *
</td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Download</th>
<td>Download the latest version of both <code>ojdbc8.jar</code> and <code>orai18n.jar</code> from
 <a href="http://www.oracle.com/technetwork/database/features/jdbc/index.html">oracle.com</a> 
 and place them in Flyway's <code>drivers</code> directory</td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>11.2</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>oracle.jdbc.OracleDriver</code></td>
</tr>
</table>

\* `TNS_ADMIN` environment variable must point to the directory of where `tnsnames.ora` resides

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **;**
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

## SQL*Plus commands 
{% include pro.html %}

In addition to the regular Oracle SQL syntax, Flyway Pro and Flyway Enterprise also come with support for Oracle 
SQL*Plus commands.

This support is disabled by default and must be activated using the [`oracle.sqlplus`](/documentation/commandline/migrate#oracle.sqlplus) flag.

### Supported commands

The following commands are fully supported and can be used just like any regular command within your SQL migrations:

- `@` (only files, no URLs)
- `@@` (only files, no URLs)
- `DEFINE`
- `EXECUTE`
- `PROMPT`
- `REMARK`
- `SET DEFINE`
- `SET ESCAPE`
- `SET FEEDBACK`
- `SET FLAGGER`
- `SET HEADING`
- `SET LINESIZE` (DBMS_OUTPUT only)
- `SET NULL`
- `SET SCAN`
- `SET SERVEROUTPUT`
- `SET SUFFIX`
- `SET VERIFY`
- `SHOW CON_ID`
- `SHOW DEFINE`
- `SHOW EDITION`
- `SHOW ERRORS`
- `SHOW ESCAPE`
- `SHOW FEEDBACK`
- `SHOW LINESIZE`
- `SHOW NULL`
- `SHOW RELEASE`
- `SHOW SERVEROUTPUT`
- `SHOW SUFFIX`
- `SHOW USER`
- `SHOW VERIFY`
- `START` (only files, no URLs)
- `UNDEFINE`
- `WHENEVER SQLERROR CONTINUE`
- `WHENEVER SQLERROR EXIT FAILURE`

The short form of these commands is also supported. 

### Output

When `SET SERVEROUTPUT ON` is invoked output produced by `DBMS_OUTPUT.PUT_LINE` will be shown in the console.

### Placeholders

By default SQL\*Plus placeholder support is enabled. `&VAR`-style placeholders will automatically be replaced with the
matching value supplied by either Flyway's regular placeholder configuration or a `DEFINE` command. 
Use of these placeholders can be disabled in the usual way using the `SET DEFINE OFF` command. 

### Unsupported commands

All other SQL*Plus commands are gracefully ignored with a warning message.

## Limitations

- SPATIAL EXTENSIONS: sdo_geom_metadata can only be cleaned for the user currently logged in

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sqlserver">SQL Server <i class="fa fa-arrow-right"></i></a>
</p>