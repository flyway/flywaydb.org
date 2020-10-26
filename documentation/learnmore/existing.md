---
layout: documentation
menu: existing
subtitle: Existing Database Setup
redirect_from: /documentation/existing/
---

# Existing Database Setup

These are the steps to follow to successfully integrate Flyway into a project with existing databases.

## Extract the DDL and reference data from production

First start by taking a snapshot of your most important database: production. This will be the starting point for migrations.

Generate a SQL script that includes the entire DDL (including indexes, triggers, procedures ...) of the production database. To do this you will need to add insert statements for all of the reference data present in the database.

This script will form your base migration. Save it in a location specified in the [locations](/documentation/configuration/parameters/locations) property.Give it a relevant version number and description such as `V1__baseline_script.sql`

## Clean all databases containing data you don't mind losing

Now comes the point where we have to make sure that the migrations meant for production will work everywhere.

For all databases with unimportant data you don't mind losing, execute:
<pre class="console">&gt; flyway clean</pre>
to completely remove their contents.

## Align the remaining databases with production

Check all remaining databases. You must make sure that their structure (DDL) and reference data matches production exactly. This step is important, as all scripts destined for production will be applied here first. For the scripts to succeed, the objects they migrate must be identical to what is present in production.

## Give these databases a baseline version

Now comes the time to baseline the databases that contain data (including production) with a baseline version. Use the same version and description you used for the production extract script created above.

You can accomplish it like this:
<pre class="console">&gt; flyway baseline</pre>
You must perform this step for each database that hasn't been cleaned.

## Done!

Congratulations! You are now ready.

When you execute:

<pre class="console">&gt; flyway migrate</pre>

the empty databases will be migrated to the state of production and the others will be left as is.

As soon as you add a new migration, it will be applied identically to all databases.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/configuration/envvars">Environment Variables<i class="fa fa-arrow-right"></i></a>
</p>
