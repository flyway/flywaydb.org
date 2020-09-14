---
layout: documentation
menu: spanner
subtitle: Goodle Cloud Spanner
---
# Google Cloud Spanner

## Supported Versions

- `Latest` {% include teams.html %}

## Drivers

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:cloudspanner:[//<i>host</i>[:<i>port</i>]]/projects/<i>project-id</i>[/instances/<i>instance-id</i>[/databases/<i>database-name</i>]]
</code></td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.google.cloud:google-cloud-spanner-jdbc:1.16.0</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>1.16.0</code> and later</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.google.cloud.spanner.jdbc.JdbcDriver</code></td>
</tr>
</table>

## Google Cloud Spanner Syntax

- [Standard SQL syntax](/documentation/migrations#syntax) with statement delimiter **;**

### Example

<pre class="prettyprint">/* Single line comment */
CREATE TABLE test_user (
  id INT64 NOT NULL,
  name STRING(25) NOT NULL,
) PRIMARY KEY(name);

/*
Multi-line
comment
*/

-- Sql-style comment

-- Placeholder
INSERT INTO ${table_name} (name, id) VALUES ('Mr. Ice T', 1);
</pre>

## Authentication

Flyway supports providing your credentials in a `keyfile.json` file. To use this add the property `credentials=path/to/keyfile.json` to the jdbc url. For more information on credentials, refer to the [Google Cloud Spanner documentation](https://googleapis.dev/ruby/google-cloud-spanner/v1.12.0/file.AUTHENTICATION.html).

## Limitations

- *None*

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/sqlite">SQLite <i class="fa fa-arrow-right"></i></a>
</p>