---
layout: commandLine
pill: overview
subtitle: Command-line
---
# Command-line tool

The Flyway command-line tool is a standalone Flyway distribution. It runs on Windows, macOS and Linux and it is 
primarily meant for users who wish to migrate their database from the command-line without having to integrate Flyway
into their applications nor having to install a build tool.

## Download and installation

Select the platform that you need. Each download contains all editions (community, pro, enterprise) of Flyway.<br/><br/>

#### <i class="fa fa-windows"></i> Windows

<a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-windows-x64.zip">flyway-commandline-{{site.flywayVersion}}-windows-x64.zip</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-windows-x64.zip.md5">md5</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-windows-x64.zip.sha1">sha1</a><br/>

<p class="note"><br/>Extract the archive and simply add the new <code>flyway-{{site.flywayVersion}}</code> directory to the <code>PATH</code> to make the <code>flyway</code> command available from anywhere on your system.</p>

#### <i class="fa fa-apple"></i> macOS

<a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz">flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz.md5">md5</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-macosx-x64.tar.gz.sha1">sha1</a><br/><br/>

#### <i class="fa fa-linux"></i> Linux

Download, extract and install by adding to `PATH` (requires `sudo` permissions):
<pre class="console" style="overflow-x: auto"><span>$</span> wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/<strong>flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz</strong> | tar xvz && sudo ln -s `pwd`/flyway-{{site.flywayVersion}}/flyway /usr/local/bin </pre> 

Or simply download the archive:
 
<a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz">flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz.md5">md5</a>
<a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/{{site.flywayVersion}}/flyway-commandline-{{site.flywayVersion}}-linux-x64.tar.gz.sha1">sha1</a><br/><br/>

#### <img title="Docker" style="height: 12px;margin-top: -4px;" src="/assets/logos/docker.png"> Docker

(Linux only) Download, extract and install by adding to `PATH` (requires `sudo` permissions):

<pre class="console"><span>$</span> sudo sh -c 'echo "docker run --rm <strong>flyway/flyway:{{site.flywayVersion}} $*</strong>" > /usr/local/bin/flyway && chmod +x /usr/local/bin/flyway'</pre>

(All platforms) Or simply download the image:

<pre class="console"><span>&gt;</span> docker pull <strong>flyway/flyway:{{site.flywayVersion}}</strong></pre>

Go to Docker Hub for <a href="https://hub.docker.com/r/flyway/flyway/">detailed usage instructions</a>.

<p class="note">Older versions, packages without JRE and sources are available from <a href="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline">Maven Central</a></p>
<p class="note">Older Docker images are available from <a href="https://hub.docker.com/r/boxfuse/flyway/">boxfuse/flyway</a></p>

## Directory structure

The Flyway download, once extracted, now becomes a directory with the following structure:

<pre class="filetree"><i class="fa fa-folder-open"></i> flyway-{{site.flywayVersion}}
  <i class="fa fa-folder-open"></i> conf
    <span><i class="fa fa-file-text"></i> flyway.conf</span> <i class="fa fa-long-arrow-left"></i> configuration file
  <i class="fa fa-folder"></i> drivers        <i class="fa fa-long-arrow-left" style="margin-left: -3px"></i> JDBC drivers
  <i class="fa fa-folder"></i> jars           <i class="fa fa-long-arrow-left" style="margin-left: -3px"></i> Java-based migrations (as jars)
  <i class="fa fa-folder"></i> jre
  <i class="fa fa-folder"></i> lib
  <i class="fa fa-folder"></i> licenses
  <i class="fa fa-folder"></i> sql            <i class="fa fa-long-arrow-left" style="margin-left: -3px"></i> SQL migrations
  <span><i class="fa fa-file"></i> flyway</span>        <i class="fa fa-long-arrow-left"></i> macOS/Linux executable
  <span><i class="fa fa-file"></i> flyway.cmd</span>    <i class="fa fa-long-arrow-left"></i> Windows executable</pre>

## Usage

<pre class="console"><span>&gt;</span> flyway [options] command</pre>

## Flyway editions

The Flyway Command-line tool distribution ships with all editions of Flyway. It defaults to Flyway Community Edition.
It can however easily be configured to run the [Flyway Pro or Enterprise Edition](/download) instead.  

### Environment variable

One way to switch between the various Flyway editions is to set the `FLYWAY_EDITION` environment variable prior to
executing Flyway to any of the following values:

<table class="table table-striped">
<tr><td><code>community</code></td><td>Select the Flyway Community Edition (default)</td></tr> 
<tr><td><code>pro</code></td><td>Select the Flyway Pro Edition</td></tr> 
<tr><td><code>enterprise</code></td><td>Select the Flyway Enterprise Edition</td></tr> 
</table> 

### Edition-selecting flags

Alternatively Flyway also comes with edition-selecting flags. By default the `flyway` command will launch whatever
edition has been selected with the `FLYWAY_EDITION` environment variable (defaulting to `community`).
You can however also use edition-selecting flags to force the selection of the edition of your choice and avoid the need
to set any environment variable at all:

<table class="table table-striped">
<tr><td><code>-community</code></td><td>Select the Flyway Community Edition</td></tr> 
<tr><td><code>-pro</code></td><td>Select the Flyway Pro Edition</td></tr> 
<tr><td><code>-enterprise</code></td><td>Select the Flyway Enterprise Edition</td></tr> 
</table> 

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
        <td><a href="/documentation/commandline/undo">undo</a> <a href="/download" class="label label-primary" title="Supported by Flyway Pro and Enterprise Edition only">Flyway Pro</a></td>
        <td>Undoes the most recently applied versioned migrations</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/baseline">baseline</a></td>
        <td>Baselines an existing database, excluding all migrations up to and including baselineVersion</td>
    </tr>
    <tr>
        <td><a href="/documentation/commandline/repair">repair</a></td>
        <td>Repairs the schema history table</td>
    </tr>
    </tbody>
</table>

## JDBC drivers

In order to connect with your database, Flyway needs the appropriate JDBC driver to be available in its `drivers` directory.

Flyway ships with JDBC drivers for the following databases by default:
- Aurora MySQL
- Aurora PostgreSQL
- CockroachDB
- Derby
- Firebird
- H2
- HSQLDB
- MariaDB
- MySQL
- Percona XtraDB
- PostgreSQL
- SQLite
- SQL Server
- Sybase ASE

If your database is not listed here, you need to download its JDBC driver and place it in the `drivers` directory
yourself. Instructions on where to download the drivers from are provided on the respective documentation pages for each
database.

## Configuration

The Flyway Command-line tool can be configured in a wide variety of ways. You can use 
config files, environment variables and command-line parameters.
These different means of configuration can be combined at will.

### Config files

[Config files](/documentation/configfiles) are supported by the Flyway command-line tool. If you are not familiar with them,
check out the [Flyway config file structure and settings reference](/documentation/configfiles) first.

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

To make it easier to work with cloud and containerized environments, Flyway also supports configuration via
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

If you need to to pass custom arguments to Flyway's JVM, you can do so by setting the `JAVA_ARGS` environment variable.
They will then automatically be taken into account when launching Flyway. This is particularly useful when needing to set JVM system properties.

## Output

All debug, info and warning output is sent to `stdout`. All errors are sent to `stderr`.

### Colors

The ouput is colorized using ANSI escape codes. Colors are suppressed if `stdout` is not associated with a terminal.

### Debug output

Add `-X` to the argument list to also print debug output.

### Quiet mode

Add `-q` to the argument list to suppress all output, except for errors and warnings.

### Writing to a file

Add `-outputFile=/my/output.txt` to the argument list to also write output to the specified file.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/commandline/migrate">Command-line: migrate <i
            class="fa fa-arrow-right"></i></a>
</p>
