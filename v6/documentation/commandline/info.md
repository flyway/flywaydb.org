---
layout: commandLine
pill: info
subtitle: 'Command-line: info'
---
# Command-line: info

Prints the details and status information about all the migrations.

<a href="v6/documentation/command/info"><img src="/assets/balsamiq/command-info.png" alt="info"></a>

## Usage

<pre class="console"><span>&gt;</span> flyway [options] info</pre>

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
        <td><p>Comma-separated list of file name suffixes for SQL migrations.</p>
            <p>SQL migrations have the following file name structure: prefixVERSIONseparatorDESCRIPTIONsuffix ,
                which using the defaults translates to V1_1__My_description.sql</p>
            Multiple suffixes (like .sql,.pkg,.pkb) can be specified for easier compatibility with other tools such as
                editors with specific file associations.</td>
    </tr>
    {% include v6/cfg/validateMigrationNaming.html %}
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
        <td>}
        </td>
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
flyway.skipDefaultResolvers=false
flyway.callbacks=com.mycomp.project.CustomCallback,com.mycomp.project.AnotherCallback
flyway.skipDefaultCallbacks=false
flyway.target=5.1
flyway.outOfOrder=false
flyway.workingDirectory=C:/myProject
```

## Sample output

<pre class="console">&gt; flyway info

Flyway {{ site.flywayVersion }} by Redgate

Database: jdbc:h2:file:flyway.db (H2 1.3)

+------------+---------+----------------+------+---------------------+---------+----------+
| Category   | Version | Description    | Type | Installed on        | State   | Undoable |
+------------+---------+----------------+------+---------------------+---------+----------+
| Versioned  | 1       | First          | SQL  |                     | Pending | Yes      |
| Versioned  | 1.1     | View           | SQL  |                     | Pending | Yes      |
| Versioned  | 1.2     | Populate table | SQL  |                     | Pending | No       |
+------------+---------+----------------+------+---------------------+---------+----------+</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/commandline/validate">Command-line: validate <i class="fa fa-arrow-right"></i></a>
</p>