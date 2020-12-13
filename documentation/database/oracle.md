---
layout: documentation
menu: oracle
subtitle: Oracle
---
# Oracle

## Supported Versions

- `19.3`
- `18.3`
- `12.2`
- `12.1` {% include teams.html %}
- `11.2` {% include teams.html %}
- `11.1` {% include teams.html %}
- `10.2` {% include teams.html %}
- `10.1` {% include teams.html %}

All editions are supported, including XE.

## Driver

<table class="table">
    <tr>
        <th>URL format</th>
        <td>
            <code>jdbc:oracle:thin:@//<i>host</i>:<i>port</i>/<i>service</i></code><br>
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

- [Standard SQL syntax](/documentation/concepts/migrations#sql-based-migrations#syntax) with statement delimiter `;`
- PL/SQL blocks starting with `DECLARE` or `BEGIN` and finishing with `END; /`

### Compatibility

- DDL exported by Oracle can be used unchanged in a Flyway migration
- Any Oracle SQL script executed by Flyway can be executed by SQL*Plus and other Oracle-compatible tools (after the placeholders have been replaced)

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
{% include teams.html %}

In addition to the regular Oracle SQL syntax, Flyway Teams also comes with support for many Oracle SQL*Plus commands.

This support is disabled by default and must be activated using the [`oracle.sqlplus`](/documentation/configuration/parameters/oracleSqlPlus) flag.

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

### Site Profiles (`glogin.sql`) & User Profiles (`login.sql`)

This feature allows you to set up your SQL\*Plus environment to use the same settings with each session. It allows you to execute statements before every script run, and is typically used to configure 
the session in a consistent manner by calling SQL*Plus commands such as `SET FEEDBACK` and `SET DEFINE`.

Flyway will look for `login.sql` in all the valid migration locations, and load it if present. `glogin.sql` will be loaded from `$ORACLE_HOME/sqlplus/admin/glogin.sql` in UNIX, and `ORACLE_HOME\sqlplus\admin\glogin.sql` otherwise.

Profiles are only loaded when [`oracle.sqlplus`](/documentation/configuration/parameters/oracleSqlPlus) is enabled.

### Output

When `SET SERVEROUTPUT ON` is invoked, output produced by `DBMS_OUTPUT.PUT_LINE` will be shown in the console.

### Variable substitution

By default SQL\*Plus variable substitution support is enabled. `&VAR`-style variables will automatically be replaced 
with the matching value supplied by either Flyway's regular placeholder configuration or a `DEFINE` command. 
Use of these variables can be disabled in the usual way using the `SET DEFINE OFF` command. 

While SQL\*Plus is interactive and will prompt for missing variable values, Flyway does not; it is an error not
to provide a value for all variables that need to be substituted. 

Statements which contain a `&VAR`-style expression which is not intended to be substituted, such as in a
literal string, will either require `SET DEFINE OFF` beforehand, or some alternative construct to avoid use of
the ampersand.


### Limitations

#### Unsupported commands

Not all SQL*Plus commands are supported by Flyway. Unsupported commands are gracefully ignored with a warning message.

#### Behavior parity

As much as possible, Flyway aims to emulate the behavior of the SQL*Plus client in Oracle SQL Developer. However, there are some edge cases where Flyway isn't able to emulate the behavior exactly. Known cases are detailed below:

- SQL*Plus is known to replace CRLF pairs in string literals with single LFs. Flyway will not do this - instead it preserves scripts as they are written.

If you encounter a discrepancy between the Oracle SQL*Plus client and Flyway, let us know via the official support email.
For more information, see the [SQL\*Plus documentation](https://blogs.oracle.com/opal/sqlplus-101-substitution-variables#2).

## Authentication

### JDBC

Oracle supports user and password being provided in the JDBC URL, in the form

`jdbc:oracle:thin:<user>/<password>@//<host>:<port>/<database>`

In this case, they do not need to be passed separately in configuration and the Flyway commandline will not prompt for them.

### Oracle Wallet

You can supply credentials using Oracle Wallet by specifying properties on the JDBC url. For example:

`jdbc:oracle:thin:@dbname_high?TNS_ADMIN=/Users/test/wallet_dbname`

[See the Oracle documentation for more details](https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/user/connect-jdbc-thin-wallet.html#GUID-20656D84-4D79-4EE9-B55F-333053948966).

### Kerberos 
{% include teams.html %}

You can authenticate using Kerberos by specifying the location of the local Kerberos configuration file (which contains
details such as the locations of Kerberos Key Distribution Centers), and optionally the local credential cache, to 
Flyway. For example, in `flyway.conf`:

```properties
flyway.oracle.kerberosConfigFile=/etc/krb5.conf
flyway.oracle.kerberosCacheFile=/tmp/krb5cc_123
```

## Limitations

- SPATIAL EXTENSIONS: `sdo_geom_metadata` can only be cleaned for the user currently logged in

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sqlserver">SQL Server <i class="fa fa-arrow-right"></i></a>
</p>
