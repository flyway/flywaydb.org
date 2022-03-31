---
layout: documentation
menu: check
subtitle: Check
---

# Check
{% include enterprise.html %}

Produces reports to increase confidence in your migrations.

Flyway migrates against a temporary database and compares this against the target database in order to generate a report.
This temporary database will be cleaned both before and after it is used, so you must ensure it does not contain anything of importance.

#### Requirements
- .NET 6 is required in order to generate reports. You can download it from [here](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).

#### Flags:
_One or more flags must be present_

| Parameter                    | Description
| ---------------------------- | --------------------------------------------------------------
|    -changes                  |  Include pending changes that will be applied to the database
|    -IAgreeToTheEULA          |  **[REQUIRED]** I agree to the EULA (https://www.red-gate.com/support/license/)

#### Configuration parameters:
 _Format: -key=value_

| Parameter                    | Description
| ---------------------------- | -----------------------------------------------------------
|    check.tempUrl             | **[REQUIRED]** URL for a temporary database. Note: This database will be cleaned!
|    check.tempUsername        | Username for the temporary database. Defaults to 'flyway.user'
|    check.tempPassword        | Password for the temporary database. Defaults to 'flyway.password'
|    check.outputLocation      | Destination folder for reports. Defaults to the current directory
|    check.outputTypes         | Format of reports. Options are: 'json', and 'html'. Defaults to 'html,json'

#### Usage Example:
```
flyway check -changes -url=jdbc:example:database -user=username -password=password -check.tempUrl=jdbc:example:tempdatabase -IAgreeToTheEULA
```

##### Example configuration file

``````properties
flyway.url=jdbc:example:database
flyway.user=username
flyway.password=password
flyway.check.tempUrl=jdbc:example:tempdatabase
flyway.check.outputTypes=html,json
```
