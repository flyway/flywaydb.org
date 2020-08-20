---
layout: documentation
menu: aswSecretsManager
subtitle: AWS Secrets Manager support
---
# AWS Secrets Manager support

A problem that organizations often encounter is where to store the credentials for connecting to the database. 
[AWS Secrets Manager](https://aws.amazon.com/secrets-manager) offers a solution to the problem.
Secrets can be stored in the manager (such as username and password), and then accessed via an id by only authorized users. This keeps sensitive credentials out of SCM.

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
Secrets manager support is currently provided by the library [AWS Secrets Manager JDBC Library](https://github.com/aws/aws-secretsmanager-jdbc) for the following databases:
- MariaDB
- MySQL
- Oracle
- PostgreSQL
- SQL Server

## Configuring flyway
To make Flyway pull credentials from the Secrets Manager, you need to perform the following steps:
- Ensure the AWS CLI is installed and configured to be able to access the Secrets Manager.
- Add the driver to your project dependencies, or add it to the drivers folder if using the CLI.
- If you've specified the driver class manually using `flyway.driver` then remove this configuration property.
- Modify your connection URL to replace `jdbc:` with `jdbc-secretsmanager:`. 
  - e.g. `jdbc:mariadb://localhost:1234/example_db` -> `jdbc-secretsmanager:mariadb://localhost:1234/example_db`
- Change the `flyway.user` configuration property to contain the secret id.
- Remove the `flyway.password` configuration property.

Now you can run `migrate`, `info`, etc and the credentials will be pulled out of the Secrets manager.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/placeholders">Placeholders <i class="fa fa-arrow-right"></i></a>
</p>

{% include trialpopup.html %}
