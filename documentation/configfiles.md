---
layout: documentation
menu: configfiles
subtitle: Config Files
---
# Config Files

Flyway optionally supports loading configuration via config files.

## Structure

Config files have the following structure:

<pre class="prettyprint"># Settings are simple key-value pairs
flyway.key=value
# Single line comment start with a hash

# These are some example settings
flyway.url=jdbc:mydb://mydatabaseurl
flyway.schemas=schema1,schema2
flyway.placeholders.keyABC=valueXYZ</pre>

## Reference

These are the settings supported via config files:

<pre class="prettyprint"># Jdbc url to use to connect to the database
# Examples
# --------
# Most drivers are included out of the box.
# * = driver must be downloaded and installed in /drivers manually
# CockroachDB       : jdbc:postgresql://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;?&lt;key1&gt;=&lt;value1&gt;&&lt;key2&gt;=&lt;value2&gt;...
# DB2*              : jdbc:db2://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;
# Derby             : jdbc:derby:&lt;subsubprotocol:&gt;&lt;databaseName&gt;&lt;;attribute=value&gt;
# H2                : jdbc:h2:&lt;file&gt;
# Hsql              : jdbc:hsqldb:file:&lt;file&gt;
# Google Cloud SQL* : jdbc:google:mysql://&lt;project-id&gt;:&lt;instance-name&gt;/&lt;database&gt;
# MariaDB           : jdbc:mariadb://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;?&lt;key1&gt;=&lt;value1&gt;&&lt;key2&gt;=&lt;value2&gt;...
# MySQL             : jdbc:mysql://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;?&lt;key1&gt;=&lt;value1&gt;&&lt;key2&gt;=&lt;value2&gt;...
# Oracle*           : jdbc:oracle:thin:@//&lt;host&gt;:&lt;port&gt;/&lt;service&gt;
# Phoenix*          : jdbc:phoenix:&lt;host&gt;
# PostgreSQL        : jdbc:postgresql://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;?&lt;key1&gt;=&lt;value1&gt;&&lt;key2&gt;=&lt;value2&gt;...
# SQL Azure*        : jdbc:sqlserver://&lt;servername&gt;.database.windows.net;databaseName=&lt;database&gt;
# SQL Server        : jdbc:jtds:sqlserver://&lt;host&gt;:&lt;port&gt;/&lt;database&gt;
# SQLite            : jdbc:sqlite:&lt;database&gt;
flyway.url=

# Fully qualified classname of the jdbc driver (autodetected by default based on flyway.url)
# flyway.driver=

# User to use to connect to the database. Flyway will prompt you to enter it if not specified.
# flyway.user=

# Password to use to connect to the database. Flyway will prompt you to enter it if not specified.
# flyway.password=

# Comma-separated list of schemas managed by Flyway. These schema names are case-sensitive.
# (default: The default schema for the datasource connection)
# Consequences:
# - The first schema in the list will be automatically set as the default one during the migration.
# - The first schema in the list will also be the one containing the schema history table.
# - The schemas will be cleaned in the order of this list.
# flyway.schemas=

# Name of Flyway's schema history table (default: flyway_schema_history)
# By default (single-schema mode) the schema history table is placed in the default schema for the connection provided by the datasource.
# When the flyway.schemas property is set (multi-schema mode), the schema history table is placed in the first schema of the list.
# flyway.table=

# Comma-separated list of locations to scan recursively for migrations. (default: filesystem:&lt;&lt;INSTALL-DIR&gt;&gt;/sql)
# The location type is determined by its prefix.
# Unprefixed locations or locations starting with classpath: point to a package on the classpath and may contain both sql and java-based migrations.
# Locations starting with filesystem: point to a directory on the filesystem and may only contain sql migrations.
# flyway.locations=

# Comma-separated list of fully qualified class names of custom MigrationResolver to use for resolving migrations.
# flyway.resolvers=

# If set to true, default built-in resolvers (jdbc, spring-jdbc and sql) are skipped and only custom resolvers as
# defined by 'flyway.resolvers' are used. (default: false)
# flyway.skipDefaultResolvers=

# Comma-separated list of directories containing JDBC drivers and Java-based migrations. (default: &lt;INSTALL-DIR&gt;/jars)
# flyway.jarDirs=

# File name prefix for sql migrations (default: V )
# Sql migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
# which using the defaults translates to V1_1__My_description.sql
# flyway.sqlMigrationPrefix=

# File name prefix for repeatable sql migrations (default: R )
# Repeatable sql migrations have the following file name structure: prefixSeparatorDESCRIPTIONsuffix ,
# which using the defaults translates to R__My_description.sql
# flyway.repeatableSqlMigrationPrefix=

# File name separator for Sql migrations (default: __)
# Sql migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
# which using the defaults translates to V1_1__My_description.sql
# flyway.sqlMigrationSeparator=

# File name suffix for Sql migrations (default: .sql)
# Sql migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
# which using the defaults translates to V1_1__My_description.sql
# flyway.sqlMigrationSuffix=

# Encoding of Sql migrations (default: UTF-8)
# flyway.encoding=

# Whether placeholders should be replaced. (default: true)
# flyway.placeholderReplacement=

# Placeholders to replace in Sql migrations
# flyway.placeholders.user=
# flyway.placeholders.my_other_placeholder=

# Prefix of every placeholder (default: ${ )
# flyway.placeholderPrefix=

# Suffix of every placeholder (default: } )
# flyway.placeholderSuffix=

# Target version up to which Flyway should consider migrations.
# The special value 'current' designates the current version of the schema. (default: &lt;&lt;latest version&gt;&gt;)
# flyway.target=

# Whether to automatically call validate or not when running migrate. (default: true)
# flyway.validateOnMigrate=

# Whether to automatically call clean or not when a validation error occurs. (default: false)
# This is exclusively intended as a convenience for development. Even tough we
# strongly recommend not to change migration scripts once they have been checked into SCM and run, this provides a
# way of dealing with this case in a smooth manner. The database will be wiped clean automatically, ensuring that
# the next migration will bring you back to the state checked into SCM.
# Warning ! Do not enable in production !
# flyway.cleanOnValidationError=

# Whether to disabled clean. (default: false)
# This is especially useful for production environments where running clean can be quite a career limiting move.
# flyway.cleanDisabled=

# The version to tag an existing schema with when executing baseline. (default: 1)
# flyway.baselineVersion=

# The description to tag an existing schema with when executing baseline. (default: &lt;&lt; Flyway Baseline &gt;&gt;)
# flyway.baselineDescription=

# Whether to automatically call baseline when migrate is executed against a non-empty schema with no schema history table.
# This schema will then be initialized with the baselineVersion before executing the migrations.
# Only migrations above baselineVersion will then be applied.
# This is useful for initial Flyway production deployments on projects with an existing DB.
# Be careful when enabling this as it removes the safety net that ensures
# Flyway does not migrate the wrong database in case of a configuration mistake! (default: false)
# flyway.baselineOnMigrate=

# Allows migrations to be run "out of order" (default: false).
# If you already have versions 1 and 3 applied, and now a version 2 is found,
# it will be applied too instead of being ignored.
# flyway.outOfOrder=

# This allows you to tie in custom code and logic to the Flyway lifecycle notifications (default: empty).
# Set this to a comma-separated list of fully qualified FlywayCallback class name implementations
# flyway.callbacks=

# If set to true, default built-in callbacks (sql) are skipped and only custom callback as
# defined by 'flyway.callbacks' are used. (default: false)
# flyway.skipDefaultCallbacks=

# Ignore missing migrations when reading the schema history table. These are migrations that were performed by an
# older deployment of the application that are no longer available in this version. For example: we have migrations
# available on the classpath with versions 1.0 and 3.0. The schema history table indicates that a migration with version 2.0
# (unknown to us) has also been applied. Instead of bombing out (fail fast) with an exception, a
# warning is logged and Flyway continues normally. This is useful for situations where one must be able to deploy
# a newer version of the application even though it doesn't contain migrations included with an older one anymore.
# Note that if the most recently applied migration is removed, Flyway has no way to know it is missing and will 
# mark it as future instead.
# true to continue normally and log a warning, false to fail fast with an exception.
# flyway.ignoreMissingMigrations=

# Ignore future migrations when reading the schema history table. These are migrations that were performed by a
# newer deployment of the application that are not yet available in this version. For example: we have migrations
# available on the classpath up to version 3.0. The schema history table indicates that a migration to version 4.0
# (unknown to us) has already been applied. Instead of bombing out (fail fast) with an exception, a
# warning is logged and Flyway continues normally. This is useful for situations where one must be able to redeploy
# an older version of the application after the database has been migrated by a newer one.
# true to continue normally and log a warning, false to fail fast with an exception. (default: true)
# flyway.ignoreFutureMigrations=

# Whether to allow mixing transactional and non-transactional statements within the same migration.
# true if mixed migrations should be allowed. false if an error should be thrown instead. (default: false)
# flyway.mixed=

# Whether to group all pending migrations together in the same transaction when applying them (only recommended for databases with support for DDL transactions).
# true if migrations should be grouped. false if they should be applied individually instead. (default: false)
# flyway.group=

# The username that will be recorded in the schema history table as having applied the migration.
# &lt;&lt;blank&gt;&gt; for the current database user of the connection. (default: &lt;&lt;blank&gt;&gt;).
# flyway.installedBy=

# Comma-separated list of the fully qualified calss names of handlers for errors and warnings that occur during a
# migration. This can be used to customize Flyway's behavior by for example
# throwing another runtime exception, outputting a warning or suppressing the error instead of throwing a FlywayException.
# ErrorHandlers are invoked in order until one reports to have successfully handled the errors or warnings.
# If none do, or if none are present, Flyway falls back to its default handling of errors and warnings.
# &lt;&lt;blank&gt;&gt; to use the default internal handler (default: <<blank>>)
# Flyway Pro and Flyway Enterprise only
# flyway.errorHandlers=</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/articles">Articles <i class="fa fa-arrow-right"></i></a>
</p>