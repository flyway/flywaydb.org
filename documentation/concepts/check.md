---
layout: documentation
menu: check
subtitle: Check
---

# Check
**The `check` command is currently in beta. This feature will be available in future products, but during the beta phase you can access it through your Flyway Teams or Redgate Deploy license.**

{% include enterprise.html %}

<div id="toc"></div>

## Overview

In Flyway, “Checks” is the collective term we use for the pre- or post-deployment analysis of some aspect of your database migration. Checks are instantiated using the top level `check` command.

Before performing a deployment to the target database (most notably, production), you might want to look over what you’re about to do and understand one or more of the following:

- Does this set of changes affect the objects I expect it to, or will I be inadvertently having an impact on something else?
- What database changes have been made recently, that coincide with the changes in database performance we are seeing? Are the two related?
- Is the production database in the same state you were expecting when I began developing my changes? Has anything about the target database changed that would mean my changes no longer have the desired effect?
- Does our approach to database change development meet our internal policies? Are our migration scripts adhering to our naming conventions, for example? Are we following the security best-practices required of us by our external regulatory requirements?

Each of these scenarios can be met with the `check` command, using the corresponding flag:

| Scenario                                                                             | Command & Flag     | Output                                  |
|--------------------------------------------------------------------------------------|--------------------|-----------------------------------------|
| _In beta_<br>Will these changes have the effect I am expecting?                      | check **-changes** | ChangeReport.html,<br>ChangeReport.json |
| _In beta_<br>What database changes have been made recently?                          | check **-changes** | ChangeReport.html,<br>ChangeReport.json |
| _In beta_<br>Is the production database in the state I am expecting it to be in?     | check **-drift**   | ChangeReport.html,<br>ChangeReport.json |
| _Coming soon_<br>Are our changes following internal policies ?                       |                    |                                         |

## `Check –changes`

### Overview
The `–changes` flag produces a report indicating differences between applied migration scripts on your target database and pending migrations scripts (ie. the set of instructions you want to use to change your target database).
You can use this capability pre- and post-deployment:
- In pre-deployment scenarios to check the effect of your pending changes
- In post-deployment scenarios to have captured a history of changes for retrospective auditing or reporting

In either scenario, using the `-changes` flag will help you infer which database objects will be/have been affected - and how – when you execute/have executed your migration script(s).

### Requirements and behavior
The `check –changes` command and flag works by building a temporary database. This 'build' database is first made to reflect the state of your target schema, and then made to reflect your target schema with the pending changes applied.

The difference between the two states of this build database (target now, and target with changes applied) represents the effect your pending migrations will have (or have had) when the scripts are (or were) executed. This difference is captured as an artefact called a “Change Report”. The change report is available as both HTML (human readable) and JSON (machine readable) formats.

The process works like this:
![Check_changes.png](/assets/balsamiq/Check_changes.png)
1. Specify your target database location
    1. This is the database you want to apply your changes to, where Flyway is already being used to manage migrations (ie. A Flyway migrations table exists)
1. Specify a build database
    1. This is an existing build database (note: Flyway will “clean” this database, so if you specify a full database, you must ensure it is ok to for Flyway to erase its schema)
1. Run `flyway check –changes`

Flyway’s `check –changes` will then:
1. Clean your build database
1. Query the target database for the list of applied migrations (for simplicity, let’s say it’s at V2)
1. Apply these migrations to the build database
1. Take a snapshot of the build database (now also at V2)
1. Applying pending migrations to the build database (let’s say it’s now at V5)
1. Take a snapshot of the build database
1. Compare the V2 build database snapshot to the V5 build database snapshot
1. Generate a HTML (human readable) and JSON (machine readable) Change Report, indicating the additions, deletions, and modifications of database objects between V2 and V5

## Good things to know
- There is no requirement for the build database to be in your production system
- Please note that the build database **may be cleaned** before the operation starts
- The underlying comparison technology is dependent on [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) which is why this is required
