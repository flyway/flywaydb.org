---
layout: documentation
menu: bigquery-beta
subtitle: GCP BigQuery
---
# Flyway & GCP BigQuery

## Pre-requisites
- Using the Flyway command-line?
  - Download the latest version [here](/download/community)
  - Familiarize yourself with basic Flyway command-line usage by reading the docs [here](/documentation/usage/commandline/)
- Using the Flyway Maven plugin?
  - Include the Flyway GCP BigQuery dependency [here](https://search.maven.org/artifact/org.flywaydb/flyway-gcp-bigquery/7.11.0-beta/jar) in your pom
  - Familiarize yourself with basic Flyway Maven usage by reading the docs [here](/documentation/usage/maven/)

## Installing dependencies
Google BigQuery requires a number of dependencies to be installed manually.

Go to [Google's documentation](https://cloud.google.com/bigquery/docs/reference/odbc-jdbc-drivers#current_jdbc_driver_release_12161020) and download the JDBC driver.

You will get a zip archive with many JARs inside.

If you are using the Flyway command-line, you will need to extract the contents of this archive into the `flyway/drivers/` folder.

If you are using the Flyway Maven plugin, you will need to add the contents of this archive to your classpath.
​
## Configuring Flyway

### JDBC URL
​
This is a JDBC URL that points to your database. You can configure a connection using this sample URL as an example:

`jdbc:bigquery://https://www.googleapis.com/bigquery/v2:443;ProjectId=<project_id>;OAuthType=0;OAuthServiceAcctEmail=<service_account_name>;OAuthPvtKeyPath=<path_to_service_account>;`

We need to fetch three things to complete this URL:
​
- `project_id`
- `service_account_name`
- `path_to_service_account`

`project_id` is the name of your BigQuery project within GCP.

To get `service_account_name` and `path_to_service_account`, you'll need to create a 'service account' for your Flyway connections.

To do this, open `IAM` within GCP project settings. There you can create a service account. Upon creating this, you will be given the `service_account_name` (it will look like `something@projectname.iam.gserviceaccount.com`). Upon creating this you'll have the option to download a keyfile.

The keyfile file needs to be accessible to Flyway, so save it somewhere accessible on your machine. Then configure `path_to_service_account` to point to this file.

You can learn more about service accounts [here](https://cloud.google.com/iam/docs/service-accounts).

Set this URL in the [`url`](/documentation/configuration/parameters/url) property in your Flyway configuration.

## Other configuration

Set the [`schemas`](/documentation/configuration/parameters/schemas) property in your Flyway configuration to the name of a `data set` within your BigQuery project. Set the [`user`](/documentation/configuration/parameters/user) and [`password`](/documentation/configuration/parameters/password) properties to empty in your Flwyay configuration since we're authenticating using the JDBC URL i.e.

```
flyway.schemas=<your data set>
flyway.user=
flyway.password=
```
​
In a Flyway configuration file.

## Testing the setup
​
Once you have set up the above, Flyway should be ready to connect to your BigQuery database. We will show sample output using the Flyway command-line.

On the command-line runing:

```
flyway info
```
​
Will give some brief info (including a possible warning about logging), along with an empty table of migrations:

```
PS C:\GBQ> .\flyway info

...

INFO:
Jun 07, 2021 11:51:13 AM org.flywaydb.commandline.Main info
INFO: +----------+---------+-------------+------+--------------+-------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+----------+---------+-------------+------+--------------+-------+----------+
| No migrations found                                                       |
+----------+---------+-------------+------+--------------+-------+----------+
```
​
If you see this, you are good to go on your BigQuery/Flyway migration journey.

If you see:
```
PS C:\GBQ> .\flyway info
ERROR: Unable to instantiate JDBC driver: com.simba.googlebigquery.jdbc42.Driver => Check whether the jar file is present
Caused by: Unable to instantiate class com.simba.googlebigquery.jdbc42.Driver : com.simba.googlebigquery.jdbc42.Driver
Caused by: java.lang.ClassNotFoundException: com.simba.googlebigquery.jdbc42.Driver
```
​
Then the BigQuery dependencies have not installed or been added to the classpath correctly.
​
## Share Your Feedback

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSep6p4N-okfCVYi7KmJhDbkfQpT6xovVcA0Lxq50BaLzFjaSg/viewform?embedded=true" width="640" height="1869" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>
