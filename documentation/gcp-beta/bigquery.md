---
layout: documentation
menu: bigquery-beta
subtitle: GCP BigQuery
---
# Flyway & GCP BigQuery

## Pre-requisites
- Latest Flyway command line
  - [Download here](https://flywaydb.org/download/community)
- Teams Edition trial license
  - [Get it here](https://flywaydb.org/download/teams?ref=gcp-bigquery-beta)
- Ensure the `FLYWAY_GOOGLE_CLOUD_PLATFORM_BETA` environment variable is set to `true`

Familiarize yourself with basic Flyway command line by reading the docs, [here](https://flywaydb.org/documentation/usage/commandline/).

Ensure you're using the Flyway Teams edition by supplying your license key in the configuration, and calling `flyway` with the `-teams` flag in the command line.

If you aren't a Flyway Teams customer, you can get a free trial [here](https://flywaydb.org/download/teams).

**`flyway.conf`**
```
flyway.licenseKey=FL01...
```

**Command line**
```
flyway -teams
```

## Installing dependencies
Google BigQuery requires a number of dependencies to be installed manually.

Go to [Google's documentation](https://cloud.google.com/bigquery/docs/reference/odbc-jdbc-drivers#current_jdbc_driver_release_12161020) and download the JDBC driver.

You will get a zip archive with many JARs inside. Extract the contents to the `flyway/drivers/` folder.
​
## Configuring Flyway
​
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

​Set this URL in the `flyway.url` in your configuration file.

## Other configuration

Set `flyway.schemas` to the name of a `data set` within your BigQuery project.

Set `flyway.user` and `flyway.password` to empty in your configuration file since we're authenticating using the JDBC URL i.e.

```
flyway.schemas=<your data set>
flyway.user=
flyway.password=
```
​
## Testing the setup
​
Once you have set up the above, Flyway should be ready to connect to your BigQuery database. To test this, run `flyway info` to ensure communications works as expected.

On the command line run:

```
flyway -teams info
```
​
Flyway will give some brief info (including a possible warning about logging), along with an empty table of migrations:

```
PS C:\GBQ> .\flyway -teams info
Jun 07, 2021 11:50:59 AM org.flywaydb.core.internal.license.VersionPrinter info
INFO: Flyway Teams Edition (unlimited schemas) 0-SNAPSHOT by Redgate licensed to Red Gate Software until 2029-08-01
Jun 07, 2021 11:51:00 AM org.flywaydb.core.internal.license.VersionPrinter info
INFO: > GCP Spanner/BigQuery database support (beta) 0-SNAPSHOT by Redgate
SLF4J: Failed to load class "org.slf4j.impl.StaticLoggerBinder".
SLF4J: Defaulting to no-operation (NOP) logger implementation
SLF4J: See http://www.slf4j.org/codes.html#StaticLoggerBinder for further details.
Jun 07, 2021 11:51:03 AM org.flywaydb.core.internal.database.base.BaseDatabaseType info
INFO: Database: jdbc:bigquery://rgbsync.iam.gserviceaccount.com;OAuthPvtKeyPath=rgbsync-e4ba7d14e486.json; (Google BigQuery 2.0)
Jun 07, 2021 11:51:12 AM org.flywaydb.commandline.Main info
INFO: Schema version: << Empty Schema >>
Jun 07, 2021 11:51:12 AM org.flywaydb.commandline.Main info
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
​
If you see:
```
PS C:\GBQ> .\flyway info
ERROR: Unable to instantiate JDBC driver: com.simba.googlebigquery.jdbc42.Driver => Check whether the jar file is present
Caused by: Unable to instantiate class com.simba.googlebigquery.jdbc42.Driver : com.simba.googlebigquery.jdbc42.Driver
Caused by: java.lang.ClassNotFoundException: com.simba.googlebigquery.jdbc42.Driver
```
​
Then the BigQuery dependencies have not installed correctly.
​
If you attempt to run without Flyway Teams set up, you will see something along the lines of:
```
PS C:\GBQ> .\flyway info
Jun 07, 2021 11:47:37 AM org.flywaydb.commandline.Main error
SEVERE: Missing license key. Ensure flyway.licenseKey is set to a valid Flyway license key ("FL01" followed by 512 hex chars)
```

This lets you know that you need a Flyway Teams license. Ensure you're signed up to the free trial [here](https://flywaydb.org/download/teams?ref=gcp-bigquery-beta), and that you have the `-teams` flag in the command line prompt.
