---
layout: default
tab: download
title: Commercial Licensing FAQ
---
# Commercial Licensing FAQ

Here are the answers to the most frequently asked questions regarding commercial licensing:

<div id="toc"></div>

If you can't find the answer to your question here, please contact us at **sales@flywaydb.org** and we'll be happy to help you.

## What are Flyway Pro Edition and Flyway Enterprise Edition?

Flyway Pro Edition and Flyway Enterprise Edition are supersets of Flyway Community Edition which add more functionality,
support older databases and Java runtimes and provide additional support options for customers.

## How long are database releases supported in each edition of Flyway?

The different editions of Flyway come with different support timeline guarantees for database releases. For Flyway
Community Edition a database release is guaranteed to be supported for 3 years from its GA (General Availability)
release date. Flyway Pro Edition extends this guaranteed support to 5 years and Flyway Enterprise Edition gives you
even stronger guarantees by extending it to a full 10 years. Each edition gives you the strong predictability you
need to be able to manage your database upgrade cycles at the pace you require.

Example: Oracle 12.2 went GA in March 2017. It is guaranteed to be compatible with Flyway Community Edition until at
least March 2020. After that date support will be retired from the Community Edition. With Flyway Pro Edition this
support then remains available until at least March 2022. After that date it will be retired from the Pro Edition, but
it is guaranteed to still remain available until at least March 2027 with Flyway Enterprise Edition. 

## Is there a trial version?

Yes there is. All you need to do is <a href="" data-toggle="modal" data-target="#flyway-trial-license-modal">request a trial license key</a>.
This license key is valid for 30 days and can be used with either Flyway Pro or Enterprise Edition. After 30 days
you must either upgrade to a full Flyway Pro Edition or Flyway Enterprise Edition license or downgrade to
Flyway Community Edition. The trial comes with the full functionality of the Flyway Pro or Enterprise Edition,
except for the source code, which is only available to paying customers.

## Do I have to set up a license server or open ports in my firewall?

No. Flyway does not need a license server and Flyway does not call home.

## What is the license?

Here is the [Flyway Pro Edition license](/licenses/flyway-pro) and here is the [Flyway Enterprise Edition license](/licenses/flyway-enterprise).

## How does Flyway Pro and Enterprise Edition licensing work?

Every organization running Flyway Pro or Enterprise Edition to manage databases on its own servers or cloud accounts
must have a license.
The price is based on the numbers of schemas in production managed by Flyway. You can use Flyway Pro or Enterprise with any
number of schemas as long as the number of schemas **in production** is smaller or equal to the licensed amount.
Development, test and staging environments are free and unlimited.

If you wish to expand your Flyway Pro or Enterprise Edition schema count beyond your current license, contact us at 
**sales@flywaydb.org** so we can update your account and let you know how we will bill you.

A site license (unlimited usage for your organization) is available for Flyway Pro Edition for 14,950 USD and
for Flyway Enterprise Edition for 44,950 USD per year.

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
- SQLite: `DATABASE` (no schema support)

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

## Can I upgrade from Flyway Pro Edition to Flyway Enterprise Edition?

Yes, contact us at **sales@flywaydb.org** so we can update your account and let you know how we will bill you.

## Can I distribute Flyway Pro Edition or Flyway Enterprise Edition to my customers?

This is a common requirement for "on-site installs" or "appliances" sold to large corporations.

The standard license is only appropriate for SaaS usage as it does not allow distribution.

If you only have 10 customers or less, the most cost effective approach is to have each of your customers
acquire their own Flyway Pro or Enterprise Edition license.

If this is not an option, or if you have more customers, Flyway Pro Edition and Flyway Enterprise Edition have a
Redistributable license option. The [Redistributable license](/licenses/flyway-pro-redistributable) is 9,500 USD per
year for Flyway Pro Edition and 29,500 USD per year for Flyway Enterprise Edition.
This license allows you to distribute the Pro or Enterprise Edition as part of your application to your
customers. One licence enables each of your customers to run Flyway Pro or Enterprise Edition to manage up
to 10 schemas in production (and an unlimited number of schemas in test) as part of your application only.
There is no limit to the number of customers.

Email **sales@flywaydb.org** to purchase.

## Can I use Flyway Pro or Enterprise Edition to manage my customers' databases?

Yes you can. If you want to install Flyway Pro or Enterprise Edition on your customer's machines along with your
application you need a redistributable license. See the previous question: [Can I distribute Flyway Pro Edition or Flyway Enterprise Edition to my customers?](#can-i-distribute-flyway-pro-edition-or-flyway-enterprise-edition-to-my-customers)

If you do not install Flyway on your customer's hardware, but do either run Flyway from your own machines or use
Flyway-generated dry run scripts to manage your customer's databases, each schema managed this way must be accounted
for as if it were a production schema within your own datacenter. See the previous question: [How are schemas counted?](how-are-schemas-counted)

## Can I pay via invoice and purchase order?

Flyway Pro Edition is credit card only, no exceptions.

Flyway Enterprise Edition customers can pay via invoice and get NET15 payment terms.

## What happens if you change your prices in the future?

We practice a fair pricing policy for our customers. If our prices go up, you will still pay your initial lower price
as long as you renew and your usage stays constant. If on the other our prices go down, we will automatically charge you the new lower
price at your next renewal.

{% include trialpopup.html %}