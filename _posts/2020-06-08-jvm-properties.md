---
layout: blog
subtitle: JVM Properties
permalink: /blog/jvm-properties.html
author: mikiel
---

At its core, Flyway is a Java library, though it hooks into many clients which are frequently used non-Java contexts. For non-Java contexts we'd like Flyway to be as platform agnostic as possible. Nonetheless, some Java specific concepts have to be exposed, like our use of Java Database Connectivity (JDBC) drivers.

The Flyway Command Line client in particular is designed to be generic, and behave like a native application. Nonetheless, sometimes it's necessary to deal with the underlying Java platform for advanced configuration, and to enable certain features.

In this blog post we're going to talk about one such case - setting Java Virtual Machine (JVM) properties in the Flyway command line.

## JVM properties and Flyway

To enable SSL connections with Flyway, it's necessary to set JVM properties. You may have stumbled upon sources telling you to set these two properties:

```
javax.net.ssl.trustStore
javax.net.ssl.trustStorePassword
```
(We've had a few [GitHub issues](https://github.com/flyway/flyway/issues/2788) about this topic already)

For the Java developers out there, you'll know how to set the JVM properties you need. If you use the Gradle or Maven plugin, you'll already have a mechanism to set these properties through your existing processes.

However, things are less clear for command line users. We can't assume that command line users are familiar with Java concepts like JVM properties.

Under the hood, the command line runs in its own pre-configured Java environment. Yet even knowing that, it isn't immediately obvious how to set the JVM properties.

The answer is to look in the command line's entry point file. This is either `flyway.cmd` or just `flyway`, depending on your platform.

Open this file, and look for a line like the following:

```
%JAVA_CMD% %JAVA_ARGS% -cp "%CLASSPATH%;%INSTALLDIR%\lib\*;%INSTALLDIR%\lib\%FLYWAY_EDITION%\*;%INSTALLDIR%\drivers\*" org.flywaydb.commandline.Main %*
```

This line uses your existing Java installation to kick off a Flyway process. For this blog I won't explain everything that's happening here - just notice the `%JAVA_ARGS%` token.

This is an environment variable that can be set before you start Flyway. This means you can supply arbitrary arguments to the `java` call that invokes Flyway, which includes setting JVM properties.

Therefore you can set properties in the [JVM command line format](https://stackoverflow.com/questions/44745261/why-do-jvm-arguments-start-with-d) in the `JAVA_ARGS` variable, and they will be directly passed to the `java` call.

For instance, in bash, to set the SSL JVM properties for the Flyway command line, set the `JAVA_ARGS` environment variable:

`export JAVA_ARGS="-Djavax.net.ssl.trustStore=~/truststore.jks -Djavax.net.ssl.trustStorePassword=myPassword"`

And then call Flyway as normal:

`./flyway migrate -url=jdbc:...`

This isn't limited to properties - you can set any JVM argument in this way. [This is an advanced usage scenario](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/java.html), so most won't need it. However the facility is there to give you more flexibility if necessary.