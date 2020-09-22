---
layout: documentation
menu: undo
subtitle: Undo
---
# Undo
{% include pro.html %}

Undoes the most recently applied versioned migration.

![Undo](/assets/balsamiq/command-undo.png)

If `target` is specified, Flyway will attempt to undo versioned migrations in the order they were applied until it hits
one with a version below the target. If `group` is active, Flyway will attempt to undo all these migrations within a
single transaction. 

If there is no versioned migration to undo, calling undo has no effect.

There is no undo functionality for repeatable migrations. In that case the repeatable migration should be modified to
include the older state that one desires and then reapplied using [migrate](/v6/documentation/command/migrate).

## Important notes

While the idea of undo migrations is nice, unfortunately it sometimes breaks down in practice. As soon as
you have destructive changes (drop, delete, truncate, ...), you start getting into trouble. And even if you don't,
you end up creating home-made alternatives for restoring backups, which need to be properly tested as well.

Undo migrations assume the whole migration succeeded and should now be undone. This does not help with failed versioned
migrations on databases without DDL transactions. Why? A migration can fail at any point. If you have 10 statements,
it is possible for the 1st, the 5th, the 7th or the 10th to fail. There is
simply no way to know in advance. In contrast, undo migrations are written to undo an entire versioned migration and will not
help under such conditions.

An alternative approach which we find preferable is to **maintain backwards compatibility
between the DB and all versions of the code currently deployed in production**. This way a
failed migration is not a disaster. The old version of the application is still compatible with the DB, so you
can simply roll back the application code, investigate, and take corrective measures.

This should be complemented with a **proper, well tested, backup and restore strategy**. It is independent
of the database structure, and once it is tested and proven to work, no migration script can break it. For
optimal performance, and if your infrastructure supports this, we recommend using the snapshot
technology of your underlying storage solution. Especially for larger data volumes, this can be
several orders of magnitude faster than traditional backups and restores.

<p class="next-steps">
    <a class="btn btn-primary" href="/v6/documentation/command/baseline">Baseline <i class="fa fa-arrow-right"></i></a>
</p>