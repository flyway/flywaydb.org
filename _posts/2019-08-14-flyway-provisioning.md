---
layout: blog
subtitle: "Flyway and database provisioning"
permalink: /blog/flyway-provisioning.html
author: julia
---

Once a year at Redgate we hold [Down Tools Week](https://medium.com/ingeniouslysimple/featureweek-welcome-to-down-tools-week-2019-c3e3f3c92b57). 
It's our hack week, when we temporarily put aside our normal work and form ad-hoc teams to propose, vote on and tackle new problems. One is
always a charity project, others are useful internal tools, prototype products and experiments which we might not otherwise try, and 
which might end up leading to a production-quality development. A big aim in each project is learning and personal development. Naturally
there was a lot of interest in Flyway, and in the end two projects ended up making the cut. In this post we'll look at the one which I was
involved with, where we investigated the practicality of coupling Flyway to a database provisioner.

| ![Our Down Tools Week team](/assets/posts/flyway-provisioning/dtw-team.jpg) |
|:--:|
| *The Down Tools Week team on the roof of Redgate Towers. I underestimated the wind...* |
| |

The background to this idea was as follows: `flyway clean` is very useful in that it reverts an existing database to its original state
by dropping database objects. However, your migrations may have made changes to objects which you don't want to, or can't, drop. You
may want to spin a database from a different pre-determined state, or spin up a range of versions of a given database without the
headaches of side-by-side installations. And for testing, you may prefer to spin up an empty database, do
your tests, and then destroy it, in order both to minimise resource use and be absolutely sure you start each time from a consistent
point. That led us to look at adding a new verb: `flyway provision`.

One obvious implementation was to provision our database from a Docker image. Indeed, we test Flyway against a large collection of 
Docker images, each with a different database version and `flyway provision` could simplify that process. Most database vendors offer
at least some versions of their software in standard Docker images and it's not hard to create others. A second implementation that
we tried was to restore a database from a known backup file. This was more tricky, in that each database has its own quirks around
restores, and in the end the time constraints meant that the team picked the one they were most familiar with - SQL Server - to 
use. And finally, our implementation was designed so that it was as configurable as possible, with extension points open for contributors to
create their own provisioners, as well as us looking at possible future solutions.

At the end of the week, our demo worked - anyone who's done live demos will know how easily gremlins can creep in on the day! - and
the technical part of the idea was validated. Now that the team have gone back to their normal roles and the experimental code repo
has been put down, I'm hoping to start a conversation around validating whether this is a feature the community will find useful, 
what its ultimate scope might be, and its priority relative to other pieces of work we're looking at. Please join in the discussion over
at [Github Issues](https://github.com/flyway/flyway/issues/2464), even just to give us a thumbs-up or down...

\- Julia