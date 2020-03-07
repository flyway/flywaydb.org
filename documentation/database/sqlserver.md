---
layout: documentation
menu: sqlServer
subtitle: SQL Server
---
# SQL Server

## Supported Versions

- `2019`
- `2017`
- `2016`
- `2014` {% include enterprise.html %}
- `2012` {% include enterprise.html %}
- `2008 R2` {% include enterprise.html %}
- `2008` {% include enterprise.html %}

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.microsoft.sqlserver:mssql-jdbc:7.2.0.jre8</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>4.0</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.microsoft.sqlserver.jdbc.SQLServerDriver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **GO**
- T-SQL

### Compatibility

- DDL exported by SQL Server can be used unchanged in a Flyway migration.
- Any SQL Server sql script executed by Flyway, can be executed by Sqlcmd, SQL Server Management Studio and
        other SQL Server-compatible tools (after the placeholders have been replaced).

### Example

```sql
/* Single line comment */
CREATE TABLE Customers (
CustomerId smallint identity(1,1),
Name nvarchar(255),
Priority tinyint
)
CREATE TABLE Sales (
TransactionId smallint identity(1,1),
CustomerId smallint,
[Net Amount] int,
Completed bit
)
GO

/*
Multi-line
comment
*/
-- TSQL
CREATE TRIGGER dbo.Update_Customer_Priority
 ON dbo.Sales
AFTER INSERT, UPDATE, DELETE
AS
WITH CTE AS (
 select CustomerId from inserted
 union
 select CustomerId from deleted
)
UPDATE Customers
SET
 Priority =
   case
     when t.Total &lt; 10000 then 3
     when t.Total between 10000 and 50000 then 2
     when t.Total &gt; 50000 then 1
     when t.Total IS NULL then NULL
   end
FROM Customers c
INNER JOIN CTE ON CTE.CustomerId = c.CustomerId
LEFT JOIN (
 select
   Sales.CustomerId,
   SUM([Net Amount]) Total
 from Sales
 inner join CTE on CTE.CustomerId = Sales.CustomerId
 where
   Completed = 1
 group by Sales.CustomerId
) t ON t.CustomerId = c.CustomerId
GO

-- Placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');
```

# Authentication types

SQL Server supports several methods of authentication. These include:

- SQL Server Authentication
- Windows Authentication
- Azure Active Directory

SQL Server Authentication works 'out-of-the-box' with Flyway, whereas Windows Authentication and Azure Active Directory require extra manual setup.

The instructions provided here are adapted from the [Microsoft JDBC Driver for SQL Server documentation](https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server?view=sql-server-ver15). Refer to this when troubleshooting authentication problems.

## SQL Server Authentication

This uses a straightforward username and password to authenticate. Provide these with the `user` and `password` configuration options.

## Windows Authentication & Azure Active Directory

Windows Authentication and Azure Active Directory require an extra driver to be installed:

- Go to the <a href="https://docs.microsoft.com/en-us/sql/connect/jdbc/download-microsoft-jdbc-driver-for-sql-server?view=sql-server-ver15">'Download Microsoft JDBC Driver for SQL Server' page</a>
- Download the <code>.tar.gz</code> file for the JDBC version used by Flyway
  - The version can be seen in the 'Maven Central coordinates' url under the <a href="https://flywaydb.org/documentation/database/sqlserver#driver">Driver section</a> at the top of this page
- Extract the contents of the file
- Look for <code>sqljdbc_auth.dll</code>, under <code>sqljdbc_{version}\enu\auth\x64</code>
- Copy <code>sqljdbc_auth.dll</code> to an accessible location in your environment (e.g. <code>C:\jdbc-drivers\</code>)
- Add the location of <code>sqljdbc_auth.dll</code> to your <code>PATH</code> environment variable

### Windows Authentication

[Windows Authentication, also known as Integrated Security](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/authentication-in-sql-server), is enabled by amending your JDBC connection string to set <code>integratedSecurity=true</code>.

Example: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;integratedSecurity=true</code>.

### Azure Active Directory

There are several types of Azure Active Directory authentication:
- Azure Active Directory with MFA (not supported)*
- Azure Active Directory Integrated
- Azure Active Directory MSI
- Azure Active Directory with Password

To enable these authentication types, amend your JDBC URL to set an `authentication` parameter.

For instance, to enable `ActiveDirectoryIntegrated` in your JDBC connection string to set <code>authentication=ActiveDirectoryIntegrated</code>.

Example: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryIntegrated</code>.

[The Microsoft documentation has complete details about how these work with JDBC URLs](https://docs.microsoft.com/en-us/sql/connect/jdbc/connecting-using-azure-active-directory-authentication?view=sql-server-ver15).

*Flyway doesn't support Azure Active Directory with MFA, as it is [not supported by the Microsoft JDBC drivers](https://github.com/microsoft/mssql-jdbc/issues/1053).

## Limitations

- SQL Server is unable to change the default schema for a session. Therefore, setting the `flyway.defaultSchema` property
has no value, unless used for a [Placeholder](https://flywaydb.org/documentation/migrations#placeholder-replacement) in
your sql scripts. If you decide to use `flyway.defaultSchema`, it also must exist in `flyway.schemas`.
- By default, the flyway schema history table will try to write to the default schema for the database connection. You may
specify which schema to write this table to by setting `flyway.schemas=custom_schema`, as the first entry will become the
default schema if `flyway.defaultSchema` itself is not set.
- With these limitations in mind, please refer to the properties or
[Options](https://flywaydb.org/documentation/commandline/migrate#defaultSchema) mentioned here for descriptions / 
consequences.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/db2">DB2 <i class="fa fa-arrow-right"></i></a>
</p>
