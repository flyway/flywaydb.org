---
layout: documentation
menu: spanner-beta
subtitle: GCP Spanner
---
# Flyway & Google Cloud Spanner

## Pre-requisites
- Latest Flyway command line
  - [Download here](https://flywaydb.org/download/community)

Familiarize yourself with basic Flyway command line by reading the docs [here](https://flywaydb.org/documentation/usage/commandline/).

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
flyway info
```
​
Flyway will give some brief info (including a possible warning about logging), along with an empty table of migrations:

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
