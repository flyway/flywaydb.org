---
layout: documentation
menu: aswSecretsManager
subtitle: AWS Secrets Manager support
---
# AWS Secrets Manager support
{% include teams.html %}

A problem that organizations often encounter is where to store the credentials for connecting to the database. 
[AWS Secrets Manager](https://aws.amazon.com/secrets-manager) offers a solution to the problem.
Secrets such as usernames and passwords can be stored in the Secrets Manager, and then be accessed via an id 
known to authorized users. This keeps sensitive credentials out of application configuration.

## Driver
<table class="table">
<tr>
<th>Ships with Flyway Command-line</th>
<td>No</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>com.amazonaws.secretsmanager:aws-secretsmanager-jdbc:1.0.5</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>1.0.5</code> and later</td>
</tr>
</table>

## Supported databases
Secrets Manager support is currently provided by the [AWS Secrets Manager JDBC Library](https://github.com/aws/aws-secretsmanager-jdbc) for the following databases:
- MariaDB
- MySQL
- Oracle
- PostgreSQL
- SQL Server

## Configuring Flyway
To make Flyway pull credentials from the Secrets Manager, you need to perform the following steps:
- Ensure the AWS CLI is installed and configured to be able to access the Secrets Manager.
- Add the driver to your project dependencies, or add it to the drivers folder if using the CLI.
- If you've specified the driver class manually using `flyway.driver` then remove this configuration property.
- Modify your connection URL to replace `jdbc:` with `jdbc-secretsmanager:`. 
  - e.g. `jdbc:mariadb://localhost:1234/example_db` -> `jdbc-secretsmanager:mariadb://localhost:1234/example_db`
- Change the `flyway.user` configuration property to contain the secret id.
- Remove the `flyway.password` configuration property.

Now you can run `migrate`, `info`, etc and the credentials will be pulled out of the Secrets Manager.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/configuration/placeholders">Placeholders <i class="fa fa-arrow-right"></i></a>
</p>

{% include trialpopup.html %}
