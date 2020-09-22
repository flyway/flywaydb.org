---
layout: documentationv6
menu: cockroachdb
subtitle: CockroachDB
---
# CockroachDB

## Supported Versions

- `19.2`
- `19.1`
- `2.1`
- `2.0`
- `1.1`

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:postgresql://<i>host</i>:<i>port</i>/<i>database</i></code></td>
</tr>
<tr>
<th>SSL support</th>
<td><a href="https://forum.cockroachlabs.com/t/connecting-to-an-ssl-secure-server-using-jdbc-java-and-client-certificate-authentication/400">Yes</a></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>org.postgresql:postgresql:42.2.5</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>9.3-1104-jdbc4</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>org.postgresql.Driver</code></td>
</tr>
</table>

## SQL Script Syntax

- [Standard SQL syntax](v6/documentation/migrations#sql-based-migrations#syntax) with statement delimiter **;**

### Compatibility

- DDL exported by pg_dump can be used unchanged in a Flyway migration.
- Any CockroachDB sql script executed by Flyway, can be executed by the CockroachDB command-line tool and other
        PostgreSQL-compatible tools (after the placeholders have been replaced).

### Example

```sql
/* Single line comment */
CREATE TABLE test_data (
 value VARCHAR(25) NOT NULL PRIMARY KEY
);


/*
Multi-line
comment
*/

-- Placeholder
INSERT INTO ${tableName} (name) VALUES ('Mr. T');
```

## Limitations

- No support for psql meta-commands with no JDBC equivalent like `\set`

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/database/saphana">SAP HANA <i class="fa fa-arrow-right"></i></a>
</p>