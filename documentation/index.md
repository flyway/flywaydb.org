---
layout: documentation
menu: overview
title: Documentation
---
# Documentation

<p>Welcome to <strong>Flyway</strong>, database migrations made easy.</p>

<div class="well well-small">
    <strong>Tip:</strong>
    If you haven't checked out the <a href="/getstarted">Get Started</a> section yet, do it now. You'll be up
    and running in no time!
</div>

<p class="center"><img src="/assets/logo/flyway-logo-tm.png" alt="Flyway" usemap="#logomap" style="padding-bottom: 10px"/>
    <map name="logomap">
        <area shape="rect" coords="130,260,370,330" href="https://red-gate.com" alt="Redgate">
    </map>
</p>

<p>Flyway is an open-source database migration tool. It strongly favors simplicity and convention over
    configuration.</p>

<p>It is based around just 7 basic commands:
    <a href="/documentation/command/migrate">Migrate</a>,
    <a href="/documentation/command/clean">Clean</a>,
    <a href="/documentation/command/info">Info</a>,
    <a href="/documentation/command/validate">Validate</a>,
    <a href="/documentation/command/undo">Undo</a>,
    <a href="/documentation/command/baseline">Baseline</a> and
    <a href="/documentation/command/repair">Repair</a>.
</p>

<p>Migrations can be written in <a href="/documentation/migrations#sql-based-migrations">SQL</a>
    (database-specific syntax (such as PL/SQL, T-SQL, ...) is supported)
    or <a href="/documentation/migrations#java-based-migrations">Java</a>
    (for advanced data transformations or dealing with LOBs).</p>

<p>It has a <a href="/documentation/commandline">Command-line client</a>.
    If you are on the JVM, we recommend using the <a href="/documentation/api">Java API</a> (also works on Android)
    for migrating the database on application startup.
    Alternatively, you can also use the <a href="/documentation/maven">Maven plugin</a>
    or <a href="/documentation/gradle">Gradle plugin</a>.</p>

<p>And if that's not enough, there are <a href="/documentation/plugins">plugins</a>
    available for Spring Boot, Dropwizard, Grails, Play, SBT, Ant, Griffon, Grunt, Ninja and more!</p>

<p>Supported databases are
    <a href="/documentation/database/oracle">Oracle</a>,
    <a href="/documentation/database/sqlserver">SQL Server (including Amazon RDS and Azure SQL Database)</a>,
    <a href="/documentation/database/db2">DB2</a>,
    <a href="/documentation/database/mysql">MySQL</a> (including Amazon RDS, Azure Database &amp; Google Cloud SQL),
    <a href="/documentation/database/aurora-mysql">Aurora MySQL</a>,
    <a href="/documentation/database/mariadb">MariaDB</a>,
    <a href="/documentation/database/xtradb">Percona XtraDB Cluster</a>,
    <a href="/documentation/database/postgresql">PostgreSQL</a> (including Amazon RDS, Azure Database, Google Cloud SQL &amp; Heroku),
    <a href="/documentation/database/aurora-postgresql">Aurora PostgreSQL</a>,
    <a href="/documentation/database/redshift">Redshift</a>,
    <a href="/documentation/database/cockroachdb">CockroachDB</a>,
    <a href="/documentation/database/saphana">SAP HANA</a>,
    <a href="/documentation/database/sybasease">Sybase ASE</a>,
    <a href="/documentation/database/informix">Informix</a>,
    <a href="/documentation/database/h2">H2</a>,
    <a href="/documentation/database/hsqldb">HSQLDB</a>,
    <a href="/documentation/database/derby">Derby</a>,
    <a href="/documentation/database/snowflake">Snowflake</a>,
    <a href="/documentation/database/sqlite">SQLite</a> and
    <a href="/documentation/database/firebird">Firebird</a>.</p>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/migrations">Migrations <i class="fa fa-arrow-right"></i></a>
</p>
