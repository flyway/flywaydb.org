---
layout: documentation
menu: sqlServer
subtitle: SQL Server
---
# SQL Server

## Supported Versions

- `2017`
- `2016`
- `2014`
- `2012` {% include enterprise.html %}
- `2008 R2` {% include enterprise.html %}
- `2008` {% include enterprise.html %}

## Drivers

<table class="table">
<thead>
<tr>
<th></th>
<th>Microsoft (recommended)</th>
<th>jTDS</th>
</tr>
</thead>
<tr>
<th>Supported versions</th>
<td><code>4.0</code> and later</td>
<td><code>1.3.1</code> and later</td>
</tr>
<tr>
<th>URL format</th>
<td><code>jdbc:sqlserver://<i>host</i>:<i>port</i>;databaseName=<i>database</i></code></td>
<td><code>jdbc:jtds:sqlserver://<i>host</i>:<i>port</i>/<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.microsoft.sqlserver:mssql-jdbc:6.2.2.jre8</code></td>
<td><code>net.sourceforge.jtds:jtds:1.3.1</code></td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.microsoft.sqlserver.jdbc.SQLServerDriver</code></td>
<td><code>net.sourceforge.jtds.jdbc.Driver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](/documentation/migration/sql#syntax) with statement delimiter **GO**
- T-SQL

### Compatibility

- DDL exported by SQL Server can be used unchanged in a Flyway migration.
- Any SQL Server sql script executed by Flyway, can be executed by Sqlcmd, SQL Server Management Studio and
        other SQL Server-compatible tools (after the placeholders have been replaced).

### Example

<pre class="prettyprint">/* Single line comment */
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
INSERT INTO ${tableName} (name) VALUES (&#x27;Mr. T&#x27;);</pre>

## Limitations

- When setting `flyway.schemas`, the first schema is not set as the default due to [SQL Server limitations](http://connect.microsoft.com/SQLServer/feedback/details/390528/t-sql-statement-for-changing-default-schema-context)

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/db2">DB2 <i class="fa fa-arrow-right"></i></a>
</p>