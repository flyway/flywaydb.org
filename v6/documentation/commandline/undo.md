---
layout: commandLine
pill: undo
subtitle: 'Command-line: undo'
---
# Command-line: undo
{% include pro.html %}

[Undoes](v6/documentation/command/undo) the most recently applied versioned migration.

<a href="v6/documentation/command/undo"><img src="/assets/balsamiq/command-undo.png" alt="undo"></a>

## Usage

<pre class="console"><span>&gt;</span> flyway [options] undo</pre>

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
    {% include v6/cfg/locations-commandline.html %}
    {% include v6/cfg/color.html %}
    <tr id="jarDirs">
        <td>jarDirs</td>
        <td>NO</td>
        <td><nobr><i>&lt;install-dir&gt;</i>/jars</nobr></td>
        <td>Comma-separated list of directories containing JDBC drivers and Java-based migrations</td>
    </tr>
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
        <td><p>Comma-separated list of file name suffixes for SQL migrations.</p>
            <p>SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1_1__My_description.sql</p>
            Multiple suffixes (like .sql,.pkg,.pkb) can be specified for easier compatibility with other tools such as
                editors with specific file associations.</td>
    </tr>
     {% include v6/cfg/validateMigrationNaming.html %}
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
        <td>placeholders.<i>name</i></td>
        <td>NO</td>
        <td></td>
        <td>Placeholders to replace in Sql migrations</td>
    </tr>
    <tr>
        <td>placeholderPrefix</td>
        <td>NO</td>
        <td>${</td>
        <td>The prefix of every placeholder</td>
    </tr>
    <tr>
        <td>placeholderSuffix</td>
        <td>NO</td>
        <td>}</td>
        <td>The suffix of every placeholder</td>
    </tr>
    <tr>
        <td>resolvers</td>
        <td>NO</td>
        <td></td>
        <td>Comma-separated list of fully qualified class names of custom
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
        <td>Comma-separated list of fully qualified class names of
            <a href="v6/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr>
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    {% include v6/cfg/outputQueryResults.html %}
    {% include v6/cfg/target-previous.html %}
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
        <td>installedBy</td>
        <td>NO</td>
        <td><i>Current database user</i></td>
        <td>The username that will be recorded in the schema history table as having applied the migration</td>
    </tr>
    {% include v6/cfg/errorOverrides-commandline.html %}
    <tr>
        <td>dryRunOutput</td>
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
flyway.schemas=schema1,schema2,schema3
flyway.table=schema_history
flyway.locations=classpath:com.mycomp.migration,database/migrations,filesystem:/sql-migrations
flyway.sqlMigrationPrefix=Migration-
flyway.undoSqlMigrationPrefix=downgrade
flyway.repeatableSqlMigrationPrefix=RRR
flyway.sqlMigrationSeparator=__
flyway.sqlMigrationSuffixes=.sql,.pkg,.pkb
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
flyway.outputQueryResults=false
flyway.target=5.1
flyway.mixed=false
flyway.group=false
flyway.cleanOnValidationError=false
flyway.ignoreMissingMigrations=false
flyway.ignoreIgnoredMigrations=false
flyway.ignoreFutureMigrations=false
flyway.installedBy=my-user
flyway.errorOverrides=99999:17110:E,42001:42001:W
flyway.dryRunOutput=/my/sql/dryrun-outputfile.sql
flyway.oracle.sqlplus=true
flyway.oracle.sqlplusWarn=true
flyway.workingDirectory=C:/myProject
```

## Sample output

<pre class="console">&gt; flyway undo

Flyway {{ site.flywayVersion }} by Redgate

Database: jdbc:h2:file:C:\Programs\flyway-0-SNAPSHOT\flyway.db (H2 1.3)
Current version of schema "PUBLIC": 1
Undoing migration of schema "PUBLIC" to version 1 - First
Successfully undid 1 migration to schema "PUBLIC" (execution time 00:00.024s).</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/commandline/baseline">Command-line: baseline <i class="fa fa-arrow-right"></i></a>
</p>