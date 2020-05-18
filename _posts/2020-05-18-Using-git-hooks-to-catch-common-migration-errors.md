---
layout: blog
subtitle: Using git hooks to catch common migration errors
permalink: /blog/using-git-hooks.html
author: julia
---

When you're on your own developing a simple application, managing your migration scripts is not a demanding task; each
time you add a script, it gets the next version number in whatever sequence you've decided on using. When your
application takes off and you find you have a team working on migrations simultaneously, sharing code via a
distributed source control system such as `git`, then there is an increased risk of running into problems as the 
developers work on the same database migration code at the same time.

## Problem one: Numbering conflicts

Let's say you've been asked to add a new feature to your application, and this needs a new column to be added to the
database. The database schema is currently at v4; so the natural thing to do is create a script `V5__MyNewColumn.sql`
and check it into source control. So far, all is good.

Meanwhile, one of your colleagues is also working on a new feature and has added a script `V5__MyNewTable.sql`. As far
as he's concerned, all appears good too. When the two sets of changes make it into the master branch ready
for testing and deployment, source control will see them as two unrelated files and therefore will not detect any
problem. However, Flyway will see two files with the same schema version number and will fail validation. 

## Problem two: Ordering conflicts

So you decide to sidestep the above problem by agreeing in advance that you will write script `V5__MyNewColumn.sql` and 
your colleague
will write `V6__MyNewTable.sql`. You add your new column to the database in your script, and once again all is good. However,
your colleague working on his local branch can't see your change and he adds some SQL in his script that depends on the
old definition of the table you've altered - for example an `INSERT INTO ...` which fails to specify a value for your
new column. Once again, as far as he's concerned, all appears good too. But when the scripts are merged and run, his 
script will fail.

## Problem three: Timing

So you go one step further and warn your colleague about what you plan to do. He writes his script defensively. His 
changes get through code review more quickly than yours and by the time you come to merge, his changes are in production.
Again, everything seems to be good locally but when your changes are merged, Flyway sees a new script that is numbered
lower than the current schema version and errors.

## Enter Git Hooks

`git` allows you to customise its lifecycle by adding callbacks known as *hooks* - scripts that are executed at particular
points in its processing. These scripts can interrupt `git` if they detect conditions that are problematic but which
`git` is not aware of by itself. This means that we can get Flyway to pick up on potential errors in our scripts 
either when we commit them locally, or when we push our scripts to the remote repository.

Writing a git hook is very simple - we just add a shell script to the `.git\hooks` folder inside our source repository
with the appropriate name, and make sure it is executable by the git process. As an example, here's a `pre-commit`
hook that will verify that I don't have any duplicate migration version numbers:

```bash
#!/bin/sh
if flyway validate -url=jdbc:h2:mem:dummydb \
        -locations=filesystem:/mnt/c/src/sandbox/gitHookDemo/ \
        -ignorePendingMigrations=true; then
	echo Flyway validation successful
	exit 0
else
	echo Flyway validation failed
	exit 1
fi
```
 
For this task we're not interested in a real database connection, so we use a new H2 in-memory database on each run.
We're also not interested in checking whether all migrations have been run - as we know they haven't - so we
set the `ignorePendingMigrations` option. Now, when I have finished working on a script and come to commit it,
the command `git commit` will invoke `flyway validate`, and if there's a problem with my script naming then 
the commit will fail. The error won't propagate to the remote repository at all, preventing problems for other users
down the line.

Validation is usually a quick process; if we're prepared to spend a bit more time up front in order to catch more
problems then we can write a hook that runs a full clean/migrate cycle on an expendable test database:

```bash
#!/bin/sh
flyway clean -url=jdbc:<local-test-db-url> \
        -locations=filesystem:/mnt/c/src/sandbox/gitHookDemo/ ;

if flyway migrate -url=jdbc:<local-test-db-url> \
        -locations=filesystem:/mnt/c/src/sandbox/gitHookDemo/ ; then
  	echo Flyway migration successful
  	exit 0
else
  	echo Flyway migration failed
  	exit 1
fi
```

These checks are local ones, and we can invoke them at times when errors are likely to occur; `pre-commit` prior
to committing a new script; `post-merge` just after pulling new files from the remote repository or merging a
branch which might have conflicting scripts in; and `pre-push` prior to submitting back to the remote repo. We
can also set up our remote repository as a gatekeeper with a `pre-receive` hook that rejects attempts to push
a script that wouldn't update a copy of the production database correctly. By using these judiciously, we can
trap most common problems early, and fix them while it's still easy to do so.

\- Julia