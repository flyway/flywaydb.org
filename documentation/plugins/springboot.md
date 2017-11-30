---
layout: documentation
menu: springboot
subtitle: 'Spring Boot'
---
# Spring Boot

<img src="/assets/logos/springboot.png" style="margin-bottom: 20px">

Spring Boot comes with out-of-the-box <a href="https://docs.spring.io/spring-boot/docs/current/reference/html/howto-database-initialization.html#howto-execute-flyway-database-migrations-on-startup">integration for Flyway</a>.

All you need to do is add `flyway-core` to either your `pom.xml`:
<pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>

Or `build.gradle`:

<pre class="prettyprint">compile "org.flywaydb:flyway-core:{{ site.flywayVersion }}"</pre>

Spring Boot will then automatically autowire Flyway with its DataSource and invoke it on startup.

You can then configure a good number of Flyway properties <a href="https://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html">directly from your <code>application.properties</code> or <code>application.yml file</code></a>.

<a class="inline-cta" href="https://boxfuse.com/blog/spring-boot-ec2"><i class="fa fa-cloud"></i> Want to deploy your Spring Boot apps effortlessly to AWS? Follow our <strong>5 minute</strong> tutorial using <img src="/assets/logo/boxfuse-logo-nano-blue.png"> Boxfuse <i class="fa fa-arrow-right"></i></a>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/plugins/grails">Grails <i class="fa fa-arrow-right"></i></a>
</p>