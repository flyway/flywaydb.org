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

- `Java 9`
- `Java 8`
- `Java 7` {% include enterprise.html %}
- `Java 6` {% include enterprise.html %}

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
    <tr>
        <th>Maven</th>
        <td>
            <code>pom.xml</code>
            <pre class="prettyprint">&lt;dependency&gt;
    &lt;groupId&gt;org.flywaydb&lt;/groupId&gt;
    &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
    &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
&lt;/dependency&gt;</pre>
        </td>
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">compile "org.flywaydb:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
    </tr>
    <tr>
        <th>Binary</th>
        <td>
            <a href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}.jar">flyway-core-{{site.flywayVersion}}.jar</a>
        </td>
    </tr>
    <tr>
        <th>Source</th>
        <td>
            <a href="/download/thankyou?dl=https://repo1.maven.org/maven2/org/flywaydb/flyway-core/{{site.flywayVersion}}/flyway-core-{{site.flywayVersion}}-sources.jar">flyway-core-{{site.flywayVersion}}-sources.jar</a>
        </td>
    </tr>
</table>
        </div>
        <div class="tab-pane" id="tab-pro">
<table class="table">
    <tr>
        <th>Maven</th>
        <td>
            <code>pom.xml</code>
            <pre class="prettyprint">&lt;repositories&gt;
    &lt;repository&gt;
        &lt;id&gt;flyway-repo&lt;/id&gt;
        &lt;url&gt;s3://flyway-repo/release&lt;/url&gt;
    &lt;/repository&gt;
    ...
&lt;/repositories&gt;

&lt;dependencies&gt;
    &lt;dependency&gt;
        &lt;groupId&gt;org.flywaydb<strong>.pro</strong>&lt;/groupId&gt;
        &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
        &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
    &lt;/dependency&gt;
    ...
&lt;/dependencies&gt;
        
&lt;build&gt;
    &lt;extensions&gt;
        &lt;extension&gt;
            &lt;groupId&gt;com.allogy.maven.wagon&lt;/groupId&gt;
            &lt;artifactId&gt;maven-s3-wagon&lt;/artifactId&gt;
            &lt;version&gt;1.0.1&lt;/version&gt;
        &lt;/extension&gt;
    &lt;/extensions&gt;
    ...
&lt;/build&gt;</pre>
            <code>settings.xml</code>
            <pre class="prettyprint">&lt;settings&gt;
    &lt;servers&gt;
        &lt;server&gt;
            &lt;id&gt;flyway-repo&lt;/id&gt;
            &lt;username&gt;<i>your-flyway-pro-user</i>&lt;/username&gt;
            &lt;password&gt;<i>your-flyway-pro-password</i>&lt;/password&gt;
        &lt;/server&gt;
    &lt;/servers&gt;
    ...
&lt;/settings&gt;</pre>
        </td>
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">repositories {
    maven {
        url "s3://flyway-repo/release"
        credentials(AwsCredentials) {
            accessKey '<i>your-flyway-pro-user</i>'
            secretKey '<i>your-flyway-pro-password</i>'
        }
    }
}

compile "org.flywaydb<strong>.pro</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
    </tr>
</table>
        </div>
        <div class="tab-pane" id="tab-enterprise">
<table class="table">
    <tr>
        <th>Maven</th>
        <td>
            <code>pom.xml</code>
            <pre class="prettyprint">&lt;repositories&gt;
    &lt;repository&gt;
        &lt;id&gt;flyway-repo&lt;/id&gt;
        &lt;url&gt;s3://flyway-repo/release&lt;/url&gt;
    &lt;/repository&gt;
    ...
&lt;/repositories&gt;

&lt;dependencies&gt;
    &lt;dependency&gt;
        &lt;groupId&gt;org.flywaydb<strong>.enterprise</strong>&lt;/groupId&gt;
        &lt;artifactId&gt;flyway-core&lt;/artifactId&gt;
        &lt;version&gt;{{ site.flywayVersion }}&lt;/version&gt;
    &lt;/dependency&gt;
    ...
&lt;/dependencies&gt;
        
&lt;build&gt;
    &lt;extensions&gt;
        &lt;extension&gt;
            &lt;groupId&gt;com.allogy.maven.wagon&lt;/groupId&gt;
            &lt;artifactId&gt;maven-s3-wagon&lt;/artifactId&gt;
            &lt;version&gt;1.0.1&lt;/version&gt;
        &lt;/extension&gt;
    &lt;/extensions&gt;
    ...
&lt;/build&gt;</pre>
            <code>settings.xml</code>
            <pre class="prettyprint">&lt;settings&gt;
    &lt;servers&gt;
        &lt;server&gt;
            &lt;id&gt;flyway-repo&lt;/id&gt;
            &lt;username&gt;<i>your-flyway-enterprise-user</i>&lt;/username&gt;
            &lt;password&gt;<i>your-flyway-enterprise-password</i>&lt;/password&gt;
        &lt;/server&gt;
    &lt;/servers&gt;
    ...
&lt;/settings&gt;</pre>
        </td>
    </tr>
    <tr>
        <th>Gradle</th>
        <td>
            <pre class="prettyprint">repositories {
    maven {
        url "s3://flyway-repo/release"
        credentials(AwsCredentials) {
            accessKey '<i>your-flyway-enterprise-user</i>'
            secretKey '<i>your-flyway-enterprise-password</i>'
        }
    }
}

compile "org.flywaydb<strong>.enterprise</strong>:flyway-core:{{ site.flywayVersion }}"</pre>
        </td>
    </tr>
</table>
        </div>
    </div>
</div>

## The Flyway Class

The central piece of Flyway's database migration infrastructure is the **<a
        href="/documentation/api/javadoc/org/flywaydb/core/Flyway">org.flywaydb.core.Flyway</a>**
    class. It is your **one-stop shop** for working with Flyway programmatically. It serves both as a
    **configuration** and a **launching** point for all of Flyway's functions.

## Programmatic Configuration (Java)

<p>Flyway is super easy to use programmatically: </p><pre class="prettyprint">import org.flywaydb.core.Flyway;

...
Flyway flyway = new Flyway();
flyway.setDataSource(...);
flyway.migrate();

// Start the rest of the application (incl. Hibernate)
...</pre>

<div class="well"><strong>Tip:</strong> When running inside a <a href="https://boxfuse.com">Boxfuse</a>
    instance (both locally and on AWS), Flyway will automatically use the JDBC url, user and password
    <a href="https://boxfuse.com/docs/databases#envvars">provided by Boxfuse</a>.</div>

<h2>Programmatic Configuration (Android)</h2>

<p>In order to use Flyway on Android you have to add flyway-core as well as SQLDroid as dependencies. There are two things to keep in mind with Android: First, you have to load the migrations as <i>assets</i>, not <i>resources</i> and second, you have to let Flyway know your Android context, by calling <code>ContextHolder.setContext</code>.</p>

<p>1. Add the necessary dependencies to <code>build.gradle</code>:</p>

<pre class="prettyprint">dependencies {
    // Your other dependencies
    // ...

    compile 'org.flywaydb:flyway-core:{{ site.flywayVersion }}'
    compile 'org.sqldroid:sqldroid:1.0.3'
}</pre>

    <p>2. Make sure that your migrations are included as assets (notice that assets have to be declared in the project itself and not in a dependency. But you can use reference e.g. <code>'../lib/src/main/resources'</code> to use the resources of a lib project)</p>

<pre class="prettyprint">android {
    // SDK, config, buildTypes, etc
    // ...

    sourceSets {
        // Place your db/migration folder here
        main { assets.srcDirs = ['src/main/assets'] }
    }

    // ...
}</pre>

<p>3. Include the setup in your main activity onCreate or application onCreate:</p>

<pre class="prettyprint">import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.android.ContextHolder;
import org.sqldroid.DroidDataSource;

...

DroidDataSource dataSource = new DroidDataSource(getPackageName(), "...");
ContextHolder.setContext(this);
Flyway flyway = new Flyway();
flyway.setDataSource(dataSource);
flyway.migrate();</pre>

<h2 id="spring">Spring Configuration</h2>

<p>As an alternative to the programmatic configuration, here is how you can configure and start Flyway in a typical
    Spring application: </p>
<pre class="prettyprint">&lt;bean id=&quot;flyway&quot; class=&quot;org.flywaydb.core.Flyway&quot; init-method=&quot;migrate&quot;&gt;
    &lt;property name=&quot;dataSource&quot; ref=&quot;...&quot;/&gt;
    ...
&lt;/bean&gt;

&lt;!-- The rest of the application (incl. Hibernate) --&gt;
&lt;!-- Must be run after Flyway to ensure the database is compatible with the code --&gt;
&lt;bean id=&quot;sessionFactory&quot; class=&quot;...&quot; depends-on=&quot;flyway&quot;&gt;
    ...
&lt;/bean&gt;</pre>

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/api/hooks">API: Hooks <i class="fa fa-arrow-right"></i></a>
</p>
