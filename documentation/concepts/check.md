---
layout: documentation
menu: check
subtitle: Check
---
# Check
<strong>The `check` command is currently in beta, and only available in the Enterprise edition of Flyway. </strong>
<br>{% include enterprise.html %}
<div id="toc"></div>
## Overview 

In Flyway, “Checks” is the collective term we use for the pre- or post-deployment analysis of some aspect of your database migration. Checks are instantiated using the top level `check` command.  

Before performing a deployment to the target database (most notably, production), you might want to look over what you’re able to do and understand one or more of the following: 

- Does this set of changes affect the objects I expect it to, or will I be inadvertently having an impact of something else? 
- What database changes have been made recently, that coincide with the changes in database performance, we are seeing? Are the two related? 
- Is the production database in the same state you were expecting when you began developing your changes? Has anything about the target database changed that would mean my changes no longer have the desired effect?  
- Does our approach to database change development meet our internal policies? Are our migration scripts adhering to our naming conventions, for example? Are we following the security best-practices required of us by our external regulatory requirements? 

Each of these scenarios can be met with the `check` command, using the corresponding flag: 
<table class='table'>
<tr>
    <td><strong>Scenario</strong></td>
    <td><strong>Command &amp; Flag</strong></td>
    <td><strong>Output</strong></td>
</tr>
<tr>
    <td><em>In beta</em><br>Will these changes have the effect I am expecting?</td>
    <td>check <b>-changes</b></td>
    <td>ChangeReport.html,<br>ChangeReport.json</td>
</tr>

<tr>
    <td><em>In beta</em><br>What database changes have been made recently?</td>
    <td>check <b>-changes</b></td>
    <td>ChangeReport.html,<br>ChangeReport.json</td>
</tr>

<tr>
    <td><em>Coming soon</em><br>Is the production database in the state I am expecting it to be in?</td>
    <td>check <b>-drift</b></td>
    <td>&nbsp;</td>
</tr>
<tr>
    <td><em>Coming soon</em><br>Are our changes following internal policies?</td>
    <td>check <b>-drift</b></td>
    <td>&nbsp;</td>
</tr>
</table>

## `Check –changes` 
### Overview 
the `–changes` flag produces a report indicating differences between your target database (ie. the one you want to change) and what your migration scripts define (ie. the set of instructions you want to use to change your target database).  
You can use this capability pre- and post-deployment: 
- In pre-deployment scenarios to check the effect of your pending changes 
- In post-deployment scenarios to capture a history of changes for retrospective auditing or reporting 

In either scenario, using the `-changes` flag will help you infer which database objects will be/have been affected - and how – when you execute/have executed your migration script(s). 

### Requirements and behaviour
The `check –changes` command and flag works by building a temporary database. This temporary database is first made to reflect the state of your target schema, and then made to reflect your target schema with the pending changes applied.  

The difference between the two states of this temporary database (target now, and target with changes applied) represents the effect your pending migrations will have (or have had) when the scripts are (or were) executed. This difference is captured as an artefact called a “Change Report”. The change report is available as both HTML (human readable) and JSON (machine readable) formats. 

The process works like this: 

1. Specify your target database location 
    1. This is the database you want to apply your changes to, where Flyway is already being used to manage migrations (i.e. A Flyway migrations table exists)) 
1. Specify a temporary database, either  
    1. A location for the temporary database (Flyway will create the database for you), or 
    1. An existing temporary database (note: Flyway will “clean” this database, so if you specify a full database, you must ensure it is ok to for Flyway to erase its schema) 
1. Run `flyway check –changes` 

Flyway’s `check –changes` will then: 
1. Clean your temporary database 
1. Check the latest version of your target database (let’s say it’s at V4) 
1. Migrate the temporary database to the same version as your target database 
1. Take a snapshot of the temporary database (now also at V4) 
1. Migrate the temporary database up to the latest script versions in the project (let’s say it’s at V6) 
1. Take a snapshot of the temporary database (now at V6) 
1. Compare the V4 temporary database snapshot to the V6 temporary database snapshot 
1. Generate a HTML (human readable) and JSON (machine readable) Change Report, indicating the additions, deletions, and modifications of database objects between V4 and V6 

## Good things to know 
- There is no requirement for the temporary database to be in your production system 
- Please note that the temporary database **will be cleaned** before the operation starts 
- The comparison engine is dependent on [.NET 6](https://dotnet.microsoft.com/en-us/download/dotnet/6.0) which is why this is required. 
- The command accepts a flag to indicate the kind of report output to generate (html or json), but generates both by default 


