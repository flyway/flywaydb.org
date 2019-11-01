---
layout: gradle
pill: skip
subtitle: 'gradle flywaySkip'
---
# Gradle Task: flywaySkip

Mark versioned migrations to skip in the schema history table. Skipped migrations will be ignored on next migrate. Migrations to skip configured with the `skipVersions` configuration option.

<a href="/documentation/command/skip"><img src="/assets/balsamiq/command-skip.png" alt="skip"></a>

## Usage

<pre class="console">&gt; gradle flywaySkip</pre>

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
    {% include cfg/skipVersions.html %}
    {% include cfg/connectRetries.html %}
    {% include cfg/initSql.html %}
    {% include cfg/schemas-maven-gradle.html %}
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
    <tr>
        <td>callbacks</td>
        <td>NO</td>
        <td></td>
        <td>Fully qualified class names of
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

```groovy
flyway {
    driver = 'org.hsqldb.jdbcDriver'
    url = 'jdbc:hsqldb:file:/db/flyway_sample;shutdown=true'
    user = 'SA'
    password = 'mySecretPwd'
    connectRetries = 10
    initSql = 'SET ROLE \'myuser\''
    schemas = ['schema1', 'schema2', 'schema3']
    table = 'schema_history'
    tablespace = 'my_tablespace'
    callbacks = ['com.mycompany.proj.CustomCallback', 'com.mycompany.proj.AnotherCallback']
    skipDefaultCallbacks = false
    baselineVersion = 5
    baselineDescription = "Let's go!"
}
```

## Sample output

<pre class="console">&gt; gradle flywayBaseline -i

Creating schema history table: "PUBLIC"."flyway_schema_history"
Schema baselined with version: 1</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/gradle/repair">Gradle: repair <i class="fa fa-arrow-right"></i></a>
</p>