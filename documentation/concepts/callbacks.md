---
layout: documentation
menu: callbacks
subtitle: Callbacks
redirect_from: /documentation/callbacks/
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
    <tr id="beforeMigrate">
        <td>beforeMigrate</td>
        <td>Before Migrate runs</td>
    </tr>
    <tr id="beforeRepeatables">
        <td>beforeRepeatables</td>
        <td>Before all repeatable migrations during Migrate</td>
    </tr>
    <tr id="beforeEachMigrate">
        <td>beforeEachMigrate</td>
        <td>Before every single migration during Migrate</td>
    </tr>
    <tr id="beforeEachMigrateStatement">
        <td>beforeEachMigrateStatement {% include teams.html %}</td>
        <td>Before every single statement of a migration during Migrate</td>
    </tr>
    <tr id="afterEachMigrateStatement">
        <td>afterEachMigrateStatement {% include teams.html %}</td>
        <td>After every single successful statement of a migration during Migrate</td>
    </tr>
    <tr id="afterEachMigrateStatementError">
        <td>afterEachMigrateStatementError {% include teams.html %}</td>
        <td>After every single failed statement of a migration during Migrate</td>
    </tr>
    <tr id="afterEachMigrate">
        <td>afterEachMigrate</td>
        <td>After every single successful migration during Migrate</td>
    </tr>
    <tr id="afterEachMigrateError">
        <td>afterEachMigrateError</td>
        <td>After every single failed migration during Migrate</td>
    </tr>
    <tr id="afterMigrate">
        <td>afterMigrate</td>
        <td>After successful Migrate runs</td>
    </tr>
    <tr id="afterVersioned">
        <td>afterVersioned</td>
        <td>After all versioned migrations during Migrate</td>
    </tr>
    <tr id="afterMigrateError">
        <td>afterMigrateError</td>
        <td>After failed Migrate runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeUndo">
        <td>beforeUndo {% include teams.html %}</td>
        <td>Before Undo runs</td>
    </tr>
    <tr id="beforeEachUndo">
        <td>beforeEachUndo {% include teams.html %}</td>
        <td>Before every single migration during Undo</td>
    </tr>
    <tr id="beforeEachUndoStatement">
        <td>beforeEachUndoStatement {% include teams.html %}</td>
        <td>Before every single statement of a migration during Undo</td>
    </tr>
    <tr id="afterEachUndoStatement">
        <td>afterEachUndoStatement {% include teams.html %}</td>
        <td>After every single successful statement of a migration during Undo</td>
    </tr>
    <tr id="afterEachUndoStatementError">
        <td>afterEachUndoStatementError {% include teams.html %}</td>
        <td>After every single failed statement of a migration during Undo</td>
    </tr>
    <tr id="afterEachUndo">
        <td>afterEachUndo {% include teams.html %}</td>
        <td>After every single successful migration during Undo</td>
    </tr>
    <tr id="afterEachUndoError">
        <td>afterEachUndoError {% include teams.html %}</td>
        <td>After every single failed migration during Undo</td>
    </tr>
    <tr id="afterUndo">
        <td>afterUndo {% include teams.html %}</td>
        <td>After successful Undo runs</td>
    </tr>
    <tr id="afterUndoError">
        <td>afterUndoError {% include teams.html %}</td>
        <td>After failed Undo runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeClean">
        <td>beforeClean</td>
        <td>Before Clean runs</td>
    </tr>
    <tr id="afterClean">
        <td>afterClean</td>
        <td>After successful Clean runs</td>
    </tr>
    <tr id="afterCleanError">
        <td>afterCleanError</td>
        <td>After failed Clean runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeInfo">
        <td>beforeInfo</td>
        <td>Before Info runs</td>
    </tr>
    <tr id="afterInfo">
        <td>afterInfo</td>
        <td>After successful Info runs</td>
    </tr>
    <tr id="afterInfoError">
        <td>afterInfoError</td>
        <td>After failed Info runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeValidate">
        <td>beforeValidate</td>
        <td>Before Validate runs</td>
    </tr>
    <tr id="afterValidate">
        <td>afterValidate</td>
        <td>After successful Validate runs</td>
    </tr>
    <tr id="afterValidateError">
        <td>afterValidateError</td>
        <td>After failed Validate runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeBaseline">
        <td>beforeBaseline</td>
        <td>Before Baseline runs</td>
    </tr>
    <tr id="afterBaseline">
        <td>afterBaseline</td>
        <td>After successful Baseline runs</td>
    </tr>
    <tr id="afterBaselineError">
        <td>afterBaselineError</td>
        <td>After failed Baseline runs</td>
    </tr>
    <tr><td></td><td></td></tr>
    <tr id="beforeRepair">
        <td>beforeRepair</td>
        <td>Before Repair runs</td>
    </tr>
    <tr id="afterRepair">
        <td>afterRepair</td>
        <td>After successful Repair runs</td>
    </tr>
    <tr id="afterRepairError">
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

Placeholder replacement works just like it does for <a href="/documentation/concepts/migrations#sql-based-migrations">SQL migrations</a>.

Optionally the callback may also include a description. In that case the callback name is composed of the event name,
the separator, the description and the suffix. Example: `beforeRepair__vacuum.sql`.

**Note:** Flyway will also honor any `sqlMigrationSuffixes` you have configured, when scanning for SQL callbacks.

## Java Callbacks

If SQL Callbacks aren't flexible enough for you, you have the option to implement the
[**Callback**](/documentation/usage/api/javadoc/org/flywaydb/core/api/callback/Callback)
interface yourself. You can even hook multiple Callback implementations in the lifecycle. Java callbacks have the
additional flexibility that a single Callback implementation can handle multiple lifecycle events, and are
therefore not bound by the SQL callback naming convention.

**More info:** [Java-based Callbacks](/documentation/usage/api/hooks#callsbacks)

## Callback ordering

When multiple callbacks for the same event are found, they are executed in the alphabetical order.

## Tutorial

Click [here](/documentation/getstarted/advanced/callbacks) to see a tutorial on using callbacks.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/concepts/erroroverrides">Error Overrides <i class="fa fa-arrow-right"></i></a>
</p>