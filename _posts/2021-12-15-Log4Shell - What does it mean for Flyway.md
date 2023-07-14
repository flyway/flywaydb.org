_Originally posted December 15 2021 by Barry Attwater on flywaydb.org_

There has been a lot of attention on Apache Log4J in the past week due to the discovery of the Log4Shell vulnerability. As Flyway allows utilization of Log4J we felt we should address this vulnerability and reassure our users.

**What is Log4Shell?**

It has recently been discovered that there is a high severity vulnerability in many versions of Log4J which has become known as "Log4Shell". This vulnerability allows for the remote execution of code and is included in many Java applications. This has been reported to have been fixed in Log4J version 2.16.

**Is Flyway affected?**

Not without user intervention.

Flyway’s dependency on Log4J is optional. In other words, our code is compiled with the understanding if the Log4J dependent code is to be used, Log4J will need to be externally supplied.

However, there are three main integrations methodologies with Flyway. These are Flyway Command-Line, Flyway Maven plugin and Flyway Java integration. Each handles logging differently so I will explain how each is affected separately.

For the Flyway Command-Line, we do not ship Log4J at all. By default, logged output will be directed to a built in logger which uses Standard Out and Standard Error to display on your console. If you wish to use Log4J with Flyway Command-Line, you will need to manually include the appropriate Log4J JAR files within the lib folder of Flyway Command-Line, keeping in mind which versions you are including.

For the Flyway Maven plugin, as with Flyway Command-Line, Log4J is not included. Logged output will be directed to the Maven Logger.

For the Java integrations, Log4J usage is down to the user’s configuration. In the current configuration; Flyway 8.2.3, we will import versions 2.16 up to 3.0 if they are on the class-path for use if use of Log4J is required. This is so we can integrate with the project’s current Log4J integration. Due to the recent developments with Log4Shell we have changed so we will not integrate with anything under 2.16. If you wish to use a previous version of Log4J, you will need to use an outdated Flyway version which still allows the vulnerable versions.

**So what should I do?**

Since Flyway does not control which version of Log4J is used you do not have to do anything with Flyway. However, we do always recommend using the latest version of Flyway which at this current time is 8.2.3. In regards to the Log4J libraries, if you do use Log4J, please follow your own upgrade policy and use the latest version of Log4J without the Log4Shell vulnerability.
