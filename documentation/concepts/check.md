---
layout: documentation
menu: check
subtitle: Check
redirect_from: /documentation/check/
---
# Check
{% include teams.html %}

Check produces comparison reports to indicate differences between the current configuration of your database and what your migration scripts define. You might use this to get a summary of pending changes as part of an in-person review process or as a validation of the effect of all pending changes. 
## How it works  
- A temporary database is used and your migrations are run against this to produce a view of your target configuration. 
    - There is no requirement for the temporary database to be in your production system 
    - Please note that the temporary database will be cleaned before the operation starts.
- The command then runs a comparison engine to identify differences between the temporary database just configured and the current database that Flyway is pointed at (as defined by the flyway.url parameter).
    - The comparison engine is dependent on [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) which is why this is required.
- Formatted reports are created based on default behaviour or your configuration parameters
    - html : Human readable output
    - json : Machine readable output that is easy to parse as part of your CI/CD pipeline

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate<i class="fa fa-arrow-right"></i></a>
</p>