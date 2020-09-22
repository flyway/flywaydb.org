---
layout: documentationv6
menu: callbacks
subtitle: Callbacks
---
# Callbacks

While migrations are sufficient for most needs, there are certain situations that require you to <strong>execute the same action
over and over again</strong>. This could be recompiling procedures, updating materialized views and many other types of housekeeping.

For this reason, Flyway offers you the possibility to **hook into its lifecycle** by using Callbacks.

These are the events Flyway supports:
<table class="table table-hover">
    <thead>
    <tr>
        <th><strong>Name</strong></th>
        <th><strong>Execution</strong></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>beforeMigrate</td>
        <td>Before Migrate runs</td>
    </tr>
    <tr>
        <td>beforeEachMigrate</td>
        <td>Before every single migration during Migrate</td>
    </tr>
    <tr>
        <td>beforeEachMigrateStatement {% include pro.html %}</td>
        <td>Before every single statement of a migration during Migrate</td>
    </tr>
    <tr>
        <td>afterEachMigrateStatement {% include pro.html %}</td>
        <td>After every single successful statement of a migration during Migrate</td>
    </tr>
    <tr>
        <td>afterEachMigrateStatementError {% include pro.html %}</td>
        <td>After every single failed statement of a migration during Migrate</td>
    </tr>
    <tr>
        <td>afterEachMigrate</td>
        <td>After every single successful migration during Migrate</td>
    </tr>
    <tr>
        <td>afterEachMigrateError</td>
        <td>After every single failed migration during Migrate</td>
    </tr>
    <tr>
        <td>afterMigrate</td>
        <td>After successful Migrate runs</td>
    </tr>
    <tr>
        <td>afterMigrateError</td>
        <td>After failed Migrate runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeUndo {% include pro.html %}</td>
        <td>Before Undo runs</td>
    </tr>
    <tr>
        <td>beforeEachUndo {% include pro.html %}</td>
        <td>Before every single migration during Undo</td>
    </tr>
    <tr>
        <td>beforeEachUndoStatement {% include pro.html %}</td>
        <td>Before every single statement of a migration during Undo</td>
    </tr>
    <tr>
        <td>afterEachUndoStatement {% include pro.html %}</td>
        <td>After every single successful statement of a migration during Undo</td>
    </tr>
    <tr>
        <td>afterEachUndoStatementError {% include pro.html %}</td>
        <td>After every single failed statement of a migration during Undo</td>
    </tr>
    <tr>
        <td>afterEachUndo {% include pro.html %}</td>
        <td>After every single successful migration during Undo</td>
    </tr>
    <tr>
        <td>afterEachUndoError {% include pro.html %}</td>
        <td>After every single failed migration during Undo</td>
    </tr>
    <tr>
        <td>afterUndo {% include pro.html %}</td>
        <td>After successful Undo runs</td>
    </tr>
    <tr>
        <td>afterUndoError {% include pro.html %}</td>
        <td>After failed Undo runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeClean</td>
        <td>Before Clean runs</td>
    </tr>
    <tr>
        <td>afterClean</td>
        <td>After successful Clean runs</td>
    </tr>
    <tr>
        <td>afterCleanError</td>
        <td>After failed Clean runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeInfo</td>
        <td>Before Info runs</td>
    </tr>
    <tr>
        <td>afterInfo</td>
        <td>After successful Info runs</td>
    </tr>
    <tr>
        <td>afterInfoError</td>
        <td>After failed Info runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeValidate</td>
        <td>Before Validate runs</td>
    </tr>
    <tr>
        <td>afterValidate</td>
        <td>After successful Validate runs</td>
    </tr>
    <tr>
        <td>afterValidateError</td>
        <td>After failed Validate runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeBaseline</td>
        <td>Before Baseline runs</td>
    </tr>
    <tr>
        <td>afterBaseline</td>
        <td>After successful Baseline runs</td>
    </tr>
    <tr>
        <td>afterBaselineError</td>
        <td>After failed Baseline runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr>
        <td>beforeRepair</td>
        <td>Before Repair runs</td>
    </tr>
    <tr>
        <td>afterRepair</td>
        <td>After successful Repair runs</td>
    </tr>
    <tr>
        <td>afterRepairError</td>
        <td>After failed Repair runs</td>
    </tr>
    </tbody>
</table>

Callbacks can be implemented either in SQL or in Java.

## SQL Callbacks

The most convenient way to hook into Flyway's lifecycle is through SQL callbacks. These are simply sql files
in the configured locations following a certain naming convention: the event name followed by the SQL migration suffix.

Using the default settings, Flyway looks in its default locations (&lt;install_dir&gt;/sql) for the Command-line tool)
for SQL files like `beforeMigrate.sql`, `beforeEachMigrate.sql`, `afterEachMigrate.sql`, ...

Placeholder replacement works just like it does for <a href="v6/documentation/migrations#sql-based-migrations">SQL migrations</a>.

Optionally the callback may also include a description. In that case the callback name is composed of the event name,
the separator, the description and the suffix. Example: `beforeRepair__vacuum.sql`.

**Note:** Flyway will also honor any `sqlMigrationSuffixes` you have configured, when scanning for SQL callbacks.

## Java Callbacks

If SQL Callbacks aren't flexible enough for you, you have the option to implement the
[**Callback**](v6/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback)
interface yourself. You can even hook multiple Callback implementations in the lifecycle. Java callbacks have the
additional flexibility that a single Callback implementation can handle multiple lifecycle events, and are
therefore not bound by the SQL callback naming convention.

**More info:** [Java-based Callbacks](v6/documentation/api/hooks#callsbacks)

## Callback ordering

When multiple callbacks for the same event are found, they are executed in the following order:

- Java callbacks, in the order in which they are specified in the `callbacks` configuration property
- SQL callbacks, in alphabetic order of their description.

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/erroroverrides">Error Overrides <i class="fa fa-arrow-right"></i></a>
</p>