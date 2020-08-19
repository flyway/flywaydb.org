---
layout: documentation
menu: envvars
subtitle: Environment Variables
---
# Environment Variables

The Flyway [command-line tool](/documentation/commandline), [Maven plugin](/documentation/maven) and
[Gradle plugin](/documentation/gradle) support loading configuration via environment variables.
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
    <tr id="FLYWAY_EDITION">
        <td>FLYWAY_EDITION</td>
        <td>The edition of Flyway to use. Must be one of <code>community</code>, 
        <code>pro</code> or <code>enterprise</code>. <b>Only applies to the Flyway command-line. This
        option is not settable via configuration files.</b></td>
    </tr>
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
    <tr id="FLYWAY_CONNECT_RETRIES">
        <td>FLYWAY_CONNECT_RETRIES</td>
        <td>The maximum number of retries when attempting to connect to the database. After each failed attempt, Flyway will wait 1 second before attempting to connect again, up to the maximum number of times specified by connectRetries.</td>
    </tr>
    <tr id="FLYWAY_INIT_SQL">
        <td>FLYWAY_INIT_SQL</td>
        <td>The SQL statements to run to initialize a new database connection immediately after opening it.</td>
    </tr>
    <tr id="FLYWAY_DEFAULT_SCHEMA">
            <td>FLYWAY_DEFAULT_SCHEMA</td>
            <td>The default schema managed by Flyway. This schema will be the one containing the schema history table.
            This schema will also be the default for the database connection (provided the database supports this concept).
            <br/>
                If not specified, but FLYWAY_SCHEMAS is, the default schema is the first in that list.
            </td>
        </tr>
    <tr id="FLYWAY_SCHEMAS">
        <td>FLYWAY_SCHEMAS</td>
        <td>Comma-separated case-sensitive list of schemas managed by Flyway. Flyway will attempt to create these
        schemas if they do not already exist, and will clean them in the order of this list. If Flyway created
        them, then the schemas themselves will be dropped when cleaning.<br/>
            <br/>
            If the default schema is not specified, the first is this list also acts as default schema.
        </td>
    </tr>
      <tr id="FLYWAY_CREATE_SCHEMAS">
        <td>FLYWAY_CREATE_SCHEMAS</td>
        <td>Whether Flyway should attempt to create the schemas specified in the schemas property</td>
    </tr>
    <tr id="FLYWAY_TABLE">
        <td>FLYWAY_TABLE</td>
        <td>The name of Flyway's schema history table.<br/>By
            default (single-schema mode) the schema history table is placed in the default schema for the connection
            provided by the datasource.<br/>When the <i>flyway.schemas</i> property is set (multi-schema mode),
            the schema history table is placed in the first schema of the list.
        </td>
    </tr>
    <tr id="FLYWAY_TABLESPACE">
        <td>FLYWAY_TABLESPACE</td>
        <td>The tablespace where to create the schema history table that will be used by Flyway.
            This setting is only relevant for databases that do support the notion of tablespaces. Its value is simply ignored for all others.
        </td>
    </tr>
    <tr id="FLYWAY_LOCATIONS">
        <td>FLYWAY_LOCATIONS</td>
        <td>Comma-separated list of locations to scan recursively for migrations. The location type is determined by its prefix.<br/>
            Unprefixed locations or locations starting with <code>classpath:</code> point to a package on the
            classpath and may contain both SQL and Java-based migrations.<br/>
            Locations starting with <code>filesystem:</code> point to a directory on the filesystem, may only
            contain SQL migrations and are only scanned recursively down non-hidden directories.<br/>
            Locations can contain wildcards. This allows matching against a path pattern instead of a single path. Supported wildcards:<br/>
            <ul>
                <li><code>**</code> : Matches any 0 or more directories. (e.g. <code>db/**/test</code> will match <code>db/version1.0/test</code>, <code>db/version2.0/test</code>, <code>db/development/version/1.0/test</code> but not <code>db/version1.0/release</code>)</li>
                <li><code>*</code> : Matches any 0 or more non-separator characters. (e.g. <code>db/release1.*</code> will match <code>db/release1.0</code>, <code>db/release1.1</code>, <code>db/release1.123</code> but not <code>db/release2.0</code>)</li>
                <li><code>?</code> : Matches any 1 non-separator character. (e.g. <code>db/release1.?</code> will match <code>db/release1.0</code>, <code>db/release1.1</code> but not <code>db/release1.11</code>)</li>
            </ul>
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
    <tr id="FLYWAY_IGNORE_INVALID_MIGRATION_NAMES">
            <td>FLYWAY_IGNORE_INVALID_MIGRATION_NAMES</td>
            <td>Whether to ignore migrations and callbacks whose scripts do not obey the correct naming convention. 
            A failure can be useful to check that errors such as case sensitivity in migration prefixes have been corrected.
            If false, Flyway fails fast with an exception.</td>
        </tr>
    <tr id="FLYWAY_STREAM">
        <td>FLYWAY_STREAM {% include pro.html %}</td>
        <td>Whether to stream SQL migrations when executing them. Streaming doesn't load the entire migration in memory at
            once. Instead each statement is loaded individually. This is particularly useful for very large SQL migrations
            composed of multiple MB or even GB of reference data, as this dramatically reduces Flyway's memory consumption.</td>
    </tr>
    <tr id="FLYWAY_BATCH">
        <td>FLYWAY_BATCH {% include pro.html %}</td>
        <td>Whether to batch SQL statements when executing them. Batching can save up to 99 percent of network roundtrips by
            sending up to 100 statements at once over the network to the database, instead of sending each statement
            individually. This is particularly useful for very large SQL migrations composed of multiple MB or even GB of
            reference data, as this can dramatically reduce the network overhead. This is supported for INSERT, UPDATE,
            DELETE, MERGE and UPSERT statements. All other statements are automatically executed without batching.</td>
    </tr>
    <tr id="FLYWAY_MIXED">
        <td>FLYWAY_MIXED</td>
        <td>Whether to allow mixing transactional and non-transactional statements within the same migration. Enabling this automatically causes the entire affected migration to be run without a transaction. <p>Note that this is only applicable for PostgreSQL, Aurora PostgreSQL, SQL Server and SQLite which all have statements that do not run at all within a transaction.</p><p>This is not to be confused with implicit transaction, as they occur in MySQL or Oracle, where even though a DDL statement was run within within a transaction, the database will issue an implicit commit before and after its execution.</p></td>
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
            <a href="/documentation/api/javadoc/org/flywaydb/core/api/callback/Callback">Callback</a>
            implementations to use to hook into the Flyway lifecycle.</td>
    </tr>
    <tr id="FLYWAY_SKIP_DEFAULT_CALLBACKS">
        <td>FLYWAY_SKIP_DEFAULT_CALLBACKS</td>
        <td>Whether default built-in callbacks (sql) should be skipped. If true, only custom callbacks are used.</td>
    </tr>
    <tr id="FLYWAY_TARGET">
        <td>FLYWAY_TARGET</td>
        <td>The target version up to which Flyway should consider migrations. Migrations with a higher version number will be ignored.<br />
            Special values:
            <ul>
                <li><code>current</code>: designates the current version of the schema</li>
                <li><code>latest</code>: the latest version of the schema, as defined by the migration with the highest version</li>
            </ul>
        </td>
    </tr>
    <tr id="FLYWAY_OUTPUT_QUERY_RESULTS">
        <td>FLYWAY_OUTPUT_QUERY_RESULTS</td>
        <td>
        Controls whether Flyway should output a table with the results of queries when executing migrations. 
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
            This is exclusively intended as a convenience for development. Even though we
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
    <tr id="FLYWAY_IGNORE_PENDING_MIGRATIONS">
        <td>FLYWAY_IGNORE_PENDING_MIGRATIONS</td>
        <td>Ignore pending migrations when reading the schema history table. These are migrations that are available but have not yet been applied. This can be useful for verifying that in-development migration changes don't contain any validation-breaking changes of migrations that have already been applied to a production environment, e.g. as part of a CI/CD process, without failing because of the existence of new migration versions.
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
    <tr id="FLYWAY_ERROR_OVERRIDES">
        <td>FLYWAY_ERROR_OVERRIDES {% include pro.html %}</td>
        <td>Comma-sparated list of rules for the built-in error handler that let you override specific SQL states and errors codes in order to force specific errors or warnings to be treated as debug messages, info messages, warnings or errors.
            <p>Each error override has the following format: <code>STATE:12345:W</code>. It is a 5 character SQL state (or <code>*</code> to match all SQL states), a colon, the SQL error code (or <code>*</code> to match all SQL error codes), a colon and finally the desired behavior that should override the initial one.</p>
            <p>The following behaviors are accepted:</p>
            <ul>
              <li><code>D</code> to force a debug message</li>
              <li><code>D-</code> to force a debug message, but do not show the original sql state and error code</li>
              <li><code>I</code> to force an info message</li>
              <li><code>I-</code> to force an info message, but do not show the original sql state and error code</li>
              <li><code>W</code> to force a warning</li>
              <li><code>W-</code> to force a warning, but do not show the original sql state and error code</li>
              <li><code>E</code> to force an error</li>
              <li><code>E-</code> to force an error, but do not show the original sql state and error code</li>
            </ul>
            <p>Example 1: to force Oracle stored procedure compilation issues to produce errors instead of warnings, the following errorOverride can be used: <code>99999:17110:E</code></p>
            <p>Example 2: to force SQL Server PRINT messages to be displayed as info messages (without SQL state and error code details) instead of warnings, the following errorOverride can be used: <code>S0001:0:I-</code></p>
            <p>Example 3: to force all errors with SQL error code 123 to be treated as warnings instead, the following errorOverride can be used: <code>*:123:W</code></p>
       </td>
    </tr>
    <tr id="FLYWAY_DRYRUN_OUTPUT">
        <td>FLYWAY_DRYRUN_OUTPUT {% include pro.html %}</td>
        <td>The file where to output the SQL statements of a migration dry run. If the file specified is in a non-existent
            directory, Flyway will create all directories and parent directories as needed.
            Omit to use the default mode of executing the SQL statements directly against the database.</td>
    </tr>
    <tr id="FLYWAY_ORACLE_SQLPLUS">
        <td>FLYWAY_ORACLE_SQLPLUS {% include pro.html %}</td>
        <td>Enable Flyway's support for <a href="/documentation/database/oracle#sqlplus-commands">Oracle SQL*Plus commands</a></td>
    </tr>
    <tr id="FLYWAY_ORACLE_SQLPLUS_WARN">
        <td>FLYWAY_ORACLE_SQLPLUS_WARN {% include pro.html %}</td>
        <td>Whether Flyway should issue a warning instead of an error whenever it encounters an Oracle SQL*Plus statement it doesn't yet support.</td>
    </tr>
    <tr id="FLYWAY_LICENSE_KEY">
        <td>FLYWAY_LICENSE_KEY {% include pro.html %}</td>
        <td>Your Flyway license key (FL01...). Not yet a Flyway Pro or Enterprise Edition customer? Request your <a href="" data-toggle="modal" data-target="#flyway-trial-license-modal">Flyway trial license key</a> to try out Flyway Pro and Enterprise Edition features free for 30 days.</td>
    </tr>
    </tbody>
</table>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/ssl">SSL support <i class="fa fa-arrow-right"></i></a>
</p>

{% include trialpopup.html %}