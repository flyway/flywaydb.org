---
layout: documentation
menu: spanner-beta
subtitle: GCP Spanner
---
# Flyway & Google Cloud Spanner

## Pre-requisites
- Using the Flyway command-line?
  - Download the latest version [here](/download/community)
  - Familiarize yourself with basic Flyway command-line usage by reading the docs [here](/documentation/usage/commandline/)
- Using the Flyway Maven plugin?
  - Include the Flyway GCP Spanner dependency [here](https://search.maven.org/artifact/org.flywaydb/flyway-gcp-spanner/7.11.0-beta/jar) in your pom
  - Familiarize yourself with basic Flyway Maven usage by reading the docs [here](/documentation/usage/maven/)

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

Set this URL in the [`url`](/documentation/configuration/parameters/url) property in your Flyway configuration.
​
## Other configuration

Set the [`user`](/documentation/configuration/parameters/user) and [`password`](/documentation/configuration/parameters/password) properties to empty in your Flyway configuration since we're authenticating using the JDBC URL i.e.

```
flyway.user=
flyway.password=
```

In a Flyway configuration file.

## Testing the setup
​
Once you have set up the above, Flyway should be ready to connect to your Spanner database. We will show sample output using the Flyway command-line.

On the command-line running:

```
flyway info
```
​
Will give some brief info (including a possible warning about logging), along with an empty table of migrations:

```
PS C:\flyway> .\flyway info

...

+----------+---------+-------------+------+--------------+-------+----------+
| Category | Version | Description | Type | Installed On | State | Undoable |
+----------+---------+-------------+------+--------------+-------+----------+
| No migrations found                                                       |
+----------+---------+-------------+------+--------------+-------+----------+
```

## Share Your Feedback

<iframe src="https://docs.google.com/forms/d/e/1FAIpQLSep6p4N-okfCVYi7KmJhDbkfQpT6xovVcA0Lxq50BaLzFjaSg/viewform?embedded=true" width="640" height="1869" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>
