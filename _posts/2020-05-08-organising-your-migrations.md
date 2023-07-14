_Originally posted May 8th 2020 by Philip Liddell on flywaydb.org_

In Flyway 6.4.0 we introduced a new feature, support for wildcards in the locations. With this feature a new set of solutions to organizing your migration files has now become available. In this post we hope to detail some of them, to aid the users of Flyway in deciding the solution that best suits their environment.

Wildcards
---------

First let’s start by explaining what we mean by wildcards. Wildcards allow for matching patterns of paths instead of just a single one. Flyway will then use this pattern to search for all paths that match it, and returns all the migrations found beneath that folder, just as if the user had specified the path manually. The wildcards that Flyway supports are:

*   `**` : Matches any 0 or more directories
    *   e.g. `db/**/test` will match `db/version1.0/test`, `db/version2.0/test`, `db/development/version/1.0/test` but not `db/version1.0/release`
*   `*` : Matches any 0 or more non-separator characters
    *   e.g. `db/release1.*` will match `db/release1.0`, `db/release1.1`, `db/release1.123` but not `db/release2.0`)
*   `?` : Matches any 1 non-separator character
    *   e.g. `db/release1.?` will match `db/release1.0`, `db/release1.1` but not `db/release1.11`

Wildcards in practice
---------------------

### Release folder based structure

A common working pattern we have seen is to structure your migrations into ‘releases’. Each release is a package of migrations, along with tests for those migrations, probably developed on a branch of the project. When the release is ready the folder is brought into the trunk project, and Flyway will then pick up those new migrations and apply them.
```
 my-project
   release1.0
     migrations
       V1\_0\_\_createBaseStructure.sql
     test
       V1\_0\_1\_\_createTestData.sql
   release1.2
     migrations
       V1\_2\_\_createMoreTables.sql
     test
       V1\_2\_1\_\_createMoreTestData.sql
```
Ideally you could then specify `flyway.locations=filesystem:path/to/my-project` and it would pick up all the migrations immediately.

However, doing that means you cannot exclude the test migrations in production. You would either have to specify all the folders explicitly:

`flyway.locations=filesystem:path/to/my-project/release1.0/migrations,filesystem:path/to/my-project/release1.2/migrations` 

(extremely unwieldy to maintain as release count gets higher), or restructure your repository to put the test migrations somewhere else (maybe a separate `test` folder tree that matches the release folder tree). Neither solution is ideal.

With wildcards, there is a better solution. The wildcard path `flyway.locations=filesystem:path/to/my-project/*/migrations` will match all releases in the project with a migrations folder directly beneath them, and return only the migrations in that folder. Then on the test server you can add `filesystem:path/to/my-project/*/test` to the locations to execute the test migrations.

You can even go a step further and restrict the locations to `path/to/my-project/release-*/migrations` to only match folders that start with `release-`.

### Shared scripts

Let’s say you are developing a project that needs to work on multiple database types. Some of the scripts are shareable, some are not. You do however want to organize your scripts by test, or by feature, not by database.
```
 my-project
   table
     shared
       V1\_0\_\_createTableGeneric.sql
     oracle
       V1\_0\_1\_\_createPLSQLSpecificTable.sql
   function
     create
       shared
         V2\_0\_\_createGenericFunction.sql
       mysql
         V2\_0\_1\_\_createFunctionUsingMySQLProcedure.sql
```

Without using wildcards executing this would required specifying the subfolder for each database type manually, a real maintenance headache. However, with using wildcards you can provide the location:

`flyway.locations=filesystem:path/to/my-project/**/shared,filesystem:path/to/my-project/**/oracle`

to execute all the `shared` and `oracle` folders, no matter where the are in the project folder structure.

\- philip