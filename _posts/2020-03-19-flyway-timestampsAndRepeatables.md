---
layout: blog
subtitle: Timestamps and Repeatable Migrations
permalink: /blog/flyway-timestampsAndRepeatables.html
author: philip
---

In Flyway 6.3.0 we introduced a new feature. The ability to use the `${flyway:timestamp}` placeholder (See **[Placeholders](/documentation/placeholders)** for more details). This placeholder will insert the current date in the format `yyyy-MM-dd HH:mm:ss` as its value. Now, this has some very obvious uses such as storing the date a migration was executed into your database. However, there is something more complex you can do with it that we want to highlight with this post.

## Repeatable migrations
A repeatable migration is a migration that is run whenever its checksum changes. This allows the project to contain a single file to represent the most up to date version of a particular object (often a function or procedure), instead of a full history of versions. It has no version number, just the 'R__' prefix followed by the migration name. As it is, repeatable migrations are very useful and suit many use cases. However, what if you want your repeatable migration to be re-run, regardless of whether or not the checksum changed? 


### The ordering problem
Consider the following situation. You have a team of developers, each one making changes to the database in parallel and generating migrations. Now let's say developer 1 creates a procedure called `my_important_proc`, and commits it inside a repeatable migration with some other changes. 

```
R__UtilityProcedures.sql
create or replace procedure my_important_proc
```

Developer 2 pulls the changes and migrates their database without checking what the changes contain. They then goes on to make their own changes, creating another procedure called `my_important_proc`. Now they put this inside another migration, again with some unrelated name. 

```
R__HelperProcedures.sql
create or replace procedure my_important_proc
```

As they develop, changing the migration file, Flyway will detect the repeatable migration changing and reapply it to the database, overwriting the `my_important_proc` that developer 1 created, and replacing it with the updated version developer 2 is creating. The eagle eyed amongst you may have spotted the oncoming bug. The migration developer 2 created is called `R__HelperProcedures.sql`, the migration developer 1 created is called `R__UtilityProcedures.sql`. Flyway executes repeatable migrations in alphabetical order, meaning when these changes are applied to a database that contains neither (such as production!) then developer 1's version of the procedure will overwrite developer 2's version, behaving completely differently to what developer 2 is seeing when developing locally. 

Now, if you could force Flyway to execute all the repeatable migrations on each migration then developer 2 would immediately see that his version of the procedure is being overwritten by someone else's, and would be able to fix it before pushing the changes to version control, and onwards to test/production.


### Timestamps to save the day
Enter the the new timestamp placeholder. As the placeholder contains the current time, it changes on each migration. This changes the checksum for the repeatable migrations, meaning they get executed each time you run migrate. Simply include the timestamp placeholder anywhere in the migration (such as in a comment at the top of the file) to ensure the migrations will be rerun. e.g.

```
R__UtilityProcedures.sql
-- ${flyway:timestamp}
create or replace procedure my_important_proc
```

```
R__HelperProcedures.sql
-- ${flyway:timestamp}
create or replace procedure my_important_proc
```

With this small change to the migrations, this bug can be caught earlier in development, saving everyone time and energy.

This technique can also be useful in more situations. For example, on a CI server you don't want to clean, you can use it to rebuild all the executable code to ensure that it is valid with any recent schema changes. I'm sure many other clever use cases for this new feature will become apparent as people get to grips with it.

\- Philip