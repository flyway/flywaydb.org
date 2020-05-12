---
layout: blog
subtitle: JVM Properties
permalink: /blog/jvm-properties.html
author: mikiel
---

Flyway is built with Java, although many of our users aren't necessarily familiar with Java. We try and hide the specifics to make Flyway as accessible as possible. However some concepts have to be exposed, like our use of JDBC drivers.

Our aim is that users shouldn't worry about the underlying technology unless they have to. For instance, in most cases the Flyway command line should run like any native application.

Nonetheless, sometimes it's necessary to talk Java specifics to enable certain features in Flyway. In this blog post we're going to talk about setting Java Virtual Machine (JVM) properties in the Flyway command line.

## JVM properties and Flyway

Sometimes it's necessary to set JVM properties to enable certain features in Flyway. One example is SSL connections.

If you want SSL with Flyway, you may have stumbled upon sources telling you to set these two JVM properties:

```
javax.net.ssl.trustStore
javax.net.ssl.trustStorePassword
```
(We've had a few [GitHub issues](https://github.com/flyway/flyway/issues/2788) about this topic already)

For the Java developers out there, you'll know how to set the JVM properties you need. So if you use the Flyway Gradle or Maven plugin, you'll already have a mechanism to do this through your existing deployment process.

However, since the command line runs it it's own pre-configured Java environment, it isn't immediately obvious how to set JVM properties for it. Also, we appreciate that not all command line users are Java experts, so I'm sure it's even less clear for those users.

The answer is to look in the Flyway entry point file in the command line bundle (`.zip` or `.tar.gz`). This is either `flyway.cmd` or just `flyway`, depending on your platform.

Open this file, and look for a line like the following:

```
%JAVA_CMD% %JAVA_ARGS% -cp "%CLASSPATH%;%INSTALLDIR%\lib\*;%INSTALLDIR%\lib\%FLYWAY_EDITION%\*;%INSTALLDIR%\drivers\*" org.flywaydb.commandline.Main %*
```

This line uses your Java installation to kick off a Flyway process. You don't need to understand everything here - just notice the `%JAVA_ARGS%` token.

This is an environment variable that can be set before you start Flyway. This means you can supply arbitrary arguments to the `java` call that invokes Flyway, which includes setting JVM properties.

So, you can set properties in the [JVM command line format](https://stackoverflow.com/questions/44745261/why-do-jvm-arguments-start-with-d) in the `JAVA_ARGS` variable, and they will be directly passed to the `java` call.

For instance, in bash, to set the SSL JVM properties for the Flyway command line, set the `JAVA_ARGS` environment variable:

`export JAVA_ARGS="-Djavax.net.ssl.trustStore=~/truststore.jks -Djavax.net.ssl.trustStorePassword=myPassword"`

And then call Flyway as normal:

`./flyway migrate -url=jdbc:...`

This isn't limited to properties - you can set any JVM argument in this way. [This is an advanced usage scenario](https://docs.oracle.com/javase/7/docs/technotes/tools/windows/java.html) and I doubt many will need it. However the facility is there, to give you the more flexibility if you have very specific requirements.