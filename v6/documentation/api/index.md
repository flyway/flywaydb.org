---
layout: api
pill: overview
subtitle: API
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
- `Java 7` {% include enterprise.html %}

## Download

<div class="tabbable">
    <ul class="nav nav-tabs">
        <li class="active marketing-item"><a href="#tab-community" data-toggle="tab">Community Edition</a>
        </li>
        <li class="marketing-item"><a href="#tab-pro" data-toggle="tab">Pro Edition</a>
        </li>
        <li class="marketing-item"><a href="#tab-enterprise" data-toggle="tab">Enterprise Edition</a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab-community">
<table class="table">
    {% if site.flywayPreviewVersion %}
    <tr>
        <th></th>
        <th>Official Release (recommended)</th>
        <td>Early-Access Preview</td>
    </tr>    
    {% endif %}
    <tr>
        <th>Maven</th>
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayPreviewVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">compile "org.flywaydb:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">compile "org.flywaydb:flyway-core:{{ site.flywayPreviewVersion }}"</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.sha1">sha1</a>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayPreviewVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.sha1">sha1</a>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Sources</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}-sources.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar.sha1">sha1</a>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}-sources.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayPreviewVersion}}-sources.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}-sources.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}-sources.jar.sha1">sha1</a>
        </td>
        {% endif %}
    </tr>
</table>
        </div>
        <div class="tab-pane" id="tab-pro">
<table class="table">
    {% if site.flywayPreviewVersion %}
    <tr>
        <th></th>
        <th>Official Release (recommended)</th>
        <td>Early-Access Preview</td>
    </tr>    
    {% endif %}
    <tr>
        <th>Maven</th>
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb<strong>.pro</strong>&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb<strong>.pro</strong>&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayPreviewVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">compile "org.flywaydb<strong>.pro</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">compile "org.flywaydb<strong>.pro</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.sha1">sha1</a>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayPreviewVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/pro/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.sha1">sha1</a>
        </td>
        {% endif %}
    </tr>
</table>
        </div>
                <div class="tab-pane" id="tab-enterprise">
<table class="table">
    {% if site.flywayPreviewVersion %}
    <tr>
        <th></th>
        <th>Official Release (recommended)</th>
        <td>Early-Access Preview</td>
    </tr>    
    {% endif %}
    <tr>
        <th>Maven</th>
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb<strong>.enterprise</strong>&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb<strong>.enterprise</strong>&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayPreviewVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">compile "org.flywaydb<strong>.enterprise</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <pre class="prettyprint">compile "org.flywaydb<strong>.enterprise</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
        {% endif %}
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar.sha1">sha1</a>
        </td>
        {% if site.flywayPreviewVersion %}
        <td>
            <a class="btn btn-primary btn-download" href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar"><i class="fa fa-download"></i> flyway-core-{{site.flywayPreviewVersion}}.jar</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.md5">md5</a>
            <a class="note" href="https://repo1.maven.org/maven2/org/flywaydb/enterprise/flyway-core/{{site.flywayPreviewVersion}}/flyway-core-{{site.flywayPreviewVersion}}.jar.sha1">sha1</a>
        </td>
        {% endif %}
    </tr>
</table>
        </div>
    </div>
</div>
<p class="note">
  For older versions see <a href="v6/documentation/olderversions">Accessing Older Versions of Flyway</a>
</p>

## The Flyway Class

The central piece of Flyway's database migration infrastructure is the 
**[org.flywaydb.core.Flyway](v6/documentation/api/javadoc/org/flywaydb/core/Flyway)**
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

### JDBC Drivers

You will need to include the relevant JDBC driver for your chosen database as a dependency in your Java project. 
For instance in your `pom.xml` for a Maven project. The version of the JDBC driver supported for each database is specified in the 'Supported Databases' list in the left hand side navigation menu.

### Programmatic Configuration (Android)

**Note: Android integration may not work correctly due to a bug in the SQLDroid driver. [See this GitHub issue](https://github.com/flyway/flyway/issues/970#issuecomment-543209484).**

In order to use Flyway on Android you have to add flyway-core as well as SQLDroid as dependencies. 
There are two things to keep in mind with Android: First, you have to load the migrations as *assets*, not *resources* 
and second, you have to let Flyway know your Android context, by calling `ContextHolder.setContext()`.

Add the necessary dependencies to `build.gradle`:

```groovy
dependencies {
    // Your other dependencies
    // ...

    compile 'org.flywaydb:flyway-core:{{ site.flywayVersion }}'
    compile 'org.sqldroid:sqldroid:1.1.0-rc1'
}
```

Make sure that your migrations are included as assets (notice that assets have to be declared in the project itself and not in a dependency. But you can use reference e.g. `../lib/src/main/resources` to use the resources of a lib project)

```groovy
android {
    // SDK, config, buildTypes, etc
    // ...

    sourceSets {
        // Place your db/migration folder here
        main { assets.srcDirs = ['src/main/assets'] }
    }

    // ...
}
```

Include the setup in your main activity onCreate or application onCreate:

```java
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.android.ContextHolder;
import org.sqldroid.DroidDataSource;

...
DroidDataSource dataSource = new DroidDataSource(getPackageName(), "...");
ContextHolder.setContext(this);
Flyway flyway = Flyway.configure().dataSource(dataSource).load();
flyway.migrate();
```

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
    <a class="btn btn-primary" href="v6/documentation/api/hooks">API: Hooks <i class="fa fa-arrow-right"></i></a>
</p>

{% include trialpopup.html %}