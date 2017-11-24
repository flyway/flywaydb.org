---
layout: commandLine
pill: migrate
subtitle: 'Command-line: migrate'
---
# Command-line: migrate

Migrates the schema to the latest version. Flyway will create the metadata table automatically if it doesn't
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
    <tr>
        <td>schemas</td>
        <td>NO</td>
        <td><i>default schema of the connection</i></td>
        <td>Comma-separated case-sensitive list of schemas managed by Flyway.<br/>
            The first schema in the list will be automatically set as the default one during
            the migration. It will also be the one containing the metadata table.
        </td>
    </tr>
    <tr>
        <td>table</td>
        <td>NO</td>
        <td>schema_version</td>
        <td>The name of Flyway&#x27;s metadata table.<br/>By
            default (single-schema mode) the metadata table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the metadata table is placed in the first schema of the list.
        </td>
    </tr>
    <tr id="locations">
        <td>locations</td>
        <td>NO</td>
        <td><nobr>filesystem:<i>&lt;install-dir&gt;</i>/sql</nobr></td>
        <td>Comma-separated list of locations to scan recursively for migrations. The location type is determined by its prefix.<br/>
            Unprefixed locations or locations starting with <code>classpath:</code> point to a package on the classpath and may contain both sql and java-based migrations.<br/>
            Locations starting with <code>filesystem:</code> point to a directory on the filesystem and may only contain sql migrations.
        </td>
    </tr>
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
        <td>The file name prefix for Sql migrations</td>
    </tr>
    <tr>
        <td>repeatableSqlMigrationPrefix</td>
        <td>NO</td>
        <td>R</td>
        <td>The file name prefix for repeatable Sql migrations</td>
    </tr>
    <tr>
        <td>sqlMigrationSeparator</td>
        <td>NO</td>
        <td>__</td>
        <td>The file name separator for Sql migrations</td>
    </tr>
    <tr>
        <td>sqlMigrationSuffix</td>
        <td>NO</td>
        <td>.sql</td>
        <td>The file name suffix for Sql migrations</td>
    </tr>
    <tr>
        <td>mixed</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to allow mixing transactional and non-transactional statements within the same migration</td>
    </tr>
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
        <td>Comma-separated list of fully qualified class names of
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/callback/FlywayCallback">FlywayCallback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr>
        <td>skipDefaultCallbacks</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    <tr>
        <td>target</td>
        <td>NO</td>
        <td><i>latest version</i></td>
        <td>The target version up to which Flyway should consider migrations. Migrations with a higher version number will be ignored. The special value <code>current</code> designates the current version of the schema.
        </td>
    </tr>
    <tr>
        <td>outOfOrder</td>
        <td>NO</td>
        <td>false</td>
        <td>Allows migrations to be run "out of order".
            <p>If you already have versions 1 and 3 applied, and now a version 2 is found,
                it will be applied too instead of being ignored.</p>
        </td>
    </tr>
    <tr>
        <td>validateOnMigrate</td>
        <td>NO</td>
        <td>true</td>
        <td>Whether to automatically call validate or not when running migrate.<br/>
            For each sql migration a CRC32 checksum is calculated
            when the sql script is executed. The validate mechanism checks if the sql migration in the classpath
            still has the same checksum as the sql migration already executed in the database.<br/></td>
    </tr>
    <tr>
        <td>cleanOnValidationError</td>
        <td>NO</td>
        <td>false</td>
        <td>Whether to automatically call clean or not when a validation error occurs.<br/><br/>
            This is exclusively intended as a convenience for development. Even tough we
            strongly recommend not to change migration scripts once they have been checked into SCM and run, this
            provides a way of dealing with this case in a smooth manner. The database will be wiped clean
            automatically, ensuring that the next migration will bring you back to the state checked into
            SCM.<br/><br/><strong>Warning ! Do not enable in production !</strong>
        </td>
    </tr>
    <tr>
        <td>ignoreMissingMigrations</td>
        <td>NO</td>
        <td>false</td>
        <td>Ignore missing migrations when reading the metadata table. These are migrations that were performed by an
            older deployment of the application that are no longer available in this version. For example: we have migrations
            available on the classpath with versions 1.0 and 3.0. The metadata table indicates that a migration with version 2.0
            (unknown to us) has also been applied. Instead of bombing out (fail fast) with an exception, a
            warning is logged and Flyway continues normally. This is useful for situations where one must be able to deploy
            a newer version of the application even though it doesn't contain migrations included with an older one anymore.
        </td>
    </tr>
    <tr>
        <td>ignoreFutureMigrations</td>
        <td>NO</td>
        <td>true</td>
        <td>Ignore future migrations when reading the metadata table. These are migrations that were performed by a
            newer deployment of the application that are not yet available in this version. For example: we have migrations
            available on the classpath up to version 3.0. The metadata table indicates that a migration to version 4.0
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
        <td>The username that will be recorded in the metadata table as having applied the migration</td>
    </tr>
    <tr>
        <td>errorHandler {% include pro.html %}</td>
        <td>NO</td>
        <td><i>Fail on every error</i></td>
        <td>The fully qualified class name of the ErrorHandler for errors that occur during a migration.
            This can be used to customize Flyway's behavior by for example throwing another runtime exception,
            outputting a warning or suppressing the error instead of throwing a FlywaySqlException.</td>
    </tr>
    <tr>
        <td>dryRunOutput {% include pro.html %}</td>
        <td>NO</td>
        <td><i>Execute directly against the database</i></td>
        <td>The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent
            directory, Flyway will create all directories and parent directories as needed.
            Omit to use the default mode of executing the SQL statements directly against the database.</td>
    </tr>
    </tbody>
</table>

## Sample configuration

<pre class="prettyprint">flyway.driver=org.hsqldb.jdbcDriver
flyway.url=jdbc:hsqldb:file:/db/flyway_sample
flyway.user=SA
flyway.password=mySecretPwd
flyway.schemas=schema1,schema2,schema3
flyway.table=schema_history
flyway.locations=classpath:com.mycomp.migration,database/migrations,filesystem:/sql-migrations
flyway.sqlMigrationPrefix=Migration-
flyway.repeatableSqlMigrationPrefix=RRR
flyway.sqlMigrationSeparator=__
flyway.sqlMigrationSuffix=-OK.sql
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
flyway.validateOnMigrate=true
flyway.cleanOnValidationError=false
flyway.mixed=false
flyway.group=false
flyway.ignoreMissingMigrations=false
flyway.ignoreFutureMigrations=false
flyway.cleanDisabled=false
flyway.baselineOnMigrate=false
flyway.installedBy=my-user
flyway.errorHandler=com.mycompany.MyCustomErrorHandler
flyway.dryRunOutput=/my/sql/dryrun-outputfile.sql</pre>

## Sample output

<pre class="console">&gt; flyway migrate

Flyway {{ site.flywayVersion }} by Boxfuse

Creating Metadata table: "PUBLIC"."schema_version"
Current schema version: null
Migrating to version 1
Migrating to version 1.1
Migrating to version 1.3
Successfully applied 3 migrations (execution time 00:00.049s).</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/clean">Command-line: clean <i class="fa fa-arrow-right"></i></a>
</p>