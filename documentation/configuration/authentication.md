---
layout: documentation
menu: authentication
subtitle: Authentication
---

# Authentication

In order to log in to your database, the typical approach is to set your username and password in the Flyway [configuration file](/documentation/configuration/configfile). This however has some concerns:

- These are stored in plain text - anyone can see your credentials
- Your credentials must be supplied in every configuration file you use
- You may not have access to these credentials, and someone else needs to configure them securely

Flyway comes with additional authentication mechanisms that tackle these concerns.

## Environment Variables

By storing your username and password in environment variables they can be configured once and used across multiple Flyway configurations. They can also be set by someone who has the relevant access.

## Database Specific Authentication

### Oracle
- [Oracle Wallet](/documentation/database/oracle#oracle-wallet)

### SQL Server and Azure Synapse
- [Windows Authentication](/documentation/database/sqlserver#windows-authentication)
- [Azure Active Directory](/documentation/database/sqlserver#azure-active-directory)

### MySQL
- [MySQL Option Files](/LINK_WHEN_RELEASED) {% include teams.html %}

### PostgreSQL
- [SCRAM](/documentation/database/postgresql#scram)
- [pgpass](/documentation/database/postgresql#pgpass) {% include teams.html %}

### Snowflake
- [Key-based Authentication](/documentation/database/snowflake#key-based-authentication)

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/configuration/awsSecretsManager">AWS Secrets Manager<i class="fa fa-arrow-right"></i></a>
</p>
