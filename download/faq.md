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
Community and Pro Editions a database release is guaranteed to be supported for 5 years from its GA (General Availability)
release date. Flyway Enterprise Edition gives you
stronger guarantees by extending it to a full 10 years. Each edition gives you the strong predictability you
need to be able to manage your database upgrade cycles at the pace you require.

Example: Oracle 12.2 went GA in March 2017. It is guaranteed to be compatible with Flyway Community and Pro Editions until at
least March 2022. After that date support will be retired from the Community and Pro Editions, but it is guaranteed to still remain available until at least March 2027 with Flyway Enterprise Edition. 

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
- Google Cloud Spanner: `DATABASE` (no schema support)
- SQLite: `DATABASE` (no schema support)
- Firebird: `DATABASE` (no schema support)

## How are schemas counted?

Say you have 1 SQL Server instance running 5 databases, with each database containing 10 schemas.<br>
This amounts to *5 x 10 schemas = 50 schemas*. How the schemas are spread among databases and database instances doesn’t matter.

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

## What license term options are available?

Flyway subscriptions can be purchased for one, two or three year terms giving you the flexibility to choose the best term length for your needs.  By opting for the two or three year terms you are able to lock in the current annual rate for the duration of the subscription keeping you on the best possible rate moving forwards. 

## Can I upgrade from Flyway Pro Edition to Flyway Enterprise Edition?

Yes, contact us at **sales@flywaydb.org** so we can update your account and let you know how we will bill you.

## How can I pay and see my licenses?

We can arrange an invoice for your Flyway licenses for both our Pro and Enterprise tiers.  You can register for a Redgate Account on our website [www.red-gate.com](https://www.red-gate.com) to give you full visibility and management of your licenses.


{% include trialpopup.html %}