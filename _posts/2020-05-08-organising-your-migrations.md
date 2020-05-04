---
layout: blog
subtitle: Organising your Migrations
permalink: /blog/organising-your-migrations.html
author: philip
---

In [Flyway 6.4.0](/blog/flyway-6.4.html) we introduced a new feature, support for wildcards in the locations. With this feature a new set of solutions to organising your migration files has now become available. In this post we hope to details some of them, to aid the users of Flyway in deciding the solution that best suits them.

## Wildcards
Locations can now contain wildcard patterns. This allows matching against a path pattern instead of a single path. Supported wildcards:<br/>

- `**` : Matches any 0 or more directories
  - e.g. `db/**/test` will match `db/version1.0/test`, `db/version2.0/test`, `db/development/version/1.0/test` but not `db/version1.0/release`
- `*` : Matches any 0 or more non-separator characters
  - e.g. `db/release1.*` will match `db/release1.0`, `db/release1.1`, `db/release1.123` but not `db/release2.0`)
- `?` : Matches any 1 non-separator character
  - e.g. `db/release1.?` will match `db/release1.0`, `db/release1.1` but not `db/release1.11`

\- philip