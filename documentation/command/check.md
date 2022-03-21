---
layout: documentation
menu: check
subtitle: Check
---

# Check
{% include enterprise.html %}

Produces comparison reports to increase confidence in your migrations.

#### Flags:
_One or more flags must be present_

| Parameter                    | Description
| ---------------------------- | --------------------------------------------------------------
|    -changes                  |  Include pending changes that will be applied to the database

#### Configuration parameters:
 _Format: -key=value_

| Parameter                    | Description
| ---------------------------- | -----------------------------------------------------------
|    url                       | **[REQUIRED]** URL of the target database
|    user                      | **[REQUIRED]** Username for the target database
|    password                  | **[REQUIRED]** Password for the target database
|    check.tempUrl             | **[REQUIRED]** URL of the temporary database
|    check.tempUsername        | Username for the temporary database. Defaults to 'flyway.user'
|    check.tempPassword        | Password for the temporary database. Defaults to 'flyway.password'
|    check.outputLocation      | Destination folder for comparison reports. Defaults to the current directory
|    check.outputTypes         | Format of comparison reports. Options are: 'json', and 'html'. Defaults to 'json'

#### Usage Example:
```
flyway check -changes -url=jdbc:example:database -user=username -password=password -check.tempUrl=jdbc:example:tempdatabase -check.outputTypes=html,json
```

#### Requirements
- .NET 6 is required in order to generate reports. You can download it from [here](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).
