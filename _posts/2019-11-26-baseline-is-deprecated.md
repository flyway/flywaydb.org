---
layout: blog
subtitle: "Baseline command is deprecated"
permalink: /blog/baseline-is-deprecated.html
author: mikiel
---

In Flyway 6.1, the Baseline command will be deprecated. It'll still be available, but will produce a warning when used. We plan to remove it altogether in version 7.

We've deprecated Baseline in favor of a new command called Skip, which will be available in version 6.1.

The new Skip command allows you to skip migrations since the last applied migration, and up to a specified version. It works on a per-database basis, inserting a 'skipped' entry in the schema history table. See the [new documentation page for Skip](../documentation/command/skip) for more information.

Baseline is being deprecated because It's really just limited variation of the Skip behavior. Since it's designed for the initial deployment, it doesn't work on databases with an existing schema history table.

It could have been possible to expand the Baseline to allow re-setting the baseline up to any version. This would have the effect of 'skipping' migrations.

However, we think it makes sense to deprecate Baseline in favor of a more general Skip command.

Much of the motiviation and thought behind this decision is recorded in [this GitHub issue](https://github.com/flyway/flyway/issues/1986).

Deprecating a command is a significant change, and may be undesirable for some. If you have strong opinions about this, we'd like to hear your thoughts. Contact us through the usual channels - GitHub issues, email, or on Twitter [@flywaydb](https://twitter.com/flywaydb).