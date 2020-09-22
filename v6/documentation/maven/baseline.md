---
layout: maven
pill: baseline
subtitle: 'mvn flyway:baseline'
---
# Maven Goal: Baseline

Baselines an existing database, excluding all migrations up to and including baselineVersion.

<a href="/v6/documentation/command/baseline"><img src="/assets/balsamiq/command-baseline.png" alt="baseline"></a>

## Usage

<pre class="console"><span>&gt;</span> mvn flyway:baseline</pre>

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
    {% include v6/cfg/connectRetries.html %}
    {% include v6/cfg/initSql.html %}
    {% include v6/cfg/schemas.html %}
    {% include v6/cfg/createSchemas.html %}
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
    {% include v6/cfg/tablespace.html %}
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
        <td>baselineVersion</td>
        <td>NO</td>
        <td>1</td>
        <td>The version to tag an existing schema with when executing baseline</td>
    </tr>
    <tr>
        <td>baselineDescription</td>
        <td>NO</td>
        <td>
            <nobr>&lt;&lt; Flyway Baseline &gt;&gt;</nobr>
        </td>
        <td>The description to tag an existing schema with when executing baseline</td>
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
     {% include v6/cfg/validateMigrationNaming.html %}
    {% include v6/cfg/licenseKey.html %}
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
    <createSchemas>true</createSchemas>
    <table>schema_history</table>
    <tablespace>my_tablespace</tablespace>
    <callbacks>
        <callback>com.mycompany.project.CustomCallback</callback>
        <callback>com.mycompany.project.AnotherCallback</callback>
    </callbacks>
    <skipDefaultCallbacks>false</skipDefaultCallbacks>
    <baselineVersion>1.0</baselineVersion>
    <baselineDescription>Base Migration</baselineDescription>
    <skip>false</skip>
    <configFiles>
        <configFile>myConfig.conf</configFile>
        <configFile>other.conf</configFile>
    </configFiles>
    <workingDirectory>/my/working/dir</workingDirectory>
</configuration>
```

## Sample output

<pre class="console">&gt; mvn flyway:baseline

[INFO] [flyway:baseline {execution: default-cli}]
[INFO] Creating schema history table: "PUBLIC"."flyway_schema_history"
[INFO] Schema baselined with version: 1</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/v6/documentation/maven/repair">Maven: repair <i class="fa fa-arrow-right"></i></a>
</p>