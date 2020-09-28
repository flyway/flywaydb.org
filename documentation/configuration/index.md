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
If using the command line, config parameters can be set via command line arguments (e.g. `./flyway -url=jdbc:h2:mem;flyway info`), [configuration files](/documentation/configfiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem;flyway`).

### Api
If using the api, config parameters can be set via calling methods on the configuration object returned by `Flyway.configure()` (e.g. `Flyway.configure().url("jdbc:h2:mem;flyway").load()`), [configuration files](/documentation/configfiles), or environment variables if the `.envVars()` method is called on the configuration object.

### Maven
If using maven, config parameters can be set on the configuration xml block in the maven config, [configuration files](/documentation/configfiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem;flyway`).

### Gradle
If using maven, config parameters can be set in the plugin configuration block, [configuration files](/documentation/configfiles), or environment variables (e.g. `FLYWAY_URL=jdbc:h2:mem;flyway`).

## Parameters

### Basic
- [url](/documentation/configuration/url)
- [user](/documentation/configuration/user)
- [password](/documentation/configuration/password)
- [locations](/documentation/configuration/locations)
- [driver](/documentation/configuration/driver)
- [callbacks](/documentation/configuration/callbacks)
- [configFiles](/documentation/configuration/configFiles)
- [configFileEncoding](/documentation/configuration/configFileEncoding)

### Advanced
- [connectRetries](/documentation/configuration/connectRetries)
- [encoding](/documentation/configuration/encoding)
- [group](/documentation/configuration/group)
- [initSql](/documentation/configuration/initSql)
- [installedBy](/documentation/configuration/installedBy)
- [jarDirs](/documentation/configuration/jarDirs)
- [mixed](/documentation/configuration/mixed)
- [outOfOrder](/documentation/configuration/outOfOrder)
- [resolvers](/documentation/configuration/resolvers)
- [skipDefaultCallbacks](/documentation/configuration/skipDefaultCallbacks)
- [skipDefaultResolvers](/documentation/configuration/skipDefaultResolvers)
- [table](/documentation/configuration/table)
- [tablespace](/documentation/configuration/tablespace)
- [target](/documentation/configuration/target)
- [validateMigrationNaming](/documentation/configuration/validateMigrationNaming)
- [validateOnMigrate](/documentation/configuration/validateOnMigrate)
- [workingDirectory](/documentation/configuration/workingDirectory)

### Flyway Teams
{% include teams.html %}
- [licenseKey](/documentation/configuration/licenseKey)
- [cherryPick](/documentation/configuration/cherryPick)
- [dryRunOutput](/documentation/configuration/dryRunOutput)
- [errorOverrides](/documentation/configuration/errorOverrides)
- [jdbcProperties](/documentation/configuration/jdbcProperties)
- [batch](/documentation/configuration/batch)
- [oracleSqlPlus](/documentation/configuration/oracleSqlPlus)
- [oracleSqlPlusWarn](/documentation/configuration/oracleSqlPlusWarn)
- [outputQueryResults](/documentation/configuration/outputQueryResults)
- [skipExecutingMigrations](/documentation/configuration/skipExecutingMigrations)
- [stream](/documentation/configuration/stream)
- [undoSqlMigrationPrefix](/documentation/configuration/undoSqlMigrationPrefix)

### Schema
- [schemas](/documentation/configuration/schemas)
- [defaultSchema](/documentation/configuration/defaultSchema)
- [createSchemas](/documentation/configuration/createSchemas)

### Baseline
- [baselineDescription](/documentation/configuration/baselineDescription)
- [baselineOnMigrate](/documentation/configuration/baselineOnMigrate)
- [baselineVersion](/documentation/configuration/baselineVersion)

### Clean
- [cleanDisabled](/documentation/configuration/cleanDisabled)
- [cleanOnValidationError](/documentation/configuration/cleanOnValidationError)

### Validate
- [ignoreFutureMigrations](/documentation/configuration/ignoreFutureMigrations)
- [ignoreIgnoredMigrations](/documentation/configuration/ignoreIgnoredMigrations)
- [ignoreMissingMigrations](/documentation/configuration/ignoreMissingMigrations)
- [ignorePendingMigrations](/documentation/configuration/ignorePendingMigrations)

### Migration
- [repeatableSqlMigrationPrefix](/documentation/configuration/repeatableSqlMigrationPrefix)
- [sqlMigrationPrefix](/documentation/configuration/sqlMigrationPrefix)
- [sqlMigrationSeparator](/documentation/configuration/sqlMigrationSeparator)
- [sqlMigrationSuffixes](/documentation/configuration/sqlMigrationSuffixes)

### Placeholders
- [placeholderPrefix](/documentation/configuration/placeholderPrefix)
- [placeholderReplacement](/documentation/configuration/placeholderReplacement)
- [placeholders](/documentation/configuration/placeholders)
- [placeholderSuffix](/documentation/configuration/placeholderSuffix)

### Command Line
- [color](/documentation/configuration/cliColor)