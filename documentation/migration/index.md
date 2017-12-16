---
layout: migration
pill: overview
subtitle: Migrations
---
# Migrations

With Flyway all changes to the database are called **migrations**. Migrations can be either *versioned* or
*repeatable*. Versioned migrations come in 2 forms: regular and *undo*.

**Versioned migrations** have a *version*, a *description* and a *checksum*. The version must be unique. The description is purely
informative for you to be able to remember what each migration does. The checksum is there to detect accidental changes.
Versioned migrations are the most common type of migration. They are applied in order exactly once.

Optionally their effect can be undone by supplying an **undo migration** with the same version.
 
**Repeatable migrations** have a description and a checksum, but no version. Instead of being run just once, they are
(re-)applied every time their checksum changes.

Within a single migration run, repeatable migrations are always applied last, after all pending versioned migrations 
have been executed. Repeatable migrations are applied in the order of their description.

By default both versioned and repeatable migrations can be written either in **[SQL](/documentation/migration/sql)**
or in **[Java](/documentation/migration/java)** and can consist of multiple statements.

Flyway automatically discovers migrations on the *filesystem* and on the Java *classpath*.

To keep track of which migrations have already been applied when and by whom, Flyway adds a *schema history table*
to your schema.

## Versioned Migrations

The most common type of migration is a **versioned migration**. Each versioned migration has a *version*, a *description*
and a *checksum*. The version must be unique. The description is purely
informative for you to be able to remember what each migration does. The checksum is there to detect accidental changes.
Versioned migrations are the most common type of migration. They are applied in order exactly once.

Versioned migrations are typically used for:
- Creating/altering/dropping tables/indexes/foreign keys/enums/UDTs/...
- Reference data updates
- User data corrections

Here is a small example:

```sql
CREATE TABLE car (
    id INT NOT NULL PRIMARY KEY,
    license_plate VARCHAR NOT NULL,
    color VARCHAR NOT NULL
);

ALTER TABLE owner ADD driver_license_id VARCHAR;

INSERT INTO brand (name) VALUES ('DeLorean');
```

Each versioned migration must be assigned a **unique version**. Any version is valid as long as it conforms to the usual
dotted notation. For most cases a simple increasing integer should be all you need. However Flyway is quite flexible and
all these versions are valid versioned migration versions:
- 1
- 001
- 5.2
- 1.2.3.4.5.6.7.8.9
- 205.68
- 20130115113556
- 2013.1.15.11.35.56
- 2013.01.15.11.35.56

## Undo Migrations
{% include pro.html %}

**Undo migrations** are the opposite of regular versioned migrations. An undo migration is responsible for undoing the effects
of the versioned migration with the same version. Undo migrations are optional and not required to run regular versioned migrations.

For the example above, this is how the undo migration would look like:
```sql
DELETE FROM brand WHERE name='DeLorean';

ALTER TABLE owner DROP driver_license_id;

DROP TABLE car;
```

### Important Notes

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

## Repeatable Migrations

**Repeatable migrations** have a description and a checksum, but no version. Instead of being run just once, they are
(re-)applied every time their checksum changes. 

This is very useful for managing database objects whose definition can then simply be maintained in a single file in
version control. They are typically used for
- (Re-)creating views/procedures/functions/packages/...
- Bulk reference data reinserts

Within a single migration run, repeatable migrations are always applied last, after all pending versioned migrations have been executed. Repeatable migrations are applied in the order of their description.

It is your responsibility to ensure the same repeatable migration can be applied multiple times. This usually
involves making use of `CREATE OR REPLACE` clauses in your DDL statements.

Here is an example of what a repeatable migration looks like:

```sql
CREATE OR REPLACE VIEW blue_cars AS 
    SELECT id, license_plate FROM cars WHERE color='blue';
```

## Transactions

Within a single migration, all statements are run within a single transaction.

## Schema History Table

To keep track of which migrations have already been applied when and by whom, Flyway adds a special bookkeeping
table to your schema. This <strong>schema history table</strong> also tracks migration checksums and whether or not
the migrations were successful.

<p>Read more about this in our getting started guide on <a href="/getstarted/how">how Flyway works</a>.</p>

## Migration States

<p>
    Migrations are either <em>resolved</em> or <em>applied</em>. Resolved migrations have been detected by Flyway's
    filesystem
    and classpath scanner. Initially they are <strong>pending</strong>. Once they are executed against the database,
    they become applied.
</p>

<p>All statements of a migration are run within a single transaction.</p>
<ul>
    <li>When the migration <em>succeeds</em> it is marked as <strong>success</strong> in Flyway's <em>metadata
        table</em>.
    </li>
    <li>When the migration <em>fails</em> and the database supports <em>DDL transactions</em>, the migration is <em>rolled
        back</em> and nothing is recorded in the schema history table.
    </li>
    <li>When the migration <em>fails</em> and the database doesn't supports <em>DDL transactions</em>, the migration
        is marked as <strong>failed</strong> in the schema history table, indicating manual database cleanup may be
        required.
    </li>
</ul>

<p>Repeatable migrations whose checksum has changed since they are last applied are <strong>outdated</strong> until
    they are executed again.</p>

<p>When Flyway discovers an applied versioned migration with a version that is higher than the highest known version
    (this happens typically when a newer version of the software has migrated that schema), that migration is marked as <strong>future</strong>.</p>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/migration/sql">SQL-based migrations <i
            class="fa fa-arrow-right"></i></a>
</p>
