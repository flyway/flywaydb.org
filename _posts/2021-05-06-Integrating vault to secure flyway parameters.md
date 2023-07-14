_Originally posted 6th May 2021 by Ajay Ahir on flywaydb.org_

Until now the only way to configure Flyway has been through plaintext configuration parameters such as in a Flyway configuration file, through the command-line or by setting environment variables.

As your organizations and enterprises grow and more people interact with your processes you'll inevitably want a way to secure as much information as possible, such as your database credentials or your Flyway license key.

_**How can we securely distribute our Flyway license key to subcontractors, for a limited duration?**_ This is an example of a scenario that is becoming increasingly common, and Flyway now offers a solution.

[Flyway Teams edition](https://www.red-gate.com/products/flyway/teams/) comes with HashiCorp Vault integration, allowing you to configure Flyway securely. In this blog we'll answer the question highlighted above with examples that show how to configure Flyway to securely access a license key and other sensitive data using Vault, as well as how Vault can be used to limit this access to a specified duration.

What is Vault?
--------------

HashiCorp Vault is a secrets management solution, allowing you to securely store and provide access to sensitive information. You can learn more about it [here](https://www.vaultproject.io/).

Flyway integrates with Vault's [key-value secret store](https://www.vaultproject.io/docs/secrets/kv), letting you securely store and provide access to any confidential Flyway parameters for any specified duration!

Configuring Flyway to access Vault
----------------------------------

There are three new parameters to configure in Flyway in order to set up the Vault integration:

*   `vault.url`
*   `vault.token`
*   `vault.secrets`

You can find a brief overview of these with an example of Hashicorp vault [here](https://documentation.red-gate.com/fd/secrets-management-184127477.html).

### vault.url

This is the REST API URL of your Vault server, and should include the API version.  
_Note: Flyway currently only supports API version v1_

If you are using a [Vault dev server](https://learn.hashicorp.com/tutorials/vault/getting-started-dev-server) then an example of what configuring this in Flyway may look like is:  
`flyway.vault.url=http://localhost:8200/v1/`

### vault.token

This is the token required to access your secrets. You can read about generating tokens [here](https://www.vaultproject.io/docs/commands/token/create), including how to add a lifetime to your token in order to control the duration of its validity.

If we have a token `<vault_token>` then configuring this parameter involves adding the following to our Flyway configuration: `flyway.vault.token=<vault_token>`

### vault.secrets

This is a comma-separated list of secrets in Vault which Flyway should try to read from. Each secret must include the path to the secret, and must also start with the secret engine's name. The resulting form is:  
`<engine_name>/<path>/<to>/<secret_name>`.

An example secret would be `secret/data/flyway/testConfiguration` where `secret/data` is the engine name, `flyway` is the path and `testConfiguration` is the secret name.

The value of each secret must be structured like a Flyway configuration file. For example, if we wanted to stored a database password in a secret we would give the secret `flyway.password=<database_password>` as its value.

Now that we've seen how to configure Flyway to access Vault, let's take a look at some examples!

Examples
--------

In each of the examples below we will make the following assumptions:

*   A Vault dev server is running on `http://localhost:8200/v1/`
*   Our Vault token is `<vault_token>`
*   We have visited `http://localhost:8200/v1/` and logged into the web interface using our Vault token
*   We have database credentials `<database_url>`, `<database_user>` and `<database_password>`
*   We have a Flyway license key `<license_key>`

Each example also contains screenshots of Vault's web interface to guide you through the process.  
_Note: Opening images in a new tab may provide a better resolution_

### Securely supplying database credentials

In order to provide database credentials to Flyway securely, we first need to create a secret in Vault that contains our credentials. More information on creating secrets can be found in the Vault tutorial [here](https://learn.hashicorp.com/tutorials/vault/getting-started-first-secret).

After logging in to the Vault dev server web interface, you should see a list of secrets engines as in the image below. Flyway integrates with the `key-value` secrets engine, so we will click on the engine named `secret/`:

Inline image main.png

Clicking on `secret/` will bring up a list of secrets available in this engine. Currently this should be empty as in the image below. We'll create our secret by clicking on `Create secret`:


Inline image secret_page-1

After clicking on `Create secret` you will need to specify your secret's path, name and value. For this example we'll set the path to `flyway`, the name to `credentialsTest` and the value will be:

    flyway.url=<database_url>
    flyway.user=<database_user>
    flyway.password=<database_password>

With these values entered, we can go ahead and click on `Save` as in the image below:

Inline image secret_created-2

That's all that is required to create a secret!

Now we need to configure Flyway to read this secret by setting `vault.url`, `vault.token` and `vault.secrets` as in the following command:

    flyway info -vault.url="http://localhost:8200/v1/" -vault.token="<vault_token>" -vault.secrets="secret/data/flyway/credentialsTest"

Flyway will connect to your database without needing the database credentials to be provided in plaintext. Instead, Flyway will read in the specified secret and use its value to configure the database credentials.

### Securely supplying your Flyway license key

In the previous example we saw how to securely provide database credentials to Flyway. Another confidential parameter in Flyway is the license key and we'll now see how it can also be securely provided using Vault.

First we will need to create a secret as we did in the first example. This time however we'll name the secret `licenseKeyTest` and give it the value:

    flyway.licenseKey=<license_key>

We'll save this secret as in the image below:

Inline image license_key_secret

With the secret created, we can now invoke Flyway with the following command:

    flyway info -vault.url="http://localhost:8200/v1/" -vault.token="<vault_token>" -vault.secrets="secret/data/flyway/licenseKeyTest"

Flyway Teams edition will be able to securely read the license key from Vault without requiring it to be explicitly provided in plaintext!

#### Limiting the access duration with the Vault token

We've now seen how to securely distribute a Flyway license key with Vault. We can control the duration of that access by setting a lifetime for which the Vault token is valid for.

You can read about creating tokens with lifetimes in more detail [here](https://www.vaultproject.io/docs/commands/token/create). An example command that creates a token with a 30 minute lifetime is:

    vault token create -ttl=30m

Try Vault today!
----------------

Vault is available for free [here](https://www.vaultproject.io/downloads). Flyway Teams edition users can begin integrating with Vault today! If you're not a Flyway Teams user and are interested in using Vault, click the button below to start your free trial!

[Try Flyway Teams Edition](https://www.red-gate.com/products/flyway/teams/)