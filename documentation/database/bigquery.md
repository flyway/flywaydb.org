---
layout: documentation
menu: bigquery
subtitle: BigQuery
---
# BigQuery

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

## Using Flyway with BigQuery

Google BigQuery is in the process of being certified. The process of certification involves getting real world usage feedback from beta users. 

<strong>If you'd like to use BigQuery and you are happy to provide feedback as we build support for this database, please complete the form below:</strong> 

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSeeB1dMrvGApG-UWmRSMQjW0MkZe9dlurI3zy8bbvk6O61Q2Q/viewform?embedded=true" width="520" height="1000" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>


