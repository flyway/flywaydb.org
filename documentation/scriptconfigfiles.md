---
layout: documentation
menu: scriptconfigfiles
subtitle: Script Config Files
---
# Script Config Files

It's possible to configure SQL migrations on a per-script basis.

This is achieved by creating a script configuration file in the same folder as the migration. The script configuration 
file name must match the migration file name, with the `.conf` suffix added. Script configuration files do **not**
need to be explicitly listed in the main configuration, or the command line.

For example, a migration file `sql/V2__my_script.sql` would have a script configuration file `sql/V2__my_script.sql.conf`.

Script Config Files have a subset of the options from the other ways of configuring Flyway (e.g. `flyway.conf`). See 
the Reference at the bottom of the page for the complete list of options.

## Structure

Script config files have the following structure:

```properties
# Settings are simple key-value pairs
key=value
```

## Reference

```properties
# Encoding of this SQL migration. Caution: changing the encoding after this migration has been run
# will invalidate the calculated checksum and require a `flyway repair`.
encoding=ISO_8859_1

# Manually determine whether or not to execute this migration in a transaction. This is useful for
# databases like PostgreSQL and SQL Server where certain statements can only execute outside a transaction.
executeInTransaction=false
```

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/callbacks">Callbacks <i class="fa fa-arrow-right"></i></a>
</p>
