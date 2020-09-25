---
layout: default
tab: download
title: Commercial Licensing FAQ
---
# Commercial Licensing FAQ

Here are the answers to the most frequently asked questions regarding commercial licensing:

<div id="toc"></div>

If you can't find the answer to your question here, please contact us at **sales@flywaydb.org** and we'll be happy to help you.

## What is Flyway Teams Edition?

Flyway Teams Edition is a superset of Flyway Community Edition which adds more functionality,
supports older databases, and provides additional support options for customers.

## What happened to Flyway Pro and Enterprise Edition?

Historically Flyway had two paid for editions called Pro and Enterprise. As of Flyway's version 7.0 release, these two editions have been combined into a new edition called Flyway Teams. Flyway Teams provides the extra functionality that Enterprise Edition once did.

Existing Pro and Enterprise license keys will continue to work with Flyway Teams Edition for as long as they are valid. Pro Edition customers are essentially 'upgraded' to Teams.

## How long are database releases supported in each edition of Flyway?

The different editions of Flyway come with different support timeline guarantees for database releases. For Flyway
Community a database release is guaranteed to be supported for 5 years from its GA (General Availability)
release date. Flyway Teams Edition gives you
stronger guarantees by extending it to a full 10 years. Each edition gives you the strong predictability you
need to be able to manage your database upgrade cycles at the pace you require.

Example: Oracle 12.2 went GA in March 2017. It is guaranteed to be compatible with Flyway Community until at
least March 2022. After that date support will be retired from Community Edition, but it is guaranteed to still remain available until at least March 2027 with Flyway Teams Edition. 

## Is there a trial version?

Yes there is. All you need to do is <a href="" data-toggle="modal" data-target="#flyway-trial-license-modal">request a trial license key</a>.
This license key is valid for 30 days and can be used with Flyway Teams. After 30 days
you must either upgrade to a full Flyway Teams Edition license or downgrade to
Flyway Community Edition. The trial comes with the full functionality of the Flyway Teams Edition,
except for the source code, which is only available to paying customers.

## Do I have to set up a license server or open ports in my firewall?

No. Flyway does not need a license server and Flyway does not call home.

## What is the license?

Here is the [Flyway Teams Edition license](/licenses/flyway-teams).

## How does Flyway Teams Edition licensing work?

Every organization running Flyway Teams Edition to manage databases on its own servers or cloud accounts
must have a license.
The price is based on the numbers of schemas in production managed by Flyway. You can use Flyway Teams with any
number of schemas as long as the number of schemas **in production** is smaller or equal to the licensed amount.
Development, test and staging environments are free and unlimited.

If you wish to expand your Flyway Teams Edition schema count beyond your current license, contact us at 
**sales@flywaydb.org** so we can update your account and let you know how we will bill you.

## What exactly is a schema?

With schema we mean the container for database objects commonly referred to as "schema" and usually created using the
`CREATE SCHEMA` DDL statement. This is the exact meaning for schema for each of the supported databases:

- Oracle: `USER` (which is essentially a schema + a user)
- SQL Server: `SCHEMA`
- DB2: `SCHEMA`
- MySQL: `DATABASE` or `SCHEMA` (both are synonyms)
- MariaDB: `DATABASE` or `SCHEMA` (both are synonyms)
- PostgreSQL: `SCHEMA`
- Redshift: `SCHEMA`
- CockroachDB: `DATABASE` (no schema support)
- SAP HANA: `SCHEMA`
- Sybase ASE: `DATABASE` (no schema support)
- Informix: `DATABASE` (no schema support)
- H2: `SCHEMA`
- HSQLDB: `SCHEMA`
- Derby: `SCHEMA`
- Snowflake: `SCHEMA`
- SQLite: `DATABASE` (no schema support)
- Firebird: `DATABASE` (no schema support)

## How are schemas counted?

Say you have 3 SQL Server instances, each running 5 databases, with each database containing 10 schemas.<br>
This amounts to *5 x 10 schemas = 50 schemas*. How the schemas are spread among databases and database instances
doesn't matter. 

If a schema is replicated across multiple database instances, each replica must be accounted for.
This means that if you have 1 schema replicated across 5 database instances, it counts as *5 x 1 schema = 5 schemas*.

Only the schemas *managed by Flyway* in the *production environment* count.
Needless to say if a schema is not managed by Flyway, there is no charge.<br>
Also dev, test and staging environments are free and unlimited.

Note that both schemas managed by Flyway directly using a database connection as well as schemas managed by 
Flyway-generated dry run scripts must be counted.

## Why does it show a higher price when I try to purchase?

Our prices do not include VAT or sales tax. In some countries, like the EU or Norway for example, VAT gets added to the
price at the time of purchase. You can remove the VAT by clicking the "Enter VAT ID" link in the store and entering your
company's VAT ID. After the VAT is removed the price will once again match the advertised one. 

## Is there a discount if I pay for multiple years upfront?

Yes, there is for Flyway Enterprise Edition. When you pay for multiple years upfront we do offer you a 5% discount
on the price for year 2, 10% for year 3, 15% for year 4 and 20% for year 5 and all subsequent years.

For example, if you choose to license Flyway Enterprise Edition (10 schemas):
- the price for 1 year is 2,950 USD
- the price for 3 years is 8,407.5 USD = 2,950 USD + (2,950 USD x 0.95) + (2,950 USD x 0.90). Yearly average: 2,802.5 USD (5% discount) 
- the price for 5 years is 13,275 USD = price for 3 years + (2,950 USD x 0.85) + (2,950 USD x 0.80). Yearly average: 2,655 USD (10% discount) 
- the price for 10 years is 25,075 USD = price for 5 years + 5 x (2,950 USD x 0.80). Yearly average: 2,507.5 USD (15% discount) 

## Can I distribute Flyway Teams Edition to my customers?

This is a common requirement for "on-site installs" or "appliances" sold to large corporations.

The standard license is only appropriate for SaaS usage as it does not allow distribution.

If you only have 10 customers or less, the most cost effective approach is to have each of your customers
acquire their own Flyway Teams Edition license.

If this is not an option, or if you have more customers, Flyway Teams Edition has a
Redistributable license option. The [Redistributable license](/licenses/flyway-pro-redistributable) is 29,500 USD per year for Flyway Teams Edition.
This license allows you to distribute the Teams Edition as part of your application to your
customers. One licence enables each of your customers to run Flyway Teams Edition to manage up
to 10 schemas in production (and an unlimited number of schemas in test) as part of your application only.
There is no limit to the number of customers.

Email **sales@flywaydb.org** to purchase.

## Can I use Flyway Teams Edition to manage my customers' databases?

Yes you can. If you want to install Flyway Teams on your customer's machines along with your
application you need a redistributable license. See the previous question: [Can I distribute Flyway Teams to my customers?](#can-i-distribute-flyway-teams-edition-to-my-customers)

If you do not install Flyway on your customer's hardware, but do either run Flyway from your own machines or use
Flyway-generated dry run scripts to manage your customer's databases, each schema managed this way must be accounted
for as if it were a production schema within your own datacenter. See the previous question: [How are schemas counted?](#how-are-schemas-counted)

## Can I pay via invoice and purchase order?

Flyway Teams Edition customers can pay via invoice and get NET15 payment terms.

{% include trialpopup.html %}