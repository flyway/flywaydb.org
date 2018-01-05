---
layout: documentation
menu: errorhandlers
subtitle: Error Handlers
---
# Error Handlers
{% include pro.html %}

When Flyway executes SQL statements it reports all warnings returned by the database. In case an error is returned
Flyway displays it with all necessary details, marks the migration as failed and automatically rolls it back if possible.

The error usually looks like this:

```
Migration V1__Create_person_table.sql failed
--------------------------------------------
SQL State  : 42001
Error Code : 42001
Message    : Syntax error in SQL statement "CREATE TABLE1[*] PERSON "; expected "OR, FORCE, VIEW, ...
Location   : V1__Create_person_table.sql (/flyway-tutorial/V1__Create_person_table.sql)
Line       : 1
Statement  : create table1 PERSON
```

This default behavior is great for the vast majority of the cases.
 
There are however situations where you may want to
- treat an error as a warning as you know your migration will handle it correctly later
- treat a warning as an error as you prefer to fail fast to be able to fix the problem sooner
- to perform an additional action when a specific error or warning is being emitted by the database

Flyway Pro and Enterprise Edition give you a way to achieve all these scenarios using **Error Handlers**.

## Implementation

An Error Handler is a Java class that implements the
[`org.flywaydb.core.api.errorhandler.ErrorHandler`](/documentation/api/javadoc/org/flywaydb/core/api/errorhandler/ErrorHandler.html) interface.

This interface has one method (`boolean handle(Context context)`) which is invoked whenever a database call results in
at least one warning or error. Your code can then inspect these errors and warnings and react accordingly. A specific
message can be logged or an exception can be thrown. Returning `true` indicates the errors and warnings were handled.
Returning `false` indicates Flyway should try the next `ErrorHandler` that was configured, or in case none are left,
fall back to its default behavior.

## Configuration

One or more Errors Handlers can be configured using the
[`flyway.errorHandlers`](http://localhost:4000/documentation/commandline/migrate#errorHandlers) property.
Error Handlers are invoked
in the order the are configured. If no Error Handlers are configured Flyway falls back to its default behavior.

## Example

By default when an Oracle stored procedure compilation fails, the driver simply returns a warning which is being output
by Flyway as

```
DB: Warning: execution completed with warning (SQL State: 99999 - Error Code: 17110)
```

Here is an example Error Handler that treats that warning as an error instead:

```java
package org.mycompany.mypkg;

import org.flywaydb.core.api.FlywayException;
import org.flywaydb.core.api.errorhandler.Context;
import org.flywaydb.core.api.errorhandler.ErrorHandler;
import org.flywaydb.core.api.errorhandler.Warning;

public class OracleProcedureFailFastErrorHandler implements ErrorHandler {
    @Override
    public boolean handle(Context context) {
        for (Warning warning : context.getWarnings()) {
            if ("99999".equals(warning.getState()) && warning.getCode() == 17110) {
                throw new FlywayException("Compilation failed");
            }
        }
        return false;
    }
}
```

If you now configure Flyway with

```
flyway.errorHandlers=org.mycompany.mypkg.OracleProcedureFailFastErrorHandler
```

all Oracle stored procedure compilation failures will result in an **immediate error** saying `Compilation failed`.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/migrate">Migrate <i class="fa fa-arrow-right"></i></a>
</p>