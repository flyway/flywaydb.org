---
layout: maven
pill: undo
subtitle: 'mvn flyway:undo'
---
# Maven Goal: Undo
{% include pro.html %}

[Undoes](/documentation/command/undo) the most recently applied versioned migration.

<a href="/documentation/command/undo"><img src="/assets/balsamiq/command-undo.png" alt="undo"></a>

## Usage

<pre class="console">&gt; mvn flyway:undo</pre>

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
        <td>table</td>
        <td>NO</td>
        <td>flyway_schema_history</td>
        <td>The name of Flyway's schema history table.<br/>By
            default (single-schema mode) the schema history table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the schema history table is placed in the first schema of the list.
        </td>
    </tr>
    {% include cfg/locations-maven-gradle.html %}
    <tr>
        <td>sqlMigrationPrefix</td>
        <td>NO</td>
        <td>V</td>
        <td><p>The file name prefix for versioned SQL migrations.</p>
            Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1.1__My_description.sql</td>
    </tr>
    <tr>
        <td>undoSqlMigrationPrefix</td>
        <td>NO</td>
        <td>U</td>
        <td><p>The file name prefix for undo SQL migrations.</p>
            <p>Undo SQL migrations are responsible for undoing the effects of the versioned migration with the same version.</p>
            They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
            which using the defaults translates to U1.1__My_description.sql</td>
    </tr>
    <tr>
        <td>sqlMigrationSeparator</td>
        <td>NO</td>
        <td>__</td>
        <td>The file name separator for Sql migrations</td>
    </tr>
    <tr>
        <td>sqlMigrationSuffixes</td>
        <td>NO</td>
        <td>.sql</td>
        <td><p>The file name suffixes for SQL migrations.</p>
            <p>SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1_1__My_description.sql</p>
            Multiple suffixes (like .sql,.pkg,.pkb) can be specified for easier compatibility with other tools such as
            editors with specific file associations.</td>
    </tr>
     {% include cfg/validateMigrationNaming.html %}
    {% include cfg/mixed.html %}
    <tr id="group">
        <td>group</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to group all pending migrations together in the same transaction when applying them (only recommended for databases with support for DDL transactions)</td>
    </tr>
    <tr>
        <td>encoding</td>
        <td>NO</td>
        <td>UTF-8</td>
        <td>The encoding of Sql migrations</td>
    </tr>
    <tr>
        <td>placeholderReplacement</td>
        <td>NO</td>
        <td>true</td>
        <td>Whether placeholders should be replaced</td>
    </tr>
    <tr>
        <td>placeholders</td>
        <td>NO</td>
        <td></td>
        <td>Placeholders to replace in Sql migrations</td>
    </tr>
    <tr>
        <td>placeholderPrefix</td>
        <td>NO</td>
        <td>${</td>
        <td>The prefix of every placeholder </td>
    </tr>
    <tr>
        <td>placeholderSuffix</td>
        <td>NO</td>
        <td>}
        </td>
        <td>The suffix of every placeholder</td>
    </tr>
    <tr>
        <td>resolvers</td>
        <td>NO</td>
        <td></td>
        <td>Fully qualified class names of custom
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/resolver/MigrationResolver">MigrationResolver</a>
            implementations to be used in addition to the built-in ones for resolving Migrations to apply.</td>
    </tr>
    <tr>
        <td>skipDefaultResolvers</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in resolvers (sql, jdbc and spring-jdbc) should be skipped. If true, only custom resolvers are used.</td>
    </tr>
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
    {% include cfg/outputQueryResults.html %}
    {% include cfg/target-previous.html %}
    {% include cfg/cleanOnValidationError.html %}
    <tr>
        <td>ignoreMissingMigrations</td>
        <td>NO</td>
        <td>false</td>
        <td>Ignore missing migrations when reading the schema history table. These are migrations that were performed by an
            older deployment of the application that are no longer available in this version. For example: we have migrations
            available on the classpath with versions 1.0 and 3.0. The schema history table indicates that a migration with version 2.0
            (unknown to us) has also been applied. Instead of bombing out (fail fast) with an exception, a
            warning is logged and Flyway continues normally. This is useful for situations where one must be able to deploy
            a newer version of the application even though it doesn't contain migrations included with an older one anymore.
            Note that if the most recently applied migration is removed, Flyway has no way to know it is missing and will 
            mark it as future instead.
        </td>
    </tr>
    <tr>
        <td>ignoreIgnoredMigrations</td>
        <td>NO</td>
        <td>false</td>
        <td>Ignore ignored migrations when reading the schema history table. These are migrations that were added in between
            already migrated migrations in this version. For example: we have migrations available on the classpath with
            versions from 1.0 to 3.0. The schema history table indicates that version 1 was finished on 1.0.15, and the next
            one was 2.0.0. But with the next release a new migration was added to version 1: 1.0.16. Such scenario is ignored
            by migrate command, but by default is rejected by validate. When ignoreIgnoredMigrations is enabled, such case
            will not be reported by validate command. This is useful for situations where one must be able to deliver
            complete set of migrations in a delivery package for multiple versions of the product, and allows for further
            development of older versions.
        </td>
    </tr>
    <tr>
        <td>ignoreFutureMigrations</td>
        <td>NO</td>
        <td>true</td>
        <td>Ignore future migrations when reading the schema history table. These are migrations that were performed by a
            newer deployment of the application that are not yet available in this version. For example: we have migrations
            available on the classpath up to version 3.0. The schema history table indicates that a migration to version 4.0
            (unknown to us) has already been applied. Instead of bombing out (fail fast) with an exception, a
            warning is logged and Flyway continues normally. This is useful for situations where one must be able to redeploy
            an older version of the application after the database has been migrated by a newer one.</td>
    </tr>
    <tr>
        <td>installedBy</td>
        <td>NO</td>
        <td><i>Current database user</i></td>
        <td>The username that will be recorded in the schema history table as having applied the migration</td>
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
    {% include cfg/errorOverrides-maven-gradle.html %}
    <tr>
        <td>dryRunOutput</td>
        <td>NO</td>
        <td><i>Execute directly against the database</i></td>
        <td>The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent
            directory, Flyway will create all directories and parent directories as needed.
            Omit to use the default mode of executing the SQL statements directly against the database.</td>
    </tr>
    {% include cfg/oracleSqlplus.html %}
    {% include cfg/oracleSqlplusWarn.html %}
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
    <table>schema_history</table>
    <locations>
        <location>classpath:migrations1</location>
        <location>migrations2</location>
        <location>filesystem:/sql-migrations</location>
    </locations>
    <sqlMigrationPrefix>Migration-</sqlMigrationPrefix>
    <undoSqlMigrationPrefix>downgrade</undoSqlMigrationPrefix>
    <sqlMigrationSeparator>__</sqlMigrationSeparator>
    <sqlMigrationSuffixes>
        <sqlMigrationSuffix>.sql</sqlMigrationSuffix>
        <sqlMigrationSuffix>.pkg</sqlMigrationSuffix>
        <sqlMigrationSuffix>.pkb</sqlMigrationSuffix>
    </sqlMigrationSuffixes>
    <encoding>ISO-8859-1</encoding>
    <placeholderReplacement>true</placeholderReplacement>
    <placeholders>
        <aplaceholder>value</aplaceholder>
        <otherplaceholder>value123</otherplaceholder>
    </placeholders>
    <placeholderPrefix>#[</placeholderPrefix>
    <placeholderSuffix>]</placeholderSuffix>
    <resolvers>
        <resolver>com.mycompany.project.CustomResolver</resolver>
        <resolver>com.mycompany.project.AnotherResolver</resolver>
    </resolvers>
    <skipDefaultResolvers>false</skipDefaultResolvers>
    <callbacks>
        <callback>com.mycompany.project.CustomCallback</callback>
        <callback>com.mycompany.project.AnotherCallback</callback>
    </callbacks>
    <skipDefaultCallbacks>false</skipDefaultCallbacks>
    <outputQueryResults>false</outputQueryResults>
    <target>1.1</target>
    <mixed>false</mixed>
    <group>false</group>
    <cleanOnValidationError>false</cleanOnValidationError>
    <ignoreMissingMigrations>false</ignoreMissingMigrations>
    <ignoreIgnoredMigrations>false</ignoreIgnoredMigrations>
    <ignoreFutureMigrations>false</ignoreFutureMigrations>
    <installedBy>my-user</installedBy>
    <skip>false</skip>
    <configFiles>
        <configFile>myConfig.conf</configFile>
        <configFile>other.conf</configFile>
    </configFiles>
    <workingDirectory>/my/working/dir</workingDirectory>
    <errorOverrides>
        <errorOverride>99999:17110:E</errorOverride>
        <errorOverride>42001:42001:W</errorOverride>
    </errorOverrides>
    <dryRunOutput>/my/sql/dryrun-outputfile.sql</dryRunOutput>
    <oracle.sqlplus>true</oracle.sqlplus>
    <oracle.sqlplusWarn>true</oracle.sqlplusWarn>
</configuration>
```

## Exposed properties
The new database version number is exposed in the `flyway.current` Maven property.

## Sample output
<pre class="console">&gt; mvn compile flyway:undo

[INFO] [compiler:compile {execution: default-compile}]
[INFO] Nothing to compile - all classes are up to date
[INFO] [flyway:migrate {execution: default-cli}]
[INFO] Database: jdbc:h2:file:C:\Programs\flyway-0-SNAPSHOT\flyway.db (H2 1.3)
[INFO] Current version of schema "PUBLIC": 1
[INFO] Undoing migration of schema "PUBLIC" to version 1 - First
[INFO] Successfully undid 1 migration to schema "PUBLIC" (execution time 00:00.024s).</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/maven/baseline">Maven: baseline <i class="fa fa-arrow-right"></i></a>
</p>