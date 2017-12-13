---
layout: gradle
pill: migrate
subtitle: 'gradle flywayMigrate'
---
# Gradle Task: flywayMigrate

Migrates the schema to the latest version. Flyway will create the schema history table automatically if it doesn't
    exist.

<a href="/documentation/command/migrate"><img src="/assets/balsamiq/command-migrate.png" alt="migrate"></a>

## Usage
<pre class="console">&gt; gradle flywayMigrate</pre>

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
    <tr>
        <td>schemas</td>
        <td>NO</td>
        <td><i>default schema of the connection</i></td>
        <td>Case-sensitive list of schemas managed by Flyway.<br/>
            The first schema in the list will be automatically set as the default one during
            the migration. It will also be the one containing the schema history table.
        </td>
    </tr>
    <tr>
        <td>table</td>
        <td>NO</td>
        <td>flyway_schema_history</td>
        <td>The name of Flyway&#x27;s schema history table.<br/>By
            default (single-schema mode) the schema history table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the schema history table is placed in the first schema of the list.
        </td>
    </tr>
    <tr>
        <td>locations</td>
        <td>NO</td>
        <td>filesystem:src/main/resources/db/migration</td>
        <td>Locations to scan recursively for migrations. The location type is determined by its prefix.<br/>
            Unprefixed locations or locations starting with <code>classpath:</code> point to a package on the
            classpath and may contain both sql and java-based migrations.<br/>
            Locations starting with <code>filesystem:</code> point to a directory on the filesystem and may only
            contain sql migrations.
        </td>
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
        <td>placeholders</td>
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
        <td>The target version up to which Flyway should run
            migrations. Migrations with a higher version number will not be applied. The string 'current' will be
            interpreted as MigrationVersion.CURRENT, a placeholder for the latest version that has been applied to the
            database.
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
        <td>errorHandlers {% include pro.html %}</td>
        <td>NO</td>
        <td><i>none</i></td>
        <td>The fully qualified class names of handlers for errors and warnings that occur during
         a migration. This can be used to customize Flyway's behavior by for example throwing another runtime exception,
          outputting a warning or suppressing the error instead of throwing a FlywayException. ErrorHandlers are invoked
           in order until one reports to have successfully handled the errors or warnings.
           If none do, or if none are present, Flyway falls back to its default handling of errors and warnings.
           </td>
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

<pre class="prettyprint">flyway {
    driver = 'org.hsqldb.jdbcDriver'
    url = 'jdbc:hsqldb:file:/db/flyway_sample;shutdown=true'
    user = 'SA'
    password = 'mySecretPwd'
    schemas = ['schema1', 'schema2', 'schema3']
    table = 'schema_history'
    locations = ['classpath:migrations', 'classpath:db/pkg', 'filesystem:/sql-migrations']
    sqlMigrationPrefix = 'Migration-'
    undoSqlMigrationPrefix = 'downgrade'
    repeatableSqlMigrationPrefix = 'RRR'
    sqlMigrationSeparator = '__'
    sqlMigrationSuffixes = ['.sql', '.pkg', '.pkb']
    encoding = 'ISO-8859-1'
    placeholderReplacement = true
    placeholders = [
        'aplaceholder' : 'value',
        'otherplaceholder' : 'value123'
    ]
    placeholderPrefix = '#['
    placeholderSuffix = ']'
    resolvers = ['com.mycompany.proj.CustomResolver', 'com.mycompany.proj.AnotherResolver']
    skipDefaultResolvers = false
    callbacks = ['com.mycompany.proj.CustomCallback', 'com.mycompany.proj.AnotherCallback']
    skipDefaultCallbacks = false
    target = '1.1'
    outOfOrder = false
    validateOnMigrate = true
    cleanOnValidationError = false
    mixed = false
    group = false
    ignoreMissingMigrations = false
    ignoreIgnoredMigrations = false
    ignoreFutureMigrations = false
    cleanDisabled = false
    baselineOnMigrate = false
    baselineVersion = 5
    baselineDescription = "Let's go!"
    installedBy = "my-user"
    errorHandlers = ['com.mycomp.MyCustomErrorHandler', 'com.mycomp.AnotherErrorHandler']
    dryRunOutput = '/my/sql/dryrun-outputfile.sql'
}</pre>

<h2>Sample output</h2>
<pre class="console">&gt; gradle flywayMigrate -i

Current schema version: 0
Migrating to version 1
Migrating to version 1.1
Migrating to version 1.2
Migrating to version 1.3
Successfully applied 4 migrations (execution time 00:00.091s).</pre>

## Important Note

When using Spring JDBC migrations, you must declare a dependency on `org.springframework:spring-jdbc:${springVersion}`
in Gradle's `buildScript` block to avoid being hit with a `java.lang.LinkageError`.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/gradle/clean">Gradle: clean <i class="fa fa-arrow-right"></i></a>
</p>