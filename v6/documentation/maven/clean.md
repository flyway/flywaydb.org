---
layout: maven
pill: clean
subtitle: 'mvn flyway:clean'
---
# Maven Goal: Clean

Drops all objects (tables, views, procedures, triggers, ...) in the configured schemas.<br/>
The schemas are cleaned in the order specified by the <code>schemas</code> property.

<a href="/documentation/command/clean"><img src="/assets/balsamiq/command-clean.png" alt="clean"></a>

## Default Phase

- pre-integration-test

## Usage

<pre class="console"><span>&gt;</span> mvn flyway:clean</pre>

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
        <td>serverId</td>
        <td>NO</td>
        <td>flyway-db</td>
        <td>The id of the server in the Maven settings.xml file to
            load the credentials from.<br/><br/>This is an alternative to passing the credentials in
            directly through properties.
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
    {% include cfg/schemas.html %}
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
    <tr>
        <td>cleanDisabled</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.</td>
    </tr>
    <tr>
        <td>skip</td>
        <td>NO</td>
        <td>false</td>
        <td>Skips the execution of the plugin for this module</td>
    </tr>
    <tr>
        <td>configFiles</td>
        <td>NO</td>
        <td></td>
        <td>Additional files from which to load the Flyway configuration. The names of the individual properties match the ones you would
            use as Maven or System properties. The encoding of the file must be the same as the encoding defined with the
            flyway.encoding property, which is UTF-8 by default. Relative paths are relative to `workingDirectory`.</td>
    </tr>
    <tr>
        <td>workingDirectory</td>
        <td>NO</td>
        <td><i>project.basedir</i> (where the POM resides)</td>
        <td>The working directory to consider when dealing with relative paths for both config files and locations.</td>
    </tr>
     {% include cfg/validateMigrationNaming.html %}
    {% include cfg/licenseKey.html %}
    </tbody>
</table>

## Sample configuration

```xml
<configuration>
    <driver>org.hsqldb.jdbcDriver</driver>
    <url>jdbc:hsqldb:file:${project.build.directory}/db/flyway_sample;shutdown=true</url>
    <user>SA</user>
    <password>mySecretPwd</password>
    <connectRetries>10</connectRetries>
    <initSql>SET ROLE 'myuser'</initSql>
    <schemas>
        <schema>schema1</schema>
        <schema>schema2</schema>
        <schema>schema3</schema>
    </schemas>
    <callbacks>
        <callback>com.mycompany.project.CustomCallback</callback>
        <callback>com.mycompany.project.AnotherCallback</callback>
    </callbacks>
    <skipDefaultCallbacks>false</skipDefaultCallbacks>
    <cleanDisabled>false</cleanDisabled>
    <skip>false</skip>
    <configFiles>
        <configFile>myConfig.conf</configFile>
        <configFile>other.conf</configFile>
    </configFiles>
    <workingDirectory>/my/working/dir</workingDirectory>
</configuration>
```

## Sample output

<pre class="console">&gt; mvn flyway:clean

[INFO] [flyway:clean {execution: default-cli}]
[INFO] Cleaned database schema 'PUBLIC' (execution time 00:00.016s)</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/maven/info">Maven: info <i class="fa fa-arrow-right"></i></a>
</p>