---
layout: documentation
menu: envvars
subtitle: Environment Variables
---
# Environment Variables

The Flyway [command-line tool](/documentation/commandline), [Maven plugin](/documentation/maven) and
[Gradle plugin](/documentation/gradle) optionally support loading configuration via environment variables.
This also possible using the Flyway API by calling the `envVars()` method on the configuration.

## Reference

The following environment variables are supported:

<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th>Environment Variable</th>
        <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr id="FLYWAY_CONFIG_FILES">
        <td>FLYWAY_CONFIG_FILES</td>
        <td>Comma-separated list of configuration files to load</td>
    </tr>
    <tr id="FLYWAY_CONFIG_FILE_ENCODING">
        <td>FLYWAY_CONFIG_FILE_ENCODING</td>
        <td>The encoding to use when loading configuration files</td>
    </tr>
    <tr id="FLYWAY_URL">
        <td>FLYWAY_URL</td>
        <td>The jdbc url to use to connect to the database</td>
    </tr>
    <tr id="FLYWAY_DRIVER">
        <td>FLYWAY_DRIVER</td>
        <td>The fully qualified classname of the JDBC driver to use to connect to the database</td>
    </tr>
    <tr id="FLYWAY_USER">
        <td>FLYWAY_USER</td>
        <td>The user to use to connect to the database</td>
    </tr>
    <tr id="FLYWAY_PASSWORD">
        <td>FLYWAY_PASSWORD</td>
        <td>The password to use to connect to the database</td>
    </tr>
    <tr id="FLYWAY_SCHEMAS">
        <td>FLYWAY_SCHEMAS</td>
        <td>Comma-separated case-sensitive list of schemas managed by Flyway.<br/>
            The first schema in the list will be automatically set as the default one during
            the migration. It will also be the one containing the schema history table.
        </td>
    </tr>
    <tr id="FLYWAY_TABLE">
        <td>FLYWAY_TABLE</td>
        <td>The name of Flyway&#x27;s schema history table.<br/>By
            default (single-schema mode) the schema history table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the schema history table is placed in the first schema of the list.
        </td>
    </tr>
    <tr id="FLYWAY_LOCATIONS">
        <td>FLYWAY_LOCATIONS</td>
        <td>Comma-separated list of locations to scan recursively for migrations. The location type is determined by its prefix.<br/>
            Unprefixed locations or locations starting with <code>classpath:</code> point to a package on the classpath and may contain both sql and java-based migrations.<br/>
            Locations starting with <code>filesystem:</code> point to a directory on the filesystem and may only contain sql migrations.
        </td>
    </tr>
    <tr id="FLYWAY_JAR_DIRS">
        <td>FLYWAY_JAR_DIRS</td>
        <td>Comma-separated list of directories containing JDBC drivers and Java-based migrations</td>
    </tr>
    <tr id="FLYWAY_SQL_MIGRATION_PREFIX">
        <td>FLYWAY_SQL_MIGRATION_PREFIX</td>
        <td><p>The file name prefix for versioned SQL migrations.</p>
            Versioned SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1.1__My_description.sql</td>
    </tr>
    <tr id="FLYWAY_UNDO_SQL_MIGRATION_PREFIX">
        <td>FLYWAY_UNDO_SQL_MIGRATION_PREFIX {% include pro.html %}</td>
        <td><p>The file name prefix for undo SQL migrations.</p>
            <p>Undo SQL migrations are responsible for undoing the effects of the versioned migration with the same version.</p>
            They have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
            which using the defaults translates to U1.1__My_description.sql</td>
    </tr>
    <tr id="FLYWAY_REPEATABLE_SQL_MIGRATION_PREFIX">
        <td>FLYWAY_REPEATABLE_SQL_MIGRATION_PREFIX</td>
        <td><p>The file name prefix for repeatable SQL migrations.</p>
            Repeatable SQL migrations have the following file name structure: prefixSeparatorDESCRIPTIONsuffix ,
            which using the defaults translates to R__My_description.sql</td>
    </tr>
    <tr id="FLYWAY_SQL_MIGRATION_SEPARATOR">
        <td>FLYWAY_SQL_MIGRATION_SEPARATOR</td>
        <td>The file name separator for Sql migrations</td>
    </tr>
    <tr id="FLYWAY_SQL_MIGRATION_SUFFIXES">
        <td>FLYWAY_SQL_MIGRATION_SUFFIXES</td>
        <td><p>Comma-separated list of file name suffixes for SQL migrations.</p>
            <p>SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1_1__My_description.sql</p>
            Multiple suffixes (like .sql,.pkg,.pkb) can be specified for easier compatibility with other tools such as
                editors with specific file associations.</td>
    </tr>
    <tr id="FLYWAY_STREAM">
        <td>FLYWAY_STREAM {% include pro.html %}</td>
        <td>Whether to stream SQL migrations when executing them. Streaming doesn't load the entire migration in memory at
            once. Instead each statement is loaded individually. This is particularly useful for very large SQL migrations
            composed of multiple MB or even GB of reference data, as this dramatically reduces Flyway's memory consumption.</td>
    </tr>
    <tr id="FLYWAY_MIXED">
        <td>FLYWAY_MIXED</td>
        <td>Whether to allow mixing transactional and non-transactional statements within the same migration</td>
    </tr>
    <tr id="FLYWAY_GROUP">
        <td>FLYWAY_GROUP</td>
        <td>Whether to group all pending migrations together in the same transaction when applying them (only recommended for databases with support for DDL transactions)</td>
    </tr>
    <tr id="FLYWAY_ENCODING">
        <td>FLYWAY_ENCODING</td>
        <td>The encoding of Sql migrations</td>
    </tr>
    <tr id="FLYWAY_PLACEHOLDER_REPLACEMENT">
        <td>FLYWAY_PLACEHOLDER_REPLACEMENT</td>
        <td>Whether placeholders should be replaced</td>
    </tr>
    <tr id="FLYWAY_PLACEHOLDERS_">
        <td>FLYWAY_PLACEHOLDERS_<i>&lt;NAME&gt;</i></td>
        <td>Placeholders to replace in SQL migrations. For example to replace a placeholder named <code>key1</code>
        with the value <code>value1</code>, you can set the environment variable <code>FLYWAY_PLACEHOLDERS_KEY1</code>
        to <code>value1</code>. Flyway will then convert the <code>KEY1</code> part to lowercase (<code>key1</code>) and look for it, in
        conjunction with the placeholder prefix and suffix, in your SQL migrations. Flyway will then 
        replace any occurances it finds with <code>value1</code>.</td>
    </tr>
    <tr id="FLYWAY_PLACEHOLDER_PREFIX">
        <td>FLYWAY_PLACEHOLDER_PREFIX</td>
        <td>The prefix of every placeholder</td>
    </tr>
    <tr id="FLYWAY_PLACEHOLDER_SUFFIX">
        <td>FLYWAY_PLACEHOLDER_SUFFIX</td>
        <td>The suffix of every placeholder</td>
    </tr>
    <tr id="FLYWAY_RESOLVERS">
        <td>FLYWAY_RESOLVERS</td>
        <td>Comma-separated list of fully qualified class names of custom
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/resolver/MigrationResolver">MigrationResolver</a>
            implementations to be used in addition to the built-in ones for resolving Migrations to apply.</td>
    </tr>
    <tr id="FLYWAY_SKIP_DEFAULT_RESOLVERS">
        <td>FLYWAY_SKIP_DEFAULT_RESOLVERS</td>
        <td>Whether default built-in resolvers (sql, jdbc and spring-jdbc) should be skipped. If true, only custom resolvers are used.</td>
    </tr>
    <tr id="FLYWAY_CALLBACKS">
        <td>FLYWAY_CALLBACKS</td>
        <td>Comma-separated list of fully qualified class names of
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/callback/FlywayCallback">FlywayCallback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr id="FLYWAY_SKIP_DEFAULT_CALLBACKS">
        <td>FLYWAY_SKIP_DEFAULT_CALLBACKS</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    <tr id="FLYWAY_TARGET">
        <td>FLYWAY_TARGET</td>
        <td>The target version up to which Flyway should consider migrations. Migrations with a higher version number will be ignored. The special value <code>current</code> designates the current version of the schema.
        </td>
    </tr>
    <tr id="FLYWAY_OUT_OF_ORDER">
        <td>FLYWAY_OUT_OF_ORDER</td>
        <td>Allows migrations to be run "out of order".
            <p>If you already have versions 1 and 3 applied, and now a version 2 is found,
                it will be applied too instead of being ignored.</p>
        </td>
    </tr>
    <tr id="FLYWAY_VALIDATE_ON_MIGRATE">
        <td>FLYWAY_VALIDATE_ON_MIGRATE</td>
        <td>Whether to automatically call validate or not when running migrate.<br/>
            For each sql migration a CRC32 checksum is calculated
            when the sql script is executed. The validate mechanism checks if the sql migration in the classpath
            still has the same checksum as the sql migration already executed in the database.<br/></td>
    </tr>
    <tr id="FLYWAY_CLEAN_ON_VALIDATION_ERROR">
        <td>FLYWAY_CLEAN_ON_VALIDATION_ERROR</td>
        <td>Whether to automatically call clean or not when a validation error occurs.<br/><br/>
            This is exclusively intended as a convenience for development. Even tough we
            strongly recommend not to change migration scripts once they have been checked into SCM and run, this
            provides a way of dealing with this case in a smooth manner. The database will be wiped clean
            automatically, ensuring that the next migration will bring you back to the state checked into
            SCM.<br/><br/><strong>Warning ! Do not enable in production !</strong>
        </td>
    </tr>
    <tr id="FLYWAY_IGNORE_MISSING_MIGRATIONS">
        <td>FLYWAY_IGNORE_MISSING_MIGRATIONS</td>
        <td>Ignore missing migrations when reading the schema history table. These are migrations that were performed by an
            older deployment of the application that are no longer available in this version. For example: we have migrations
            available on the classpath with versions 1.0 and 3.0. The schema history table indicates that a migration with version 2.0
            (unknown to us) has also been applied. Instead of bombing out (fail fast) with an exception, a
            warning is logged and Flyway continues normally. This is useful for situations where one must be able to deploy
            a newer version of the application even though it doesn't contain migrations included with an older one anymore.
        </td>
    </tr>
    <tr id="FLYWAY_IGNORE_IGNORED_MIGRATIONS">
        <td>FLYWAY_IGNORE_IGNORED_MIGRATIONS</td>
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
    <tr id="FLYWAY_IGNORE_FUTURE_MIGRATIONS">
        <td>FLYWAY_IGNORE_FUTURE_MIGRATIONS</td>
        <td>Ignore future migrations when reading the schema history table. These are migrations that were performed by a
            newer deployment of the application that are not yet available in this version. For example: we have migrations
            available on the classpath up to version 3.0. The schema history table indicates that a migration to version 4.0
            (unknown to us) has already been applied. Instead of bombing out (fail fast) with an exception, a
            warning is logged and Flyway continues normally. This is useful for situations where one must be able to redeploy
            an older version of the application after the database has been migrated by a newer one.</td>
    </tr>
    <tr id="FLYWAY_CLEAN_DISABLED">
        <td>FLYWAY_CLEAN_DISABLED</td>
        <td>Whether to disable clean. This is especially useful for production environments where running clean can be quite a career limiting move.</td>
    </tr>
    <tr id="FLYWAY_BASELINE_ON_MIGRATE">
        <td>FLYWAY_BASELINE_ON_MIGRATE</td>
        <td>Whether to automatically call baseline when migrate is executed against a non-empty schema with no metadata
            table.
            This schema will then be baselined with the <code>baselineVersion</code> before executing the migrations.
            Only migrations above <code>baselineVersion</code> will then be applied.<br/>

            <p>This is useful for initial Flyway production deployments on projects with an existing DB.</p>

            <p>Be careful when enabling this as it removes the safety net that ensures Flyway does not migrate the wrong
                database in case of a configuration mistake!</p>
        </td>
    </tr>
    <tr id="FLYWAY_BASELINE_VERSION">
        <td>FLYWAY_BASELINE_VERSION</td>
        <td>The version to tag an existing schema with when executing baseline</td>
    </tr>
    <tr id="FLYWAY_BASELINE_DESCRIPTION">
        <td>FLYWAY_BASELINE_DESCRIPTION</td>
        <td>The description to tag an existing schema with when executing baseline</td>
    </tr>
    <tr id="FLYWAY_INSTALLED_BY">
        <td>FLYWAY_INSTALLED_BY</td>
        <td>The username that will be recorded in the schema history table as having applied the migration</td>
    </tr>
    <tr id="FLYWAY_ERROR_HANDLERS">
        <td>FLYWAY_ERROR_HANDLERS {% include pro.html %}</td>
        <td>Comma-sparated list of fully qualified class names of <a href="/documentation/errorhandlers">Error Handlers</a>
         for errors and warnings that occur during
         a migration. This can be used to customize Flyway's behavior by for example throwing another runtime exception,
          outputting a warning or suppressing the error instead of throwing a FlywayException. ErrorHandlers are invoked
           in order until one reports to have successfully handled the errors or warnings.
           If none do, or if none are present, Flyway falls back to its default handling of errors and warnings.
           </td>
    </tr>
    <tr id="FLYWAY_DRYRUN_OUTPUT">
        <td>FLYWAY_DRYRUN_OUTPUT {% include pro.html %}</td>
        <td>The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent
            directory, Flyway will create all directories and parent directories as needed.
            Omit to use the default mode of executing the SQL statements directly against the database.</td>
    </tr>
    </tbody>
</table>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/configfiles">Config Files <i class="fa fa-arrow-right"></i></a>
</p>