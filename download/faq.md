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

Flyway Pro Edition and Flyway Enterprise Edition are supersets of Flyway Community Edition which add more functionality, support older databases and Java runtimes
and provide additional support options for customers.

## Is there a trial version?

There is a trial version which you can [download directly from the pricing page](https://flywaydb.org/download/).
This trial is valid for 30 days, after which you must
either upgrade to Flyway Pro Edition or Flyway Enterprise Edition or downgrade to Flyway Community Edition. The trial comes
with the full functionality of Flyway Enterprise Edition, except the source code, which is only available to paying customers.

## Do I have to set up a license server or open ports in my firewall?

No. No Flyway Edition needs a license server and no Flyway Edition calls home.

## What is the license?

Here is the [Flyway Pro Edition license](/licenses/flyway-pro) and here is the [Flyway Enterprise Edition license](/licenses/flyway-enterprise).

## How does Pro licensing work?

Every organization running Flyway Pro Edition on its own servers or cloud accounts must have a license. The Flyway Pro
Edition is limited to 10 schemas in the production environment being managed by Flyway. If you need more than that, you
must acquire an Enterprise license.

## How does Enterprise licensing work?

Every organization running Flyway Edition Edition on its own servers or cloud accounts must have a license.
The price is based on the numbers of schemas in production managed by Flyway. You can use Flyway Enterprise with any
number of schemas as long as the number of schemas **in production** is smaller or equal to the licensed amount.
Development, test and staging environments are free and unlimited.

If you wish to expand your Flyway Enterprise Edition schema count beyond your current license, contact us at 
**sales@flywaydb.org** so we can update your account and let you know how we will bill you.

A site license (unlimited usage for your organization) for Flyway Enterprise Edition is available for 19,950 USD per year.

## What exactly counts as a schema?

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
- H2: `SCHEMA`
- HSQLDB: `SCHEMA`
- Derby: `SCHEMA`
- SQLite: `DATABASE` (no schema support)

## How are schemas counted?

Say you have 3 SQL Server instances, each running 5 databases, with each database containing 10 schemas.<br>
This amounts to *5 x 10 schemas = 50 schemas*. How the schemas are spread among databases and database instances
doesn't matter. 

Only the schemas *managed by Flyway* in the *production environment* count.
Needless to say if a schema is not managed by Flyway, there is no charge.<br>
Also dev, test and staging environments are free and unlimited.

## Why does it show a higher price when I try to purchase?

Our prices do not include VAT or sales tax. In some countries, like the EU or Norway for example, VAT gets added to the
price at the time of purchase. You can remove the VAT by clicking the "Enter VAT ID" link in the store and entering your
company's VAT ID. After the VAT is removed the price will once again match the advertised one. 

## Can I upgrade from Flyway Pro Edition to Flyway Enterprise Edition?

Yes, contact us at **sales@flywaydb.org** so we can update your account and let you know how we will bill you.

## Can I distribute Flyway Pro Edition or Flyway Enterprise Edition to my customers?

This is a common requirement for "on-site installs" or "appliances" sold to large corporations.

The standard license is only appropriate for SaaS usage as it does not allow distribution.
Flyway Pro Edition and Flyway Enterprise Edition have a Redistributable license option which does allow you to
distribute them. The Redistributable license is 9,950 USD per year for Pro and 29,950 USD per year for Enterprise.
It allows you to distribute the Pro or Enterprise Edition as part of your application and each of your customers to
run Flyway Pro or Enterprise Edition with up to 10 schemas as part of your application only.
Email **sales@flywaydb.org** to purchase.

## Can I use Flyway Pro or Enterprise Edition to migrate my customers' databases?

See the previous question: [Can I distribute Flyway Pro Edition or Flyway Enterprise Edition to my customers?](#can-i-distribute-flyway-pro-edition-or-flyway-enterprise-edition-to-my-customers)

## Can I pay via invoice and purchase order?

Flyway Pro Edition is credit card only, no exceptions.

Flyway Enterprise Edition customers can pay via invoice and get NET15 payment terms.