---
layout: maven
pill: migrate
subtitle: 'mvn flyway:migrate'
---
# Maven Goal: Migrate

Migrates the schema to the latest version. Flyway will create the schema history table automatically if it doesn't
    exist.

<a href="v6/documentation/command/migrate"><img src="/assets/balsamiq/command-migrate.png" alt="migrate"></a>

## Default Phase

- pre-integration-test

## Usage

<pre class="console">&gt; mvn flyway:migrate</pre>

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
    {% include v6/cfg/locations-maven-gradle.html %}
    <tr>
        <td>sqlMigrationPrefix</td>
        <td>NO</td>
        <td>V</td>
        <td><p>The file name prefix for versioned SQL migrations.</p>
            Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1.1__My_description.sql</td>
    </tr>
    <tr>
        <td>undoSqlMigrationPrefix {% include pro.html %}</td>
        <td>NO</td>
        <td>U</td>
        <td><p>The file name prefix for undo SQL migrations.</p>
            <p>Undo SQL migrations are responsible for undoing the effects of the versioned migration with the same version.</p>
            They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
            which using the defaults translates to U1.1__My_description.sql</td>
    </tr>
    <tr>
        <td>repeatableSqlMigrationPrefix</td>
        <td>NO</td>
        <td>R</td>
        <td><p>The file name prefix for repeatable SQL migrations.</p>
            Repeatable SQL migrations have the following file name structure: prefixSeparatorDESCRIPTIONsuffix ,
            which using the defaults translates to R__My_description.sql</td>
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
     {% include v6/cfg/validateMigrationNaming.html %}
    <tr id="stream">
        <td>stream {% include pro.html %}</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to stream SQL migrations when executing them. Streaming doesn't load the entire migration in memory at
            once. Instead each statement is loaded individually. This is particularly useful for very large SQL migrations
            composed of multiple MB or even GB of reference data, as this dramatically reduces Flyway's memory consumption.</td>
    </tr>
    <tr id="batch">
        <td>batch {% include pro.html %}</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to batch SQL statements when executing them. Batching can save up to 99 percent of network roundtrips by
            sending up to 100 statements at once over the network to the database, instead of sending each statement
            individually. This is particularly useful for very large SQL migrations composed of multiple MB or even GB of
            reference data, as this can dramatically reduce the network overhead. This is supported for INSERT, UPDATE,
            DELETE, MERGE and UPSERT statements. All other statements are automatically executed without batching.</td>
    </tr>
    {% include v6/cfg/mixed.html %}
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
            <a href="v6/documentation/api/javadoc/org/flywaydb/core/api/resolver/MigrationResolver">MigrationResolver</a>
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
            <a href="v6/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr>
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    {% include v6/cfg/target-latest.html %}
    <tr>
        <td>outOfOrder</td>
        <td>NO</td>
        <td>false</td>
        <td>Allows migrations to be run "out of order".
            <p>If you already have versions 1 and 3 applied, and now a version 2 is found,
                it will be applied too instead of being ignored.</p>
        </td>
    </tr>
    {% include v6/cfg/outputQueryResults.html %}
    <tr>
        <td>validateOnMigrate</td>
        <td>NO</td>
        <td>true</td>
        <td>Whether to automatically call validate or not when running migrate.<br/>
            For each sql migration a CRC32 checksum is calculated
            when the sql script is executed. The validate mechanism checks if the sql migration in the classpath
            still has the same checksum as the sql migration already executed in the database.<br/></td>
    </tr>
    {% include v6/cfg/cleanOnValidationError.html %}
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
        <td>cleanDisabled</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.</td>
    </tr>
    <tr>
        <td>baselineOnMigrate</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to automatically call baseline when migrate is executed against a non-empty schema with no metadata
            table.
            This schema will then be baselined with the <code>baselineVersion</code> before executing the migrations.
            Only migrations above <code>baselineVersion</code> will then be applied.<br/>

            <p>This is useful for initial Flyway production deployments on projects with an existing DB.</p>

            <p>Be careful when enabling this as it removes the safety net that ensures Flyway does not migrate the wrong
                database in case of a configuration mistake!</p>
        </td>
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
    {% include v6/cfg/errorOverrides-maven-gradle.html %}
    <tr id="dryRunOutput">
        <td>dryRunOutput {% include pro.html %}</td>
        <td>NO</td>
        <td><i>Execute directly against the database</i></td>
        <td>The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent
            directory, Flyway will create all directories and parent directories as needed.
            Omit to use the default mode of executing the SQL statements directly against the database.</td>
    </tr>
    {% include v6/cfg/oracleSqlplus.html %}
    {% include v6/cfg/oracleSqlplusWarn.html %}
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
    <locations>
        <location>classpath:migrations1</location>
        <location>migrations2</location>
        <location>filesystem:/sql-migrations</location>
    </locations>
    <sqlMigrationPrefix>Migration-</sqlMigrationPrefix>
    <undoSqlMigrationPrefix>downgrade</undoSqlMigrationPrefix>
    <repeatableSqlMigrationPrefix>RRR</repeatableSqlMigrationPrefix>
    <sqlMigrationSeparator>__</sqlMigrationSeparator>
    <sqlMigrationSuffixes>
        <sqlMigrationSuffix>.sql</sqlMigrationSuffix>
        <sqlMigrationSuffix>.pkg</sqlMigrationSuffix>
        <sqlMigrationSuffix>.pkb</sqlMigrationSuffix>
    </sqlMigrationSuffixes>
    <stream>true</stream>
    <batch>true</batch>
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
    <target>1.1</target>
    <outOfOrder>false</outOfOrder>
    <outputQueryResults>false</outputQueryResults>
    <validateOnMigrate>true</validateOnMigrate>
    <cleanOnValidationError>false</cleanOnValidationError>
    <mixed>false</mixed>
    <group>false</group>
    <ignoreMissingMigrations>false</ignoreMissingMigrations>
    <ignoreIgnoredMigrations>false</ignoreIgnoredMigrations>
    <ignoreFutureMigrations>false</ignoreFutureMigrations>
    <cleanDisabled>false</cleanDisabled>
    <baselineOnMigrate>false</baselineOnMigrate>
    <baselineVersion>5</baselineVersion>
    <baselineDescription>Let's go!</baselineDescription>
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
<pre class="console">&gt; mvn compile flyway:migrate

[INFO] [compiler:compile {execution: default-compile}]
[INFO] Nothing to compile - all classes are up to date
[INFO] [flyway:migrate {execution: default-cli}]
[INFO] Current schema version: 0
[INFO] Migrating to version 1
[INFO] Migrating to version 1.1
[INFO] Migrating to version 1.2
[INFO] Migrating to version 1.3
[INFO] Successfully applied 4 migrations (execution time 00:00.091s).</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/maven/clean">Maven: clean <i class="fa fa-arrow-right"></i></a>
</p>