---
layout: documentation
menu: spanner-beta
subtitle: GCP Spanner
---
# Flyway & Google Cloud Spanner

## Pre-requisites
- Latest Flyway command line
  - [Download here](https://flywaydb.org/download/community)
- Teams Edition trial license
  - [Get it here](https://flywaydb.org/download/teams?ref=gcp-spanner-beta)
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

## Configuring Flyway

You must configure a JDBC URL that points to your database. You can configure a connection using this sample URL as an example:

`jdbc:cloudspanner:/projects/<project_name>/instances/<instance_name>/databases/<database_name>?credentials=<path/to/keyfile.json>`

We need to fetch three things to complete this url:
​
- `project_name`
- `instance_name`
- `database_name`
- A path to a `keyfile.json` for authentication

`project_name`, `instance_name`, `database_name` can all be found on the Cloud Spanner web interface. For authentication, we recommend using the 'keyfile'. This requires creating a service account for Cloud Spanner.

To do this, open `IAM` within GCP project settings. There you can create a service account. Upon creating this you'll have the option to download the keyfile.

The authentication file needs to be accessible to Flyway, so save it somewhere accessible on your machine. Then configure `path_to_service_account` to point to this file.

You can learn more about service accounts [here](https://cloud.google.com/iam/docs/service-accounts).

Set this URL in the `flyway.url` in your configuration file.
​
## Other configuration

Set `flyway.user` and `flyway.password` to empty in your configuration file since we're authenticating using the JDBC URL i.e.

```
flyway.user=
flyway.password=
```

## Testing the setup
​
Once you have set up the above, Flyway should be ready to connect to your Spanner database. To test this, run `flyway info` to ensure communications works as expected.

On the command line run:

```
flyway -teams info
```
​
Flyway will give some brief info (including a possible warning about logging), along with an empty table of migrations:

```
PS C:\flyway> .\flyway -teams info
...
+----------+---------+-------------+------+--------------+-------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+----------+---------+-------------+------+--------------+-------+----------+
| No migrations found                                                       |
+----------+---------+-------------+------+--------------+-------+----------+
```

​
If you attempt to run without Flyway Teams set up, you will see something along the lines of:

```
PS C:\flyway> .\flyway info
Jun 07, 2021 11:47:37 AM org.flywaydb.commandline.Main error
SEVERE: Missing license key. Ensure flyway.licenseKey is set to a valid Flyway license key ("FL01" followed by 512 hex chars)
```

This lets you know that you need a Flyway Teams license. Ensure you're signed up to the free trial [here](https://flywaydb.org/download/teams?ref=gcp-spanner-beta), and that you have the `-teams` flag in the command line prompt.
