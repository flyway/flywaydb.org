---
layout: documentation
menu: migrate
subtitle: Migrate
---
# Migrate

Migrates the schema to the latest version. Flyway will create the schema history table automatically if it doesn't exist.

![Migrate](/assets/balsamiq/command-migrate.png)

Migrate is the centerpiece of the Flyway workflow. It will scan the filesystem or your classpath for available migrations.
It will compare them to the migrations that have been applied to the database. If any difference is found, it will
migrate the database to close the gap.

Migrate should preferably be executed on application startup to avoid any incompatibilities between the database
    and the expectations of the code.

## Behavior

Executing migrate is idempotent and can be done safely regardless of the current version of the schema.

#### Example 1: We have migrations available up to version 9, and the database is at version 5.

Migrate will apply the migrations 6, 7, 8 and 9 in order.

#### Example 2: We have migrations available up to version 9, and the database is at version 9.

Migrate does nothing.

## Usage
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
			<a href="/documentation/usage/commandline/migrate" class="btn btn-primary">How to migrate in the
				Command-line Tool <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-maven">
			<a href="/documentation/usage/maven/migrate" class="btn btn-primary">How to migrate in the
				Maven Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-gradle">
			<a href="/documentation/usage/gradle/migrate" class="btn btn-primary">How to migrate in the
				Gradle Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
	</div>
</div>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/clean">Clean <i class="fa fa-arrow-right"></i></a>
</p>