---
layout: documentation
menu: clean
subtitle: Clean
---
# Clean

Drops all objects in the configured schemas.

![Clean](/assets/balsamiq/command-clean.png)

Clean is a great help in development and test. It will effectively give you a fresh start, by wiping your configured
    schemas completely clean. All objects (tables, views, procedures, ...) will be dropped.

Needless to say: **do not use against your production DB!**

## Usage
See [configuration](/documentation/configuration/parameters/#clean) for clean specific configuration parameters.
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
			<a href="/documentation/usage/commandline/clean" class="btn btn-primary">How to clean in the
				Command-line Tool <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-maven">
			<a href="/documentation/usage/maven/clean" class="btn btn-primary">How to clean in the
				Maven Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-gradle">
			<a href="/documentation/usage/gradle/clean" class="btn btn-primary">How to clean in the
				Gradle Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
	</div>
</div>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/info">Info <i class="fa fa-arrow-right"></i></a>
</p>