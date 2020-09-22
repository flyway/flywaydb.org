---
layout: commandLine
pill: migrate
subtitle: 'Command-line: migrate'
---
# Command-line: migrate

Migrates the schema to the latest version. Flyway will create the schema history table automatically if it doesn't
    exist.

<a href="/documentation/command/migrate"><img src="/assets/balsamiq/command-migrate.png" alt="migrate"></a>

## Usage

<pre class="console"><span>&gt;</span> flyway [options] migrate</pre>

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
    <tr id="url">
        <td>url</td>
        <td>YES</td>
        <td></td>
        <td>The jdbc url to use to connect to the database</td>
    </tr>
    <tr id="driver">
        <td>driver</td>
        <td>NO</td>
        <td><i>Auto-detected based on url</i></td>
        <td>The fully qualified classname of the jdbc driver to use
            to connect to the database
        </td>
    </tr>
    <tr id="user">
        <td>user</td>
        <td>NO</td>
        <td></td>
        <td>The user to use to connect to the database</td>
    </tr>
    <tr id="password">
        <td>password</td>
        <td>NO</td>
        <td></td>
        <td>The password to use to connect to the database</td>
    </tr>
    {% include v6/cfg/connectRetries.html %}
    {% include v6/cfg/initSql.html %}
    {% include v6/cfg/schemas.html %}
    {% include v6/cfg/createSchemas.html %}
    <tr id="table">
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
    {% include v6/cfg/locations-commandline.html %}
    {% include v6/cfg/color.html %}
    <tr id="jarDirs">
        <td>jarDirs</td>
        <td>NO</td>
        <td><nobr><i>&lt;install-dir&gt;</i>/jars</nobr></td>
        <td>Comma-separated list of directories containing JDBC drivers and Java-based migrations</td>
    </tr>
    <tr id="sqlMigrationPrefix">
        <td>sqlMigrationPrefix</td>
        <td>NO</td>
        <td>V</td>
        <td><p>The file name prefix for versioned SQL migrations.</p>
            Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1.1__My_description.sql</td>
    </tr>
    <tr id="undoSqlMigrationPrefix">
        <td>undoSqlMigrationPrefix {% include pro.html %}</td>
        <td>NO</td>
        <td>U</td>
        <td><p>The file name prefix for undo SQL migrations.</p>
            <p>Undo SQL migrations are responsible for undoing the effects of the versioned migration with the same version.</p>
            They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
            which using the defaults translates to U1.1__My_description.sql</td>
    </tr>
    <tr id="repeatableSqlMigrationPrefix">
        <td>repeatableSqlMigrationPrefix</td>
        <td>NO</td>
        <td>R</td>
        <td><p>The file name prefix for repeatable SQL migrations.</p>
            Repeatable SQL migrations have the following file name structure: prefixSeparatorDESCRIPTIONsuffix ,
            which using the defaults translates to R__My_description.sql</td>
    </tr>
    <tr id="sqlMigrationSeparator">
        <td>sqlMigrationSeparator</td>
        <td>NO</td>
        <td>__</td>
        <td>The file name separator for Sql migrations</td>
    </tr>
    <tr id="sqlMigrationSuffixes">
        <td>sqlMigrationSuffixes</td>
        <td>NO</td>
        <td>.sql</td>
        <td><p>Comma-separated list of file name suffixes for SQL migrations.</p>
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
    <tr id="encoding">
        <td>encoding</td>
        <td>NO</td>
        <td>UTF-8</td>
        <td>The encoding of Sql migrations</td>
    </tr>
    <tr id="placeholderReplacement">
        <td>placeholderReplacement</td>
        <td>NO</td>
        <td>true</td>
        <td>Whether placeholders should be replaced</td>
    </tr>
    <tr id="placeholders">
        <td>placeholders.<i>name</i></td>
        <td>NO</td>
        <td></td>
        <td>Placeholders to replace in Sql migrations</td>
    </tr>
    <tr id="placeholderPrefix">
        <td>placeholderPrefix</td>
        <td>NO</td>
        <td>${</td>
        <td>The prefix of every placeholder</td>
    </tr>
    <tr id="placeholderSuffix">
        <td>placeholderSuffix</td>
        <td>NO</td>
        <td>}</td>
        <td>The suffix of every placeholder</td>
    </tr>
    <tr id="resolvers">
        <td>resolvers</td>
        <td>NO</td>
        <td></td>
        <td>Comma-separated list of fully qualified class names of custom
            <a href="/v6/v6/documentation/api/javadoc/org/flywaydb/core/api/resolver/MigrationResolver">MigrationResolver</a>
            implementations to be used in addition to the built-in ones for resolving Migrations to apply.</td>
    </tr>
    <tr id="skipDefaultResolvers">
        <td>skipDefaultResolvers</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in resolvers (sql, jdbc and spring-jdbc) should be skipped. If true, only custom resolvers are used.</td>
    </tr>
    <tr id="callbacks">
        <td>callbacks</td>
        <td>NO</td>
        <td></td>
        <td>Comma-separated list of fully qualified class names of
            <a href="/v6/v6/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr id="skipDefaultCallbacks">
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    {% include v6/cfg/target-latest.html %}
    <tr id="outOfOrder">
        <td>outOfOrder</td>
        <td>NO</td>
        <td>false</td>
        <td>Allows migrations to be run "out of order".
            <p>If you already have versions 1 and 3 applied, and now a version 2 is found,
                it will be applied too instead of being ignored.</p>
        </td>
    </tr>
    {% include v6/cfg/outputQueryResults.html %}
    <tr id="validateOnMigrate">
        <td>validateOnMigrate</td>
        <td>NO</td>
        <td>true</td>
        <td>Whether to automatically call validate or not when running migrate.<br/>
            For each sql migration a CRC32 checksum is calculated
            when the sql script is executed. The validate mechanism checks if the sql migration in the classpath
            still has the same checksum as the sql migration already executed in the database.<br/></td>
    </tr>
    {% include v6/cfg/cleanOnValidationError.html %}
    <tr id="ignoreMissingMigrations">
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
    <tr id="ignoreIgnoredMigrations">
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
    <tr id="ignoreFutureMigrations">
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
    <tr id="cleanDisabled">
        <td>cleanDisabled</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.</td>
    </tr>
    <tr id="baselineOnMigrate">
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
    {% include v6/cfg/errorOverrides-commandline.html %}
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
flyway.defaultSchema=schema1
flyway.schemas=schema1,schema2,schema3
flyway.createSchemas=true
flyway.table=schema_history
flyway.tablespace=my_tablespace
flyway.locations=classpath:com.mycomp.migration,database/migrations,filesystem:/sql-migrations
flyway.sqlMigrationPrefix=Migration-
flyway.undoSqlMigrationPrefix=downgrade
flyway.repeatableSqlMigrationPrefix=RRR
flyway.sqlMigrationSeparator=__
flyway.sqlMigrationSuffixes=.sql,.pkg,.pkb
flyway.stream=true
flyway.batch=true
flyway.encoding=ISO-8859-1
flyway.placeholderReplacement=true
flyway.placeholders.aplaceholder=value
flyway.placeholders.otherplaceholder=value123
flyway.placeholderPrefix=#[
flyway.placeholderSuffix=]
flyway.resolvers=com.mycomp.project.CustomResolver,com.mycomp.project.AnotherResolver
flyway.skipDefaultCallResolvers=false
flyway.callbacks=com.mycomp.project.CustomCallback,com.mycomp.project.AnotherCallback
flyway.skipDefaultCallbacks=false
flyway.target=5.1
flyway.outOfOrder=false
flyway.outputQueryResults=false
flyway.validateOnMigrate=true
flyway.cleanOnValidationError=false
flyway.mixed=false
flyway.group=false
flyway.ignoreMissingMigrations=false
flyway.ignoreIgnoredMigrations=false
flyway.ignoreFutureMigrations=false
flyway.cleanDisabled=false
flyway.baselineOnMigrate=false
flyway.installedBy=my-user
flyway.errorOverrides=99999:17110:E,42001:42001:W
flyway.dryRunOutput=/my/sql/dryrun-outputfile.sql
flyway.oracle.sqlplus=true
flyway.oracle.sqlplusWarn=true
flyway.workingDirectory=C:/myProject
```

## Sample output

<pre class="console">&gt; flyway migrate

Flyway {{ site.flywayVersion }} by Redgate

Database: jdbc:h2:file:flyway.db (H2 1.3)
Successfully validated 5 migrations (execution time 00:00.010s)
Creating Schema History table: "PUBLIC"."flyway_schema_history"
Current version of schema "PUBLIC": << Empty Schema >>
Migrating schema "PUBLIC" to version 1 - First
Migrating schema "PUBLIC" to version 1.1 - View
Successfully applied 2 migrations to schema "PUBLIC" (execution time 00:00.030s).</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/clean">Command-line: clean <i class="fa fa-arrow-right"></i></a>
</p>