---
layout: documentation
menu: check
subtitle: Check
---
# Check
{% include enterprise.html %}

Check produces reports to indicate differences between your current database and what your migration scripts define.  
- A temporary database is used and your migrations are run against this to produce a model of your target configuration. 
    - There is no requirement for the temporary database to be in your production system 
    - Please note that the temporary database **will be cleaned** before the operation starts

## Flags
The command uses a flag to indicate the kind of report to generate:

### `-changes` 

This is used to report on the pending changes that have yet to be applied to the database. You might use this as part of an in-person review process or as a validation of the effect of all pending changes.
- The command then runs a comparison engine to identify differences between the temporary database at two points:
    - The state equivalent to the current version of of the target database
    - The state once all pending migrations have been run

- The comparison engine is dependent on [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) which is why this is required.
- Formatted reports are created based on default behaviour or your configuration parameters
    - `html` : Human readable output
    - `json` : Machine readable output that is easy to parse as part of your CI/CD pipeline

