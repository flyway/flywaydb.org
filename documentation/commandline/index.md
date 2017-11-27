---
layout: commandLine
pill: overview
subtitle: Command-line
---
# Command-line tool

The Flyway command-line tool is a standalone Flyway distribution. It runs on Windows, macOS and Linux and it is 
primarily meant for users who wish to migrate their database from the command-line without having to integrate Flyway
into their applications nor having to install a build tool.

## Download

<table class="table">
<tr><td><i class="fa fa-windows"></i> Windows</td><td><a class="btn btn-primary btn-download" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-windows-x64.zip"><i class="fa fa-download"></i> flyway-commandline-{{site.flywayVersion}}-windows-x64.zip</a></td></tr>
<tr><td><i class="fa fa-apple"></i> macOS</td><td><p><a class="btn btn-primary btn-download" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz"><i class="fa fa-download"></i> flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz</a></p>
<p>or for Homebrew users:</p>
<pre class="console"><span>$</span> brew install flyway</pre>
</td></tr>
<tr><td><i class="fa fa-linux"></i> Linux</td><td><a class="btn btn-primary btn-download" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz"><i class="fa fa-download"></i> flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz</a></td></tr>
<tr><td>All platforms</td><td>            <a href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}.zip">flyway-commandline-{{site.flywayVersion}}.zip
                                              (requires at Java 8 JRE)</a><br/>
                                          <a href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}.tar.gz">flyway-commandline-{{site.flywayVersion}}.tar.gz
                                              (requires at Java 8 without JRE)</a>
<tr><td>Sources</td><td><a href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-sources.jar">flyway-commandline-{{site.flywayVersion}}-sources.jar</a></td></tr>
</td></tr>
</table>

## Installation

Download the Flyway Command-line distribution for your platform and extract it.

The newly extracted directory contains the following structure:

![directory structure](/assets/balsamiq/CommandLineDirectoryStructure.png)

Now simply add it to the `PATH` and the `flyway` command will be available from anywhere on your system.

## Usage

<pre class="console"><span>&gt;</span> flyway [options] command</pre>

## Commands

<table class="table table-bordered table-hover">
    <thead>
    <tr>
        <th>Name</th>
        <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><a href="/documentation/commandline/migrate">migrate</a></td>
        <td>Migrates the database</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/clean">clean</a></td>
        <td>Drops all objects in the configured schemas</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/info">info</a></td>
        <td>Prints the details and status information about all the migrations</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/validate">validate</a></td>
        <td>Validates the applied migrations against the ones available on the classpath</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/baseline">baseline</a></td>
        <td>Baselines an existing database, excluding all migrations up to and including baselineVersion</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/repair">repair</a></td>
        <td>Repairs the metadata table</td>
    </tr>
    </tbody>
</table>

## JDBC drivers

In order to connect with your database, Flyway needs the appropriate JDBC driver to be available in its `drivers` directory.

Flyway ships with JDBC drivers for the following databases by default:
- SQL Server
- MySQL
- MariaDB
- PostgreSQL
- Sybase ASE
- H2
- HSQLDB
- Derby
- SQLite

If your database is not listed here, you need to download its JDBC driver and place it in the `drivers` directory yourself.

## Configuration

The Flyway Command-line tool can be configured in a wide variety of ways. You can use 
config files, environment variables and command-line parameters.
These different means of configuration can be combined at will.

### Config files

[Config files](/documentaion/configfiles) are supported by the Flyway command-line tool. If you are not familiar with them,
check out the [Flyway config file structure and settings reference](/documentaion/configfiles) first.

Flyway will search for and automatically load the following config files if present:
- `<install-dir>/conf/flyway.conf`
- `<user-home>/flyway.conf`
- `<current-dir>/flyway.conf`

It is also possible to point Flyway at one or more additional config files. This is achieved by
supplying the command line parameter `-configFiles=` as follows:

<pre class="console"><span>&gt;</span> flyway <strong>-configFiles=</strong>path/to/myAlternativeConfig.conf migrate</pre>

To pass in multiple files, separate their names with commas:

<pre class="console"><span>&gt;</span> flyway <strong>-configFiles</strong>=path/to/myAlternativeConfig.conf,other.conf migrate</pre>

Relative paths are relative to the current working directory. 

Alternatively you can also use the `FLYWAY_CONFIG_FILES` environment variable for this.
When set it will take preference over the command-line parameter.

<pre class="console"><span>&gt;</span> export <strong>FLYWAY_CONFIG_FILES</strong>=path/to/myAlternativeConfig.conf,other.conf
<span>&gt;</span> flyway migrate</pre>

By default Flyway loads configuration files using UTF-8. To use an alternative encoding, use the command line parameter <code>-configFileEncoding=</code>
    as follows:
<pre class="console"><span>&gt;</span> flyway <strong>-configFileEncoding=</strong>ISO-8859-1 migrate</pre>

Alternatively you can also use the `FLYWAY_CONFIG_FILE_ENCODING` environment variable for this.
    When set it will take preference over the command-line parameter.

<pre class="console"><span>&gt;</span> export <strong>FLYWAY_CONFIG_FILE_ENCODING</strong>=ISO-8859-1</pre>

### Environment Variables

To make it ease to work with cloud and containerized environments, Flyway also supports configuration via
[environment variables](/documentation/envvars). Check out the [Flyway environment variable reference](/documentation/envvars) for details.

### Command-line Arguments

Finally, Flyway can also be configured by passing arguments directly from the command-line:

<pre class="console"><span>&gt;</span> flyway -user=myuser -schemas=schema1,schema2 -placeholders.keyABC=valueXYZ migrate</pre>

### Overriding order

The Flyway command-line tool has been carefully designed to load and override configuration in a sensible order.

Settings are loaded in the following order (higher items in the list take precedence over lower ones):
1. Command-line arguments
2. Environment variables
3. Custom config files
4. `<current-dir>/flyway.conf`
5. `<user-home>/flyway.conf`
6. `<install-dir>/conf/flyway.conf`
7. Flyway command-line defaults

The means that if for example `flyway.url` is both present in a config file and passed as `-url=` from the command-line,
the command-line argument will take precedence and be used.  

### Credentials

If you do not supply a database `user` or `password` via any of the means above, you will be prompted to enter them:
<pre class="console">Database user: myuser
Database password:</pre>

If you want Flyway to connect to your database without a user or password, you can suppress prompting by adding
    the `-n` flag.

### Java Arguments

If need to to pass custom arguments to Flyway's JVM, you can do so by setting the `JAVA_ARGS` environment variable.
They will then automatically be taken into account when launching Flyway. This is particularly useful when needing to set JVM system properties.

## Output

All debug, info and warning output is sent to `stdout`. All errors are sent to `stderr`.

### Debug output

Add `-X` to the argument list to also print debug output.

### Quiet mode

Add `-q` to the argument list to suppress all output, except for errors and warnings.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/migrate">Command-line: migrate <i
            class="fa fa-arrow-right"></i></a>
</p>