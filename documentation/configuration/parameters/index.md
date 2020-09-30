---
layout: documentation
menu: configuration
menu: configuration
pill: configuration
subtitle: configuration
---

# Configuration

Flyway has many different parameters that can be set to configure its behavior. These parameters can be set through a variety of different means, depending on how you are using Flyway.

## Usage

### Command Line
If using the command line, config parameters can be set via command line arguments (e.g. `./flyway -url=jdbc:h2:mem:flyway info`), [configuration files](/documentation/configuration/configFiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem:flyway`).

### Api
If using the api, config parameters can be set via calling methods on the configuration object returned by `Flyway.configure()` (e.g. `Flyway.configure().url("jdbc:h2:mem:flyway").load()`), [configuration files](/documentation/configuration/configFiles), or environment variables if the `.envVars()` method is called on the configuration object.

### Maven
If using maven, config parameters can be set on the configuration xml block in the maven config, [configuration files](/documentation/configuration/configFiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem:flyway`).

### Gradle
If using maven, config parameters can be set in the plugin configuration block, [configuration files](/documentation/configuration/configFiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem:flyway`).

## Parameters

### Connection
- [url](/documentation/configuration/parameters/url)
- [user](/documentation/configuration/parameters/user)
- [password](/documentation/configuration/parameters/password)
- [driver](/documentation/configuration/parameters/driver)
- [connectRetries](/documentation/configuration/parameters/connectRetries)
- [initSql](/documentation/configuration/parameters/initSql)
- [jdbcProperties](/documentation/configuration/parameters/jdbcProperties) {% include teams.html %}

### General

- [locations](/documentation/configuration/parameters/locations)
- [callbacks](/documentation/configuration/parameters/callbacks)
- [configFiles](/documentation/configuration/parameters/configFiles)
- [configFileEncoding](/documentation/configuration/parameters/configFileEncoding)
- [encoding](/documentation/configuration/parameters/encoding)
- [group](/documentation/configuration/parameters/group)
- [installedBy](/documentation/configuration/parameters/installedBy)
- [jarDirs](/documentation/configuration/parameters/jarDirs)
- [mixed](/documentation/configuration/parameters/mixed)
- [outOfOrder](/documentation/configuration/parameters/outOfOrder)
- [skipDefaultCallbacks](/documentation/configuration/parameters/skipDefaultCallbacks)
- [skipDefaultResolvers](/documentation/configuration/parameters/skipDefaultResolvers)
- [table](/documentation/configuration/parameters/table)
- [tablespace](/documentation/configuration/parameters/tablespace)
- [target](/documentation/configuration/parameters/target)
- [validateMigrationNaming](/documentation/configuration/parameters/validateMigrationNaming)
- [validateOnMigrate](/documentation/configuration/parameters/validateOnMigrate)
- [workingDirectory](/documentation/configuration/parameters/workingDirectory)
- [licenseKey](/documentation/configuration/parameters/licenseKey) {% include teams.html %}
- [cherryPick](/documentation/configuration/parameters/cherryPick) {% include teams.html %}
- [dryRunOutput](/documentation/configuration/parameters/dryRunOutput) {% include teams.html %}
- [errorOverrides](/documentation/configuration/parameters/errorOverrides) {% include teams.html %}
- [batch](/documentation/configuration/parameters/batch) {% include teams.html %}
- [outputQueryResults](/documentation/configuration/parameters/outputQueryResults) {% include teams.html %}
- [skipExecutingMigrations](/documentation/configuration/parameters/skipExecutingMigrations) {% include teams.html %}
- [stream](/documentation/configuration/parameters/stream) {% include teams.html %}

### Schema
- [schemas](/documentation/configuration/parameters/schemas)
- [defaultSchema](/documentation/configuration/parameters/defaultSchema)
- [createSchemas](/documentation/configuration/parameters/createSchemas)

### Baseline
- [baselineDescription](/documentation/configuration/parameters/baselineDescription)
- [baselineOnMigrate](/documentation/configuration/parameters/baselineOnMigrate)
- [baselineVersion](/documentation/configuration/parameters/baselineVersion)

### Clean
- [cleanDisabled](/documentation/configuration/parameters/cleanDisabled)
- [cleanOnValidationError](/documentation/configuration/parameters/cleanOnValidationError)

### Validate
- [ignoreFutureMigrations](/documentation/configuration/parameters/ignoreFutureMigrations)
- [ignoreIgnoredMigrations](/documentation/configuration/parameters/ignoreIgnoredMigrations)
- [ignoreMissingMigrations](/documentation/configuration/parameters/ignoreMissingMigrations)
- [ignorePendingMigrations](/documentation/configuration/parameters/ignorePendingMigrations)

### Migrations
- [resolvers](/documentation/configuration/parameters/resolvers)
- [repeatableSqlMigrationPrefix](/documentation/configuration/parameters/repeatableSqlMigrationPrefix)
- [sqlMigrationPrefix](/documentation/configuration/parameters/sqlMigrationPrefix)
- [sqlMigrationSeparator](/documentation/configuration/parameters/sqlMigrationSeparator)
- [sqlMigrationSuffixes](/documentation/configuration/parameters/sqlMigrationSuffixes)
- [undoSqlMigrationPrefix](/documentation/configuration/parameters/undoSqlMigrationPrefix) {% include teams.html %}

### Placeholders
- [placeholderPrefix](/documentation/configuration/parameters/placeholderPrefix)
- [placeholderReplacement](/documentation/configuration/parameters/placeholderReplacement)
- [placeholders](/documentation/configuration/parameters/placeholders)
- [placeholderSuffix](/documentation/configuration/parameters/placeholderSuffix)

### Command Line
- [color](/documentation/configuration/parameters/cliColor)
- [edition](/documentation/configuration/parameters/edition)

### Oracle
- [oracleSqlPlus](/documentation/configuration/parameters/oracleSqlPlus) {% include teams.html %}
- [oracleSqlPlusWarn](/documentation/configuration/parameters/oracleSqlPlusWarn) {% include teams.html %}