---
layout: commandLine
pill: skip
subtitle: 'Command-line: skip'
---
# Command-line: skip

Mark all pending versioned migrations to skip in the schema history table. Skipped migrations will be ignored on next `migrate`.

Note that the pending migrations are determined by the `target` configuration option.

<a href="/documentation/command/skip"><img src="/assets/balsamiq/command-skip.png" alt="skip"></a>

Skip is useful in situations where you have applied ad-hoc changes to a production database. You may then write a migration 
that reproduces these changes and apply them with Flyway in your development and test environments; marking them as
skipped on the production database prevents them being re-applied.

## Usage

<pre class="console"><span>&gt;</span> flyway [options] skip</pre>

## Options

<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th>Option</th>
        <th>Required</th>
        <th>Default</th>
        <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>url</td>
        <td>YES</td>
        <td></td>
        <td>The jdbc url to use to connect to the database</td>
    </tr>
    <tr>
        <td>driver</td>
        <td>NO</td>
        <td><i>Auto-detected based on url</i></td>
        <td>The fully qualified classname of the jdbc driver to use
            to connect to the database
        </td>
    </tr>
    <tr>
        <td>user</td>
        <td>NO</td>
        <td></td>
        <td>The user to use to connect to the database</td>
    </tr>
    <tr>
        <td>password</td>
        <td>NO</td>
        <td></td>
        <td>The password to use to connect to the database</td>
    </tr>
    {% include cfg/connectRetries.html %}
    {% include cfg/initSql.html %}
    {% include cfg/schemas-commandline.html %}
    <tr>
        <td>table</td>
        <td>NO</td>
        <td>flyway_schema_history</td>
        <td>The name of Flyway's schema history table.<br/>By
            default (single-schema mode) the schema history table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the schema history table is placed in the first schema of the list.
        </td>
    </tr>
    {% include cfg/tablespace.html %}
    <tr id="jarDirs">
        <td>jarDirs</td>
        <td>NO</td>
        <td><nobr><i>&lt;install-dir&gt;</i>/jars</nobr></td>
        <td>Comma-separated list of directories containing JDBC drivers and Java-based migrations</td>
    </tr>
    <tr>
        <td>callbacks</td>
        <td>NO</td>
        <td></td>
        <td>Comma-separated list of fully qualified class names of
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr>
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    {% include cfg/licenseKey.html %}
    </tbody>
</table>

## Sample configuration

```properties
flyway.driver=org.hsqldb.jdbcDriver
flyway.url=jdbc:hsqldb:file:/db/flyway_sample
flyway.user=SA
flyway.password=mySecretPwd
flyway.connectRetries=10
flyway.initSql=SET ROLE 'myuser'
flyway.schemas=schema1,schema2,schema3
flyway.table=schema_history
flyway.tablespace=my_tablespace
flyway.callbacks=com.mycomp.project.CustomCallback,com.mycomp.project.AnotherCallback
flyway.skipDefaultCallbacks=false
flyway.baselineVersion=1.0
flyway.baselineDescription=Base Migration
```

## Sample output
<pre class="console">&gt; flyway skip

Flyway {{ site.flywayVersion }} by Boxfuse

Skipping version 1.0.1 - View
Skipping version 1.0.2 - Another View
Successfully skipped 2 migrations on schema "PUBLIC" (execution time 00:00.030s). </pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/repair">Command-line: repair <i class="fa fa-arrow-right"></i></a>
</p>