---
layout: documentation
menu: experimentalfeatures
subtitle: Experimental Features
---

# Experimental Features
{% include teams.html %}

This is a list of experimental features in Flyway that require setting a feature flag to use.

To use them, you must set the environment variable `FLYWAY_EXPERIMENTAL_FEATURES_ENABLED` to `true`.

- ### `target=next`

By providing `next` as a [target](/documentation/configuration/parameters/target) to Flyway, Flyway will only execute the next migration along with any repeatable migrations that need applying.
