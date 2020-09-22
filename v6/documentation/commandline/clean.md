---
layout: commandLine
pill: clean
subtitle: 'Command-line: clean'
---
# Command-line: clean

Drops all objects (tables, views, procedures, triggers, ...) in the configured schemas.<br/>
The schemas are cleaned in the order specified by the `schemas` property.

<a href="/v6/documentation/command/clean"><img src="/assets/balsamiq/command-clean.png" alt="clean"></a>

## Usage

<pre class="console"><span>&gt;</span> flyway [options] clean</pre>

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
    {% include v6/cfg/connectRetries.html %}
    {% include v6/cfg/initSql.html %}
    {% include v6/cfg/schemas.html %}
    {% include v6/cfg/color.html %}
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
            <a href="/v6/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr>
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    <tr>
        <td>cleanDisabled</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.</td>
    </tr>
    {% include v6/cfg/validateMigrationNaming.html %}
    {% include v6/cfg/workingDirectory.html %}
    {% include v6/cfg/licenseKey.html %}
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
flyway.callbacks=com.mycomp.project.CustomCallback,com.mycomp.project.AnotherCallback
flyway.skipDefaultCallbacks=false
flyway.cleanDisabled=false
flyway.workingDirectory=C:/myProject
```

## Sample output
<pre class="console">&gt; flyway clean

Flyway {{ site.flywayVersion }} by Redgate

Cleaned database schema 'PUBLIC' (execution time 00:00.014s)</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/v6/documentation/commandline/info">Command-line: info <i class="fa fa-arrow-right"></i></a>
</p>