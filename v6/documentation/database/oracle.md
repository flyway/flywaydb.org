---
layout: documentationv6
menu: oracle
subtitle: Oracle
---
# Oracle

## Supported Versions

- `19.3`
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
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.oracle.database.jdbc:ojdbc8:19.6.0.0</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>18.3.0.0</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>oracle.jdbc.OracleDriver</code></td>
</tr>
</table>

\* `TNS_ADMIN` environment variable must point to the directory of where `tnsnames.ora` resides

## SQL Script Syntax

- [Standard SQL syntax](v6/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **;**
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
   UPDATE test_user SET name = CONCAT(name, ' triggered');
END;
/

-- Placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');</pre>

## SQL*Plus commands 
{% include pro.html %}

In addition to the regular Oracle SQL syntax, Flyway Pro and Flyway Enterprise also come with support for Oracle 
SQL*Plus commands.

This support is disabled by default and must be activated using the [`oracle.sqlplus`](v6/documentation/commandline/migrate#oracle.sqlplus) flag.

### Supported commands

The following commands are fully supported and can be used just like any regular command within your SQL migrations:

- `@` (only files, no URLs)
- `@@` (only files, no URLs)
- `DEFINE`
- `EXECUTE`
- `PROMPT`
- `REMARK`
- `SET DEFINE`
- `SET ECHO`
- `SET ESCAPE`
- `SET FEEDBACK`
- `SET FLAGGER`
- `SET HEADING`
- `SET LINESIZE` (DBMS_OUTPUT only)
- `SET NULL`
- `SET SCAN`
- `SET SERVEROUTPUT`
- `SET SUFFIX`
- `SET TERMOUT`
- `SET TIME`
- `SET TIMING`
- `SET VERIFY`
- `SHOW CON_ID`
- `SHOW DEFINE`
- `SHOW ECHO`
- `SHOW EDITION`
- `SHOW ERRORS`
- `SHOW ESCAPE`
- `SHOW FEEDBACK`
- `SHOW HEADING`
- `SHOW LINESIZE`
- `SHOW NULL`
- `SHOW RELEASE`
- `SHOW SCAN`
- `SHOW SERVEROUTPUT`
- `SHOW SUFFIX`
- `SHOW TERMOUT`
- `SHOW TIME`
- `SHOW TIMING`
- `SHOW USER`
- `SHOW VERIFY`
- `SPOOL`
- `START` (only files, no URLs)
- `UNDEFINE`
- `WHENEVER SQLERROR CONTINUE`
- `WHENEVER SQLERROR EXIT FAILURE`
- `WHENEVER SQLERROR EXIT SQL.SQLCODE`

The short form of these commands is also supported. 

### Output

When `SET SERVEROUTPUT ON` is invoked output produced by `DBMS_OUTPUT.PUT_LINE` will be shown in the console.

### Variable substitution

By default SQL\*Plus variable substitution support is enabled. `&VAR`-style variables will automatically be replaced 
with the matching value supplied by either Flyway's regular placeholder configuration or a `DEFINE` command. 
Use of these variables can be disabled in the usual way using the `SET DEFINE OFF` command. 

While SQL\*Plus is interactive and will prompt for missing variable values, Flyway does not; it is an error not
to provide a value for all variables that need to be substituted. 

Statements which contain a `&VAR`-style expression which is not intended to be substituted, such as in a
literal string, will either require `SET DEFINE OFF` beforehand, or some alternative construct to avoid use of
the ampersand.

For more information, see the 
[SQL\*Plus documentation](https://blogs.oracle.com/opal/sqlplus-101-substitution-variables#2)

### Unsupported commands

All other SQL*Plus commands are gracefully ignored with a warning message.

## Authentication

### JDBC

Oracle supports user and password being provided in the JDBC URL, in the form

`jdbc:oracle:thin:<user>/<password>@//<host>:<port>/<database>`

In this case, they do not need to be passed separately in configuration and the Flyway commandline will not prompt for them.

### Oracle Wallet

You can supply credentials using Oracle Wallet by specfiying properties on the JDBC url. For example:

`jdbc:oracle:thin:@dbname_high?TNS_ADMIN=/Users/test/wallet_dbname`

[See the Oracle documentation for more details](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/connect-jdbc-thin-wallet.html#GUID-20656D84-4D79-4EE9-B55F-333053948966).

## Limitations

- SPATIAL EXTENSIONS: sdo_geom_metadata can only be cleaned for the user currently logged in

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/database/sqlserver">SQL Server <i class="fa fa-arrow-right"></i></a>
</p>