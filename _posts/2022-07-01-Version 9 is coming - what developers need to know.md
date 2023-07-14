_Originally posted July 1st 2022 by Jonny Roberts on flywaydb.org_

Version 9 of Flyway brings new features, capabilities, and many small improvements. Upgrading to 9 will introduce new capabilities like the \`check\` command, but it also brings API changes that you may need to account for. Here’s everything you need to stay ahead. 

**Newsletter subscribers always get the heads-up first. Not a subscriber? [Sign up now](https://www.red-gate.com/products/flyway/entrypage/stay-updated)**   

Flyway uses semantic versioning 
--------------------------------

Flyway follows a semantic approach to version numbering which, following the convention described by semver.org means: 

1.  A **major** version when you make incompatible API changes, 

2.  A **minor** version when you add functionality in a backwards compatible manner, and  

3.  A **patch** version when you make backwards compatible bug fixes. 

Every year for the past 5 years we’ve made a conscious effort to introduce a major new version of Flyway, and this year is no different. In the coming weeks we’ll be releasing Version 9 to General Availability (GA). 

A major version change is both an opportunity to introduce a new feature, as well as an opportunity to keep Flyway up to date and make retrospective improvements. 

The headline feature for Version 9 is \``check`\`. “Check” is a new verb, under which we’ll wrap several capabilities including: 

*   \``-changes`\` : the ability to get a comprehensive report of the changes to the target database your pending migrations will affect 
*   \``-drift`\`: the ability to check whether the deployment target is in the state you expect it to be in prior to a migration, not to mention understanding what’s changed if it has drifted 

*   \``-codeStandards`\`: coming later in the year, code standards is both a quality check on the script being written as well as a compliance check on the SQL that’s being executed 

Not all the breaking changes we’ve made are strictly related to \``check`\` feature, but it will only be available in Version 9, and to use it you may need to be aware of some things.  

5 important “breaking changes” in Version 9 
--------------------------------------------

A breaking change is defined as “_a change in one part of a software system that potentially causes other components to fail_”, which sounds scary but in reality, for Flyway, is quite easy to cater for in advance. 

You may need to know about some, or none, of these changes, but these are the top-5 changes I want to make you aware of: 

### 1\. CLI packaging changes 

This change will introduce 2 CLI packages; one for Flyway Community CLI, and the other for Flyway Teams CLI.  

If you’re only using the Flyway Community edition today, nothing will change. If you’re a Teams customer (thank you for your support!) then you’ll need to retrieve Flyway Teams CLI from a new end-point on our website:  

**Visit**: [Flyway CLI download](https://documentation.red-gate.com/fd/command-line-184127404.html) 

### 2\. The \`clean\` command will be disabled by default 

The use of the clean feature is especially useful in development but, in our own words, “career limiting” in production.  

As Flyway gains in popularity, and our users get more confident in using it to automate production deployments, we thought about it and agreed with you that it was sensible to change the default behaviour so that clean is off by default.  

When you upgrade to Version 9, to carry on using \``clean`\` (not in production, hopefully 😉), you’ll need to set \``-cleanDisabled`\` to “`false`”:  

**Visit**: [cleanDisabled parameter documentation](https://documentation.red-gate.com/fd/clean-disabled-184127486.html)  

### 3\. Changes to 5 API areas  

We’re committed to maintaining the Open Source Flyway Community edition, and the paid-for editions we sell to commercial organisations are our way of keeping the lights on for Community. 

As Flyway’s evolved it’s become harder to manage the code and integration of capabilities for commercial organisations on top of the Community codebase.  

We’re making some changes to our architecture to make this easier for us, which protects the future existence of Flyway Community for you.  

On a deeply technical level, [Ajay](https://github.com/DoodleBobBuffPants) tells me that we’re “moving to a micro kernel model”, but I don’t understand what that means but that “it’s fine to think of it as more of a plugin architecture”. Future features will be modularised, and older features converted retrospectively.

The first feature to move to this architecture is [Baseline Migrations](https://documentation.red-gate.com/fd/baseline-migrations-184127465.html). 

Subsequently we’ve made changes to 5 API areas, including: \``migrationType`\`, \``configuration`\`, \``JavaMigration`\`, \``MigrationResolver`\` and \``ResolvedMigration`\`. Each of these has a nuanced impact, and if this is a feature you rely on, I’d encourage you to review the detail: 

**Visit**: [github.com/flyway/flyway/issues/3407](https://github.com/flyway/flyway/issues/3407)  

### 4\. Changes to database version support horizons 

The older a database version is, the greater our testing overhead becomes. Sticking to an older version of a database is typically only desired by commercial organisations, and it’s where our comprehensive testing becomes truly valuable. 

Flyway Community supports database versions up to 5 years old, and up to 10 years old in Teams. Each year we review which database versions move out of the “less than 5 years old” bracket and move their support into the Teams edition. 

This year the following database versions have turned 5 🎂: 

*   H2 version 1.4 
*   Oracle 12.2 
*   MariaDB 10.2 
*   HSQLDB 2.4 

If you are still using one of these versions, and your company isn’t interested in updating to them, please consider asking them to purchase a Teams license: 

**Visit**: [red-gate.com/products/flyway/teams](https://www.red-gate.com/products/flyway/teams/pricing?quantity=10) 

### 5\. Complete removal of stuff we deprecated in v8 

Finally, we’ve completely removed some of the parameters we marked as deprecated in v8. We’ve: 

*   Removed the deprecated secrets management properties, 
*   Removed \``oracleKerberosConfigFile`\` (which was replaced by \``kerberosConfigFile`\`), and
*   Removed the old \``ignore<x>Migrations`\` parameters 

We want to hear from you, our Flyway community 
-----------------------------------------------

Do you have any concerns about any of these? We’re listening. Head over to our [V9 breaking change issue](https://github.com/flyway/flyway/issues/3407) on GitHub and have your say.