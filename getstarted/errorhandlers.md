---
layout: getstarted
menu: errorhandlers
subtitle: 'Tutorial: Error Handlers'
---
# Tutorial: Error Handlers
{% include pro.html %}

This tutorial assumes you have successfully completed the [**First Steps: Maven**](/getstarted/firststeps/maven)
tutorial. **If you have not done so, please do so first.** This tutorial picks up where that one left off.

This brief tutorial will teach **how to use Error Handlers**. It will take you through the
steps on how to create and use them.

## Introduction

**Error Handlers** are a great fit for situations where you may want to:
- treat an error as a warning as you know your migration will handle it correctly later
- treat a warning as an error as you prefer to fail fast to be able to fix the problem sooner
- perform an additional action when a specific error or warning is being emitted by the database

## Reviewing the status

After having completed the [First Steps: Maven](/getstarted/firststeps/maven), you can now execute

<pre class="console"><span>bar&gt;</span> mvn flyway:<strong>info</strong></pre>

This should give you the following status:

<pre class="console">[INFO] Database: jdbc:h2:file:./target/foobar (H2 1.4)
[INFO]
+-----------+---------+---------------------+------+---------------------+---------+
| Category  | Version | Description         | Type | Installed On        | State   |
+-----------+---------+---------------------+------+---------------------+---------+
| Versioned | 1       | Create person table | SQL  | 2017-12-22 15:26:39 | Success |
| Versioned | 2       | Add people          | SQL  | 2017-12-22 15:28:17 | Success |
+-----------+---------+---------------------+------+---------------------+---------+</pre>

## Adding a broken migration

In this tutorial we're going to simulate the case where a broken sql statement should be ignored.

So let's start by adding a new migration called `src/main/resources/db/migration/V3__Invalid.sql`:
```sql
broken sql statement;
```

If we migrate the database using
<pre class="console"><span>bar&gt;</span> mvn flyway:<strong>migrate</strong></pre> 
 
it will fail as expected:
<pre class="console">[ERROR] Migration V3__Invalid.sql failed
[ERROR] --------------------------------
[ERROR] SQL State  : 42001
[ERROR] Error Code : 42001
[ERROR] Message    : Syntax error in SQL statement "BROKEN[*] SQL STATEMENT "; expected "BACKUP, BEGIN, {"; SQL statement:
[ERROR] broken sql statement [42001-191]
[ERROR] Location   : /bar/src/main/resources/db/migration/V3__Invalid.sql (/bar/src/main/resources/db/migration/V3__Invalid.sql)
[ERROR] Line       : 1
[ERROR] Statement  : broken sql statement</pre> 

## Creating an Error Handler

Now let's create an Error Handler that will trap invalid statements in our migrations and simply log a warning instead of failing with an error.

Start by
- adding the `flyway-core` dependency to our `pom.xml`
- configuring the Java compiler for Java 8
- configuring Flyway to use our new error handler

```xml
<project xmlns="...">
    ...
    <dependencies>
        <dependency>
            <groupId>org.flywaydb.pro</groupId>
            <artifactId>flyway-core</artifactId>
            <version>{{ site.flywayVersion }}</version>
        </dependency>
        ...
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.7.0</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.flywaydb</groupId>
                <artifactId>flyway-maven-plugin</artifactId>
                <version>{{ site.flywayVersion }}</version>
                <configuration>
                    <url>jdbc:h2:file:./target/foobar</url>
                    <user>sa</user>
                    <errorHandlers>
                        <errorHandler>db.errorhandler.InvalidStatementErrorHandler</errorHandler>
                    </errorHandlers>
                </configuration>
                <dependencies>
                    <dependency>
                        <groupId>com.h2database</groupId>
                        <artifactId>h2</artifactId>
                        <version>1.4.191</version>
                    </dependency>
                </dependencies>
            </plugin>
        </plugins>
    </build>
</project>
```

Now create the migration directory `src/main/java/db/errorhandler`.
    
Followed by the error handler called `src/main/java/db/errorhandler/InvalidStatementErrorHandler.java`:
```java
package db.errorhandler;

import org.flywaydb.core.api.errorhandler.Context;
import org.flywaydb.core.api.errorhandler.Error;
import org.flywaydb.core.api.errorhandler.ErrorHandler;
import org.flywaydb.core.api.logging.Log;
import org.flywaydb.core.api.logging.LogFactory;

public class InvalidStatementErrorHandler implements ErrorHandler {
    private static final Log LOG = LogFactory.getLog(InvalidStatementErrorHandler.class);

    @Override
    public boolean handle(Context context) {
        for (Error error : context.getErrors()) {
            if ("42001".equals(error.getState()) && error.getCode() == 42001) {
                LOG.warn("Ignoring invalid statement");
                return true;
            }
        }
        return false;
    }
}
```

Finally compile the project, clean and migrate again using
<pre class="console"><span>bar&gt;</span> mvn clean compile flyway:clean flyway:migrate</pre>

And we now get:

<pre class="console">[INFO] Database: jdbc:h2:file:./target/foobar (H2 1.4)
[INFO] Successfully validated 3 migrations (execution time 00:00.007s)
[INFO] Creating Schema History table: "PUBLIC"."flyway_schema_history"
[INFO] Current version of schema "PUBLIC": << Empty Schema >>
[INFO] Migrating schema "PUBLIC" to version 1 - Create person table
[INFO] Migrating schema "PUBLIC" to version 2 - Add people
[INFO] Migrating schema "PUBLIC" to version 3 - Invalid
<strong>[WARNING] Ignoring invalid statement</strong>
[INFO] Successfully applied 3 migrations to schema "PUBLIC" (execution time 00:00.039s)</pre>

And as we were expecting we now had a successful execution with a warning instead of an error.

## Summary

In this brief tutorial we saw how to
- create Error Handlers
- configure Flyway to load and execute them

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/errorhandlers">Read the Error Handlers documentation <i class="fa fa-arrow-right"></i></a>
</p>