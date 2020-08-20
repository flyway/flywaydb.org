---
layout: blog
subtitle: A first view of Flightpath
permalink: /blog/A-first-view-of-Flightpath.html
author: julia
---

Once a year at Redgate we hold Down Tools Week. It’s our hack week, when we temporarily put aside our 
normal work and form ad-hoc teams to propose, vote on and tackle new problems. 
[Last time](https://flywaydb.org/blog/flyway-provisioning) one team took a look at database provisioning
in tandem with Flyway. This year, as knowledge about Flyway has spread through the company there were
quite a few proposals for it to be involved in various projects in one form or another. One of our
successful ones has come to be known as *Flightpath*.

| ![The project banner](/assets/posts/flightpath/flightpath.png) |
|:--:|
| *Our project quickly got its own identity!* |
| |

At Redgate we're very keen on the [Accelerate metrics](https://accelerate.delivery/delivery-metrics/)
as a measure of a development team's performance. They are:

- deployment frequency - how often do you ship?
- change failure rate - how often do you have to roll back what you shipped?
- mean time to recovery - how long does it take to get back to stability?
- cycle time - how long does it take from starting work on a feature to it being in users' hands?

We use these metrics within the Flyway team, and it's pushed us to maintain a frequent release
cadence, react quickly to problems in new releases and work on our internal processes so that
actually doing releases is fast and easy.

Of course, the whole purpose of Flyway is to make deploying the database element of your
software easy, reliable and undoable - that is, to make your organisation's metrics improve!
But it would be even better if you and your organisation can visualise these metrics easily;
Flyway stores historic intelligence about deployments in its history tables, and providing a way
to see this will both give you insight into your deployment process, as well as potentially helping
us to understand our end-users - you - better and meet your needs. The database, of course, is not the
only component of your systems, but the frequency with which you do migrations, and the times at
which you use undo scripts on a production database, are useful proxies for the overall metrics.

We started off by surveying a number of you to gauge what interest there might be. Two thirds of
you are comfortably deploying database changes weekly or faster - that's great! Topics that featured 
heavily were providing information for audit purposes and assessing failure rates and the need for 
rollbacks. 

We decided that Flightpath would not be a part of Flyway itself, but a separate plugin that can be
dropped in much like a callback. This means Flightpath is entirely optional, doesn't affect the 
Flyway engine itself, and prevents any privacy concerns. The idea is that when you carry out Flyway 
operations such
as migrations and rollbacks, the Flightpath plugin will send anonymised information to a custom
dashboard, or an off-the-shelf graphing tool; we used Grafana. 

| ![Part of our prototype dashboard](/assets/posts/flightpath/dashboard2.png) |
|:--:|
| *Part of our prototype dashboard* |
| |

Flightpath would also collect up aggregated metrics that will help us get a better understanding of
how Flyway is used, which in turn would feed into our decision making when we're looking at how to develop
Flyway in future.

By the end of the week we had the Flightpath plugin running happily inside a demonstration Flyway
instance, and our platform was picking up data and producing charts. The competitive element of the
week requires a working demo on Friday afternoon, and we got there with time to spare!

| ![Part of our Grafana prototype](/assets/posts/flightpath/grafana2.png) |
|:--:|
| *Part of our Grafana prototype* |
| |

There is a lot of work ahead before Flightpath takes off - getting more feedback around
our prototype dashboard designs; investigating options around free shared public platforms, private 
pipelines and self-hosted platforms for larger enterprises; and providing documentation and support
so that it's as easy to adopt as Flyway itself. If you're interested in knowing more, or taking part
in future research, please do [get in touch](mailto:support@flywaydb.org), we'd love to hear from you!  