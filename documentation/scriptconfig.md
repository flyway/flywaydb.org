---
layout: configuration
menu: scriptconfig
subtitle: Script Config Files
pill: scriptconfig
---
# Script config

It's possible to configure SQL migrations on a per-script basis.

This is achieved by creating a script configuration file alongside the migration. The script configuration file name must match
the migration file name, with the `.conf` suffix added.

For example, a migration file `V2__my_script.sql` would have a script configuration file `V2__my_script.sql.conf`.

## Structure

Script config files have the following structure:

```properties
# Settings are simple key-value pairs
flyway.key=value
```

## Reference

```properties
# Manually determine whether or not to execute a migration in a transaction. This is useful for
# databases like PostgreSQL and SQL Server where certain statements can only execute outside a transaction.
executeInTransaction=false
```