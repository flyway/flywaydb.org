---
layout: gradle
pill: clean
subtitle: 'gradle flywayClean'
---
Gradle Task: flywayClean

Drops all objects (tables, views, procedures, triggers, ...) in the configured schemas.

<a href="/v6/documentation/command/clean"><img src="/assets/balsamiq/command-clean.png" alt="clean"></a>

## Usage

<pre class="console">&gt; gradle flywayClean</pre>

## Configuration

<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th>Parameter</th>
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
    <tr>
        <td>callbacks</td>
        <td>NO</td>
        <td></td>
        <td>Fully qualified class names of
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

```groovy
flyway {
    driver = 'org.hsqldb.jdbcDriver'
    url = 'jdbc:hsqldb:file:/db/flyway_sample;shutdown=true'
    user = 'SA'
    password = 'mySecretPwd'
    connectRetries = 10
    initSql = 'SET ROLE \'myuser\''
    schemas = ['schema1', 'schema2', 'schema3']
    callbacks = ['com.mycompany.proj.CustomCallback', 'com.mycompany.proj.AnotherCallback']
    skipDefaultCallbacks = false
    cleanDisabled = false
    workingDirectory = 'C:/myproject'
}
```

## Sample output

<pre class="console">&gt; gradle flywayClean -i

Cleaned database schema 'PUBLIC' (execution time 00:00.016s)</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/v6/documentation/gradle/info">Gradle: info <i class="fa fa-arrow-right"></i></a>
</p>