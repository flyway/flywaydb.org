---
layout: documentation
menu: beta
title: Features in Beta
---

# Features in Beta

- [`check`](/documentation/command/check)
    - This feature will be available in future products, but during the beta phase you can access it through your Flyway Teams or Redgate Deploy license

# How to access the Beta

Beta versions of Flyway are available using the download links below

## Community

There are currently no active betas in Community Edition

## Enterprise

#### <i class="fa fa-windows"></i> Windows

<button class="btn btn-primary btn-download download-modal-button" data-toggle="modal" data-target="#download-email-modal" data-download-url="/download/thankyou?dl=https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-windows-x64.zip">flyway-commandline-{{site.betaFlywayVersion}}-windows-x64.zip</button>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-windows-x64.zip.md5">md5</a>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-windows-x64.zip.sha1">sha1</a><br/>

#### <i class="fa fa-apple"></i> macOS

<button class="btn btn-primary btn-download download-modal-button" data-toggle="modal" data-target="#download-email-modal" data-download-url="/download/thankyou?dl=https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-macosx-x64.tar.gz">flyway-commandline-{{site.betaFlywayVersion}}-macosx-x64.tar.gz</button>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-macosx-x64.tar.gz.md5">md5</a>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-macosx-x64.tar.gz.sha1">sha1</a><br/><br/>

#### <i class="fa fa-linux"></i> Linux

<button class="btn btn-primary btn-download download-modal-button" data-toggle="modal" data-target="#download-email-modal" data-download-url="/download/thankyou?dl=https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-linux-x64.tar.gz">flyway-commandline-{{site.betaFlywayVersion}}-linux-x64.tar.gz</button>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-linux-x64.tar.gz.md5">md5</a>
<a class="note" href="https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/{{site.betaFlywayVersion}}/flyway-commandline-{{site.betaFlywayVersion}}-linux-x64.tar.gz.sha1">sha1</a><br/><br/>

#### <img title="Docker" style="height: 12px;margin-top: -4px;" src="/assets/logos/docker.png"> Docker

<pre class="console"><span>&gt;</span> docker pull <strong>redgate/flyway:{{site.betaFlywayVersion}}</strong></pre>

Go to Docker Hub for <a href="https://hub.docker.com/r/redgate/flyway/">detailed usage instructions</a>.

# Upcoming changes for API users

Flyway Teams will only be available from our own Maven repository from V9.
You can access it with the following repository setup in your `pom.xml` or `settings.xml` and similar for Gradle:

```xml
<repositories>
...
   <repository>
       <id>redgate</id>
       <url>https://download.red-gate.com/maven/release</url>
   </repository>
...
<repositories>
```

{% include downloadpopup.html %}
<script>
    if (typeof updateModalVersion !== 'undefined') {
        var downloadButtons = document.querySelectorAll('.download-modal-button');
        for (var i=0; i<downloadButtons.length; i++) {
            downloadButtons[i].addEventListener('click', updateModalVersion);
        }
    }
</script>
