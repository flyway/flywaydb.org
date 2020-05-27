---
layout: blog
subtitle: Announcing Flyway/CockroachDB Support
permalink: /blog/announcing-cockroachdb-support.html
author: julia
---

Earlier versions of Flyway supported simpler schema migrations within a single CockroachDB node. Both Flyway and CockroachDB aim to be 
simple to use, and we're delighted that the Cockroach Labs team have worked closely with us to enable Flyway to be just as robust and
reliable in scenarios involving many distributed nodes where migrations need to propagate from any node safely without downtime - scenarios 
that are increasingly common in cloud applications - without imposing that underlying complexity on Flyway users. Indeed, you shouldn't
notice any difference at all.

Flyway is now fully compatible with CockroachDB. CockroachDB is a distributed SQL database that survives outages and provides effortless scale 
for cloud applications. When it comes to modifying schema, CockroachDB makes it as easy as possible for developers. It lets you modify your 
schema and change your primary keys while the database is online and in production, using a few SQL commands. With the new Flyway compatibility, 
modifying schemas with CockroachDB is now even easier. You can read more over on Cockroach Labs’ blog, 
[here](https://www.cockroachlabs.com/blog/flyway-for-cockroachdb/).

\- Julia