---
layout: documentation
menu: validate
subtitle: Validate
---
# Validate

Validates the applied migrations against the available ones.

![Validate](/assets/balsamiq/command-validate.png)

Validate helps you verify that the migrations applied to the database match the ones available locally.

This is very useful to detect accidental changes that may prevent you from reliably recreating the schema.

Validate works by storing a checksum (CRC32 for SQL migrations) when a migration is executed. The validate mechanism checks if the migration locally still has the same checksum as the migration already executed in the database.

## Usage
See [configuration](/documentation/configuration/parameters/#validate) for validate specific configuration parameters.
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
			<a href="/documentation/usage/commandline/validate" class="btn btn-primary">How to validate in the
				Command-line Tool <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-maven">
			<a href="/documentation/usage/maven/validate" class="btn btn-primary">How to validate in the
				Maven Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-gradle">
			<a href="/documentation/usage/gradle/validate" class="btn btn-primary">How to validate in the
				Gradle Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
	</div>
</div>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/undo">Undo <i class="fa fa-arrow-right"></i></a>
</p>