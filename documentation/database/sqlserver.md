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
- `2014` {% include teams.html %}
- `2012` {% include teams.html %}
- `2008 R2` {% include teams.html %}
- `2008` {% include teams.html %}

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i></code></td>
</tr>
<tr>
<th>SSL support</th>
<td><a href="https://docs.microsoft.com/en-us/sql/connect/jdbc/connecting-with-ssl-encryption?view=sql-server-ver15">Yes</a> - add <code>;encrypt=true</code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.microsoft.sqlserver:mssql-jdbc:9.2.1.jre8</code></td>
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

- [Standard SQL syntax](/documentation/concepts/migrations#sql-based-migrations#syntax) with statement delimiter **GO**
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

## Authentication

SQL Server supports several methods of authentication. These include:

- SQL Server Authentication
- Windows Authentication
- Azure Active Directory

SQL Server Authentication works 'out-of-the-box' with Flyway, whereas Windows Authentication and Azure Active Directory require extra manual setup.

The instructions provided here are adapted from the [Microsoft JDBC Driver for SQL Server documentation](https://docs.microsoft.com/en-us/sql/connect/jdbc/microsoft-jdbc-driver-for-sql-server?view=sql-server-ver15). Refer to this when troubleshooting authentication problems.

**Note** These instructions may be incomplete. Flyway depends on Microsoft's JDBC drivers, which in turn have many environmental dependencies to enable different authentication types. You may have to perform your own research to get the JDBC driver working for the different authentication types.

### SQL Server Authentication

This uses a straightforward username and password to authenticate. Provide these with the `user` and `password` configuration options.

### Windows Authentication

[Windows Authentication, also known as Integrated Security](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/authentication-in-sql-server), is enabled by amending your JDBC connection string to set `integratedSecurity=true`.

Example: `jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;integratedSecurity=true`.

### Azure Active Directory

#### Installing MSAL4J

To use Flyway with Azure Active Directory connections, you must install [MSAL4J](https://github.com/AzureAD/microsoft-authentication-library-for-java) and it's dependencies.

If you're using Flyway in an environment that is integrated with Maven or Gradle (Like the Maven or Gradle plugin), you only need to add [MSAL4J's Maven package](https://mvnrepository.com/artifact/com.microsoft.azure/msal4j) as a dependency in your `pom.xml`. Maven should then deal with getting MSAL4J's dependencies itself.

For command line users, you'll have to download them all manually. To do this, you can use the JAR Download tool to find MSAL4J and its dependencies:

- Go to the [JAR Download Tool](https://jar-download.com/online-maven-download-tool.php)
- Paste the following into the `Maven XML` box:

```xml
<dependency>
  <groupId>com.microsoft.azure</groupId>
  <artifactId>msal4j</artifactId>
  <version>1.9.1</version>
</dependency>
```

- Click 'Submit'
- Download the archive and add it to the `lib` folder in your command-line installation.

#### Connecting

There are several types of Azure Active Directory authentication:
- Azure Active Directory with MFA
- Azure Active Directory Integrated
- Azure Active Directory MSI
- Azure Active Directory with Password
- Azure Active Directory Service Principal
- Access Tokens

To use the various authentication types, amend your JDBC URL to set the `authentication` parameter:

- For Active Directory Integrated set `authentication=ActiveDirectoryIntegrated`
  - e.g: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryIntegrated</code>
- For Active Directory MSI set `authentication=ActiveDirectoryMSI`
  - e.g: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryMSI</code>
- For Active Directory With Password set `authentication=ActiveDirectoryPassword`
  - e.g: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryPassword</code>
  - You must also supply a username and password with Flyway's `user` and `password` configuration options
- For Active Directory Interactive set `authentication=ActiveDirectoryInteractive`
  - e.g: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryInteractive</code>
  - This will begin an interactive process which expects user input (e.g. a dialogue box), so it's not recommended in automated environments
- For Active Directory Service Principal set `authentication=ActiveDirectoryServicePrincipal `
  - e.g: <code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i>;authentication=ActiveDirectoryServicePrincipal </code>

[The Microsoft documentation has more details about how these work with JDBC URLs](https://docs.microsoft.com/en-us/sql/connect/jdbc/connecting-using-azure-active-directory-authentication?view=sql-server-ver15).

*Flyway doesn't support Azure Active Directory with MFA, as it is [not supported by the Microsoft JDBC drivers](https://github.com/microsoft/mssql-jdbc/issues/1053).

#### Azure access tokens

Another way to authenticate using Azure Active Directory is through access tokens. As of the time of writing, the access token property on Microsoft's JDBC driver cannot be supplied through the URL. Therefore you should use Flyway's `jdbcProperties` configuration property.

E.g, in a `flyway.conf` file:

```
flyway.jdbcProperties.accessToken=my-access-token
```

This is equivalent to the [process of setting `accessToken` as described on this Microsoft documentation page](https://docs.microsoft.com/en-us/sql/connect/jdbc/connecting-using-azure-active-directory-authentication?view=sql-server-ver15#connecting-using-access-token).

## Limitations

- Flyway's automatic detection for whether SQL statements are valid in transactions does not apply to 
<code>CREATE/ALTER/DROP</code> statements acting on memory-optimised tables (that is, those created with 
<code>WITH (MEMORY_OPTIMIZED = ON)</code>). You will need to override the `executeInTransaction` setting to be false,
either on a [per-script basis](https://flywaydb.org/documentation/configuration/scriptconfigfiles) or globally.
- SQL Server is unable to change the default schema for a session. Therefore, setting the `flyway.defaultSchema` property
has no value, unless used for a [Placeholder](https://flywaydb.org/documentation/concepts/migrations#placeholder-replacement) in
your sql scripts. If you decide to use `flyway.defaultSchema`, it also must exist in `flyway.schemas`.
- By default, the flyway schema history table will try to write to the default schema for the database connection. You may
specify which schema to write this table to by setting `flyway.schemas=custom_schema`, as the first entry will become the
default schema if `flyway.defaultSchema` itself is not set.
- With these limitations in mind, please refer to the properties or
[Options](https://flywaydb.org/documentation/configuration/parameters/defaultSchema) mentioned here for descriptions / 
consequences.
- If using the JTDS driver, then setting `ANSI_NULLS` or `QUOTED_IDENTIFIER` in a script will cause an error. This is
a driver limitation, and can be solved by using the Microsoft driver instead.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/azuresynapse">Azure Synapse <i class="fa fa-arrow-right"></i></a>
</p>
