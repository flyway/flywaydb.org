---
layout: documentation
menu: firebird
subtitle: Firebird
---
# Firebird

## Supported Versions

- `4.0`
- `3.0`

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:firebirdsql://<i>host</i>:<i>port</i>/<i>database</i></code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>org.firebirdsql.jdbc:jaybird-jdk18:3.0.5</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>2.2</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>org.firebirdsql.jdbc.FBDriver</code></td>
</tr>
</table>

## SQL Script Syntax

 - [Standard SQL syntax](/documentation/concepts/migrations#syntax)
- Terminator changes supported using `SET TERM <i>&lt;new terminator&gt;</i><i>&lt;old terminator&gt;</i>
- Firebird dialect 3 only

### Compatibility
    
- DDL exported by Firebird isql needs to be split into separate files on each `COMMIT WORK`, removing the `COMMIT WORK` statement from the script.
- Any Firebird SQL script executed by Flyway, can be executed by the Firebird tools (after the placeholders have been replaced).

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
 -- Sql-style comment
 -- Placeholder
ALTER TABLE ${tableName} ADD id INT NOT NULL;
 -- Terminator changes
SET TERM #;
CREATE OR ALTER PROCEDURE SHIP_ORDER (
    PO_NUM CHAR(8))
AS
BEGIN
  /* Stored procedure body */
END#
SET TERM ;#
```

## Limitations

- Mixing DDL and DML involving the same tables in a single migration is not supported. Firebird disallows DDL changes to 
be used by DML in the same transaction, so one of the following is necessary:
  - separate migrations for DML / DDL, or
  - a [per-script override](https://flywaydb.org/documentation/configuration/scriptconfigfiles) of <code>executeInTransaction</code>

- `SET TRANSACTION` and `COMMIT [WORK]` are not supported in migrations. `COMMIT RETAIN` can be used, but this will only 
allow partial rollback of a migration; only statements after the last `COMMIT RETAIN` can be rolled back.
- Migrations modifying or dropping objects while the database is in use can result in long delays or "object X is in use" 
errors as Firebird uses existence locks on metadata objects when they are in use. It may be necessary to shut down the 
database and run the migration with exclusive access.

 <p class="next-steps">
    <a class="btn btn-primary" href="/documentation/existing">Existing database setup <i class="fa fa-arrow-right"></i></a>
</p>