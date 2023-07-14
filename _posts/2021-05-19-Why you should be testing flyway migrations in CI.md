_Originally posted April 19 2021 by Chris Heppell on flywaydb.org_

"_It worked on my machine_".

You've likely either heard this from a colleague or thought this yourself when a Flyway migration failed during a production deployment. The fact is that unfortunately, bad migrations slip through to the release process despite our best efforts.

Thankfully, **there are solutions to this** - testing your Flyway migrations in CI. Read on to learn about bad migrations, and how testing can prevent them altogether.

Bad migrations
--------------

Schema migrations only tell half the story. Syntactically, they may look perfectly reasonable. But the data within the database can have huge implications on the _behaviour_ of that SQL script. In the best case, the migration will fail to execute. In the worst case, you can have catastrophic data loss that causes outages for your service.

Let’s take a look at some examples of where migrations can go wrong.

### Clashing migration versions

Imagine the following scenario where two developers start work on independent pieces of work from the same starting point:

*   Ellie creates a branch from main and adds a migration script `V2_036__add_created_at_column_to_reservations_table`
*   Andrew creates a branch from main and adds a migration script `V2_036__create_table_deliveries`

Ellie and Andrew have followed Flyway practices, creating a new migration script for their changes. But at the time of taking their branch, `2.035` was the last migration so they’ve _both_ created `2.036` migration scripts.

Both branches pass tests and apply correctly to development environments so both are merged.

But now, our **main branch is unreleasable**. At deployment time, Flyway will fail because there are two migrations with the same version and therefore cannot complete. 

Is that so bad? Well, imagine if there was serious vulnerability that needed resolving quickly by deploying a hotfix. **You’ve blocked yourself, but more importantly your users, from releasing that critical security fix as you first need to resolve the Flyway migrations.**

#### How do I prevent it?

Running your migration tests before and after every merge to the main branch would catch this straight away and let you take remedial action.

### Unexpected data

Perhaps you’ve decided that a specific column should be made `NOT NULL`. On paper, this is perfectly reasonable - your signup process asks users for their date of birth, so there’s no reason why this would be omitted.

You write your schema migration, run it against your development database, and invoke all of your automated tests with pre-existing curated datasets. Everything passes.

But Flyway fails to migrate production because it turns out during the early access beta program, date of birth wasn’t ever requested. A few of your very dedicated users from those days still have accounts, and therefore Flyway is unable to mark the column `NOT NULL`.

Despite your best efforts, this slipped through the cracks.

As with the clashing migration versions, thankfully this doesn’t cause data loss but it _does_ mean we’re **now unable to release the main branch**.

#### How do I prevent it?

Running tests against a (masked) copy of production would have caught this in your branch long before it ever got merged. You can see an [example of how to do this against the Pagila dataset in this GitHub PR](https://github.com/red-gate/flyway-spawn-demo/pull/4).

### Changing history

Flyway is excellent at preventing you from changing migration scripts that have already been applied. Unfortunately, that doesn’t prevent people from trying!

Suppose we have a new developer who isn’t all too familiar with Flyway. They change an existing migration script to modify the definition of a table. In our tests, migrations are executed against an empty database where no migrations have been applied so this all appears to behave as expected. The branch is merged with this change as it slips past code review, but the migration of production fails.

Yet again, we’ve found ourselves with an **unreleasable main branch**.

#### How do I prevent it?

A migration test that used a dataset with existing applied migrations would have caught this before merging. You can see an [example of how to do this against the Pagila dataset in this GitHub PR](https://github.com/red-gate/flyway-spawn-demo/pull/5).

### Erroneous migrations

The worst type of bad migration are ones that cause data loss. Occasionally, a mistake slips through and gets merged into the main branch.

Perhaps something like this:

    ALTER TABLE Person
    ADD COLUMN FirstName VARCHAR(100),
    ADD COLUMN LastName VARCHAR(100);
    
    UPDATE Person p
    SET FirstName = (SELECT split_part(Name, ' ', 1) FROM Person WHERE p.id = id);
    UPDATE Person p
    SET LastName = (SELECT split_part(Name, ' ', 2) FROM Person WHERE p.id = id);
    
    ALTER TABLE Person
    DROP COLUMN Name;

At a first glance, this looks like a reasonable migration script. But there’s a problem. This only works for users with a first name and last name separated by a single space character. For those users with other name formats, it will drop _everything_ after the second word in a users name column. **This migration will run to completion through Flyway and happily drop the data. This could be catastrophic.**  

https://twitter.com/iamdevloper/status/1381967858402385928?s=20

If you’re unfortunate to reach this point, you have to rely on backups to restore the data.

#### How do I prevent it?

If you’re testing your migrations as part of your CI process, this is something that can be easily caught by asserting on the data after the migration completes. You can see an [example of how to do this against the Pagila dataset in this GitHub PR](https://github.com/red-gate/flyway-spawn-demo/pull/6).

This isn’t theory
-----------------

Thanks to a [Postmortem Culture](https://sre.google/sre-book/postmortem-culture/#:~:text=Postmortem%20Culture%3A%20Learning%20from%20Failure,-Written%20by%20John&text=Incidents%20and%20outages%20are%20inevitable,to%20their%20normal%20operating%20conditions.&text=The%20postmortem%20concept%20is%20well,the%20technology%20industry%20%5BAll12%5D.), many tech companies share the reason behind their outages and their learnings from them publicly. It doesn’t take too long to find some of these postmortem writeups where bad database migrations have caused **significant downtime and service loss**.

[_Open Build Service_](https://openbuildservice.org/) encountered 45 minutes of downtime due to a [bad database migration](https://openbuildservice.org/2017/07/04/post-mortem-1/). They summarised their area for improvement succinctly by stating “Obviously we are in need of more automated testing of migrations with data”. 

GitLab also shared their experience of [downtime due to a database related incident](https://about.gitlab.com/blog/2017/02/10/postmortem-of-database-outage-of-january-31/). They explained “we are in the process of setting up procedures that allow developers to test their database migrations” with [this issue](https://gitlab.com/gitlab-com/gl-infra/infrastructure/-/issues/811) tracking the overall work towards making that reality.

Equally, [GoCardless detailed their downtime](https://gocardless.com/blog/zero-downtime-postgres-migrations-the-hard-parts/) during what they believed would be a zero-downtime schema change. In this case, there were subtle behaviours in PostgreSQL that meant an innocuous looking change produced unexpected results. We can imagine a database CI test that performs these kinds of migrations during artificial load testing to capture these kinds of problems before they ever hit production.

All of this can be avoided
--------------------------

These problems can _all_ be avoided through a variety of different types of migration tests in CI.

Flyway can easily be installed on your CI server and you can create rigorous tests to ensure you can always deploy safely:

*   Validate your migrations can apply beginning-to-end on empty databases
*   Ensure no data loss occurs by running on masked production backups created on a regular schedule
*   Include Flyway migrations during artificial load testing of your service to verify zero-downtime deployments
