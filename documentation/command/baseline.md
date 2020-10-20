---
layout: documentation
menu: baseline
subtitle: Baseline
---
# Baseline

Baselines an existing database, excluding all migrations up to and including baselineVersion.

![Baseline](/assets/balsamiq/command-baseline.png)

Baseline is for introducing Flyway to [existing databases](/documentation/learnmore/existing) by baselining them
at a specific version. This will cause [Migrate](/documentation/command/migrate) to ignore all migrations
up to and including the baseline version. Newer migrations will then be applied as usual.

## Usage
See [configuration](/documentation/configuration/parameters/#baseline) for baseline specific configuration parameters.
<div class="tabbable">
	<ul class="nav nav-tabs">
		<li class="active marketing-item"><a href="#tab-commandline" data-toggle="tab"><i class="fa fa-desktop"></i>
			Command-line</a></li>
		<li class="marketing-item"><a href="#tab-maven" data-toggle="tab"><i class="fa fa-maxcdn"></i> Maven</a>
		</li>
		<li class="marketing-item"><a href="#tab-gradle" data-toggle="tab"><i class="fa fa-cogs"></i> Gradle</a>
		</li>
	</ul>
	<div class="tab-content">
		<div class="tab-pane active" id="tab-commandline">
			<a href="/documentation/usage/commandline/baseline" class="btn btn-primary">How to baseline in the
				Command-line Tool <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-maven">
			<a href="/documentation/usage/maven/baseline" class="btn btn-primary">How to baseline in the
				Maven Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-gradle">
			<a href="/documentation/usage/gradle/baseline" class="btn btn-primary">How to baseline in the
				Gradle Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
	</div>
</div>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/repair">Repair <i class="fa fa-arrow-right"></i></a>
</p>
