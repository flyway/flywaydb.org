---
layout: default
tab: download
title: Download / Pricing
cssid: download-pricing
redirect_from: /licenses/flyway-trial
---

<h1 style="text-align:left">Choose your Flyway Edition</h1>

<p style="text-align:left">Choose your Flyway edition based on the features and support level you require</p>

<table class="table table-striped table-left">
<thead>
<tr>
<th></th>
<th>Community Edition</th>
<th>Teams Edition</th>
</tr>
</thead>
<tr><td>Price</td><td>Free</td><td>3000 USD per year<br><span class="note">per 10 schemas in production<br>(25 USD per schema per month)<br>unlimited for dev and test</span></td></tr>
<tr><td><a href="/documentation/concepts/migrations#sql-based-migrations">SQL-based migrations</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/migrations#java-based-migrations">Java-based migrations</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/migrations#repeatable-migrations">Repeatable migrations</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/placeholders">Placeholder replacement</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/callbacks">Callbacks</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/usage/commandline/#machine-readable-output">Machine readable output</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/blog/Configure-resource-providers">Custom migration resolvers/executors</a></td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td>Safe for multiple nodes in parallel</td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td>Native SQL dialect support (PL/SQL, SQLPL, T-SQL, ...)</td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td>Java 8/9/10/11/12/13 compatibility</td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/download/faq#how-long-are-database-releases-supported-in-each-edition-of-flyway">Guaranteed database support timeline</a></td><td>5 years</td><td>10 years</td></tr>
<tr><td><a href="/documentation/configuration/parameters/locations#amazon-s3">Amazon S3 locations</a></td><td>Up to 100 migrations</td><td>Unlimited</td></tr>
<tr><td><a href="/documentation/configuration/parameters/locations#google-cloud-storage">Google cloud storage locations</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/migrations#script-migrations">Arbitrary script migrations</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/database/oracle#sqlplus-commands">Oracle SQL*Plus compatibility</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/erroroverrides">Error Overrides</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/callbacks#beforeEachMigrateStatement">Statement-level callbacks</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/dryruns">Dry runs</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/command/undo">Undo</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/parameters/batch">Batching</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/parameters/stream">Streaming</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/parameters/cherryPick">Cherry picking</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/parameters/skipExecutingMigrations">Mark as applied</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/concepts/migrations#query-results">Toggle display of query results</a></td><td></td><td><i class="fa fa-check"></i></td></tr>
<tr><td><a href="/documentation/configuration/authentication">Supported authentication mechanisms</a></td><td>7</td><td>9</td></tr>
<tr><td>License</td><td><a href="/licenses/flyway-community">Apache v2</a></td><td><a href="/licenses/flyway-teams">Commercial</a></td></tr>
<tr><td>Maven Repository</td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td>Source Code included</td><td><i class="fa fa-check"></i></td><td><i class="fa fa-check"></i></td></tr>
<tr><td>Support</td><td><a href="/community">Community</a></td><td>Email (2 business days)</td></tr>
<tr><td>Automatic renewal</td><td></td><td>optional</td></tr>
<tr><td>Payment methods accepted</td><td></td><td>Credit card, wire transfer, purchase order</td></tr>
<tr><td></td><td><a class="btn btn-primary btn-download" href="/download/community">Download <i class="fa fa-arrow-right"></i><br><span class="note">Community</span></a></td>
<td><button class="btn btn-primary btn-download" data-toggle="modal" data-target="#flyway-trial-license-modal">Start Free Trial <i class="fa fa-arrow-right"></i><br><span class="note">License key for 28 days</span></button></td>
</tr>
<tr><td></td>
<td></td>
<td><a class="btn btn-success btn-download" href="/download/teams"><strong>Pricing Details</strong> <i class="fa fa-arrow-right"></i></a></td>
</tr>
</table>

Any questions regarding licensing?<br>
Read the [**Commercial Licensing FAQ**](/download/faq)

We also offer discounts for multi-year upfront payments and redistributable licenses.<br>
Contact us for more information at **sales@flywaydb.org**.

{% include trialpopup.html %}