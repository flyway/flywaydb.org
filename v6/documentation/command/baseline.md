---
layout: documentation
menu: baseline
subtitle: Baseline
---
# Baseline

Baselines an existing database, excluding all migrations up to and including baselineVersion.

![Baseline](/assets/balsamiq/command-baseline.png)

Baseline is for introducing Flyway to [existing databases](/documentation/existing) by baselining them
at a specific version. This will cause [Migrate](/documentation/command/migrate) to ignore all migrations
up to and including the baseline version. Newer migrations will then be applied as usual.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/repair">Repair <i class="fa fa-arrow-right"></i></a>
</p>
