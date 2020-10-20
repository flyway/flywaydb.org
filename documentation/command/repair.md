---
layout: documentation
menu: repair
subtitle: Repair
---
# Repair

Repairs the schema history table.

![Repair](/assets/balsamiq/command-repair.png)

Repair is your tool to fix issues with the schema history table. It has a few main uses:
- Remove failed migration entries (only for databases that do NOT support DDL transactions)
- Realign the checksums, descriptions, and types of the applied migrations with the ones of the available migrations
- Mark all missing migrations as **deleted**

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
			<a href="/documentation/usage/commandline/repair" class="btn btn-primary">How to repair in the
				Command-line Tool <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-maven">
			<a href="/documentation/usage/maven/repair" class="btn btn-primary">How to repair in the
				Maven Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
		<div class="tab-pane" id="tab-gradle">
			<a href="/documentation/usage/gradle/repair" class="btn btn-primary">How to repair in the
				Gradle Plugin <i class="fa fa-arrow-right"></i></a>
		</div>
	</div>
</div>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/usage/commandline/">Command-line <i class="fa fa-arrow-right"></i></a>
</p>