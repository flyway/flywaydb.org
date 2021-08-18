---
layout: documentation
menu: big-query
subtitle: Google BigQuery
---
# Google BigQuery

## Supported Versions

- `Latest`

## Support Level

<table class="table">
    <tr>
        <th width="25%">Compatible</th>
        <td>✅</td>
    </tr>
    <tr>
        <th width="25%">Certified</th>
        <td>⏳ Pending certification</td>
    </tr>
    <tr>
        <th width="25%">Guaranteed</th>
        <td>❌</td>
    </tr>
</table>

Support Level determines the degree of support available for this database ([learn more](/documentation/learnmore/database-support)).

## Driver

<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:bigquery://https://www.googleapis.com/bigquery/v2:443;ProjectId=<i>project_id</i>;OAuthType=0;OAuthServiceAcctEmail=<i>service_account_name</i>;OAuthPvtKeyPath=<i>path_to_key</i>;</code></td>
</tr>
<tr>
<th>SSL support</th>
<td>No</td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td>None. The Simba driver is available for download <a href="https://cloud.google.com/bigquery/docs/reference/odbc-jdbc-drivers" target="_blank">here</a></td>
</tr>
<tr>
<th>Supported versions</th>
<td>-</td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>com.simba.googlebigquery.jdbc42.Driver</code></td>
</tr>
</table>

## Flyway Teams Features for BigQuery

GCP BigQuery can suffer from performance issues while executing schema changes. 

Flyway Teams edition solves this via [batching](/documentation/configuration/parameters/batch) which combines schema changes to reduce the network overhead and improves performance.

To find out more about Flyway Teams click [here](/try-flyway-teams-edition/?ref=big-query-batch).

## Using Flyway with Google BigQuery

Google BigQuery is in the process of being certified. The process of certification involves getting real world usage feedback from beta users. 

**If you'd like to use Google BigQuery and you are happy to provide feedback as we build support for this database, please complete the form below  to get access to the getting started documentation**

## Limitations

While the Simba JDBC driver supports a number of [different modes](https://simba.wpengine.com/products/BigQuery/doc/JDBC_InstallGuide/content/jdbc/bq/authenticating/useraccount.htm)
for authentication, Google User Account authentication (that is, `OAuthType=1`) is not recommended for desktop
use and is not supported at all for unattended use, or use in Docker, as it requires a browser to be available to
get an access token interactively.

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSeeB1dMrvGApG-UWmRSMQjW0MkZe9dlurI3zy8bbvk6O61Q2Q/viewform?embedded=true" width="520" height="1000" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>
