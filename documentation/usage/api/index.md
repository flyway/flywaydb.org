---
layout: api
pill: overview
subtitle: API
redirect_from: /documentation/api/
---
# API

Flyway brings the largest benefits when **integrated within an application**. By integrating Flyway
you can ensure that the application and its **database will always be compatible**, with no manual
intervention required. Flyway checks the version of the database and applies new migrations automatically
**before** the rest of the application starts. This is important, because the database must first
be migrated to a state the rest of the code can work with.

## Supported Java Versions

- `Java 12`
- `Java 11`
- `Java 10`
- `Java 9`
- `Java 8`
- `Java 7` {% include teams.html %}

## Download

<div class="tabbable">
    <ul class="nav nav-tabs">
        <li class="active marketing-item"><a href="#tab-community" data-toggle="tab">Community Edition</a>
        </li>
        <li class="marketing-item"><a href="#tab-teams" data-toggle="tab">Teams Edition</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab-community">
<table class="table">
    <tr>
        <th>Maven</th>
        <td>
            <pre class="prettyprint">&lt;dependencies&gt;
    ...
    &lt;dependency&gt;
        &lt;groupId&gt;org.flywaydb&lt;/groupId&gt;
        &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
        &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
    &lt;/dependency&gt;
    ...
&lt;/dependencies&gt;</pre>
        </td>
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">dependencies {
    compile "org.flywaydb:flyway-core:{{ site.flywayVersion }}"
}</pre>
        </td>
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.sha1">sha1</a>
        </td>
    </tr>
    <tr>
        <th>Sources</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}-sources.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar.sha1">sha1</a>
        </td>
    </tr>
</table>
        </div>
<div class="tab-pane" id="tab-teams">
<table class="table">
    <tr>
        <th>Maven</th>
        <td>
            <pre class="prettyprint">&lt;repositories&gt;
    ...
    &lt;repository&gt;
        &lt;id&gt;redgate&lt;/id&gt;
        &lt;url&gt;https://download.red-gate.com/maven/release&lt;/url&gt;
    &lt;/repository&gt;
    ...
&lt;/repositories&gt;
&lt;dependencies&gt;
    ...
    &lt;dependency&gt;
        &lt;groupId&gt;org.flywaydb<strong>.enterprise</strong>&lt;/groupId&gt;
        &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
        &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
    &lt;/dependency&gt;
    ...
&lt;/dependencies&gt;</pre>
        </td>
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">repositories {
    mavenCentral()
    maven {
        url "https://download.red-gate.com/maven/release"
    }
}
dependencies {
    compile "org.flywaydb<strong>.enterprise</strong>:flyway-core:{{ site.flywayVersion }}"
}</pre>
        </td>
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.sha1">sha1</a>
        </td>
    </tr>
    <tr>
        <th>Licensing</th>
        <td>
            By downloading Flyway Teams/Enterprise you confirm that you have read and agree to the terms of the <a href="https://www.red-gate.com/assets/purchase/assets/subscription-license.pdf?_ga=2.265045707.556964523.1656332792-1685764737.1620948215">Redgate EULA</a>.
        </td>
    </tr>
</table>
        </div>
    </div>
</div>
<p class="note">
  For older versions see <a href="/documentation/olderversions">Accessing Older Versions of Flyway</a>
</p>

## The Flyway Class

The central piece of Flyway's database migration infrastructure is the 
**[org.flywaydb.core.Flyway](/documentation/usage/api/javadoc/org/flywaydb/core/Flyway)**
class. It is your **one-stop shop** for working with Flyway programmatically. It serves both as a
**configuration** and a **launching** point for all of Flyway's functions.

### Programmatic Configuration (Java)

Flyway is super easy to use programmatically:

```java
import org.flywaydb.core.Flyway;

...
Flyway flyway = Flyway.configure().dataSource(url, user, password).load();
flyway.migrate();

// Start the rest of the application (incl. Hibernate)
...
```

<div class="well"><strong>Tip:</strong> When running inside a <a href="https://boxfuse.com">Boxfuse</a>
    instance (both locally and on AWS), Flyway will automatically use the JDBC url, user and password
    <a href="https://boxfuse.com/docs/databases#envvars">provided by Boxfuse</a>.</div>

See [configuration](/documentation/configuration/parameters) for a full list of supported configuration parameters.

### JDBC Drivers

You will need to include the relevant JDBC driver for your chosen database as a dependency in your Java project. 
For instance in your `pom.xml` for a Maven project. The version of the JDBC driver supported for each database is specified in the 'Supported Databases' list in the left hand side navigation menu.

### Spring Configuration

As an alternative to the programmatic configuration, here is how you can configure and start Flyway in a classic
Spring application using XML bean configuration:

```xml
<bean id="flywayConfig" class="org.flywaydb.core.api.configuration.ClassicConfiguration">
    <property name="dataSource" ref="..."/>
    ...
</bean>

<bean id="flyway" class="org.flywaydb.core.Flyway" init-method="migrate">
    <constructor-arg ref="flywayConfig"/>
</bean>

<!-- The rest of the application (incl. Hibernate) -->
<!-- Must be run after Flyway to ensure the database is compatible with the code -->
<bean id="sessionFactory" class="..." depends-on="flyway">
    ...
</bean>
```

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/usage/api/hooks">API: Hooks <i class="fa fa-arrow-right"></i></a>
</p>

{% include trialpopup.html %}
