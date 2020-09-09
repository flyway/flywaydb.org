---
layout: documentation
menu: testcontainers
subtitle: TestContainers
---
# TestContainers

## Driver
<table class="table">
<tr>
<th>URL format</th>
<td><code>jdbc:tc:</code> instead of <code>jdbc:</code> for your database</td>
</tr>
<tr>
<th>Ships with Flyway Command-line</th>
<td>Yes</td>
</tr>
<tr>
<th>Maven Central coordinates</th>
<td><code>org.testcontainers:jdbc:jar:1.14.3</code></td>
</tr>
<tr>
<th>Supported versions</th>
<td><code>1.14.3</code></td>
</tr>
<tr>
<th>Default Java class</th>
<td><code>org.testcontainers.jdbc.ContainerDatabaseDriver</code></td>
</tr>
</table>

- See the [TestContainers documentation](https://www.testcontainers.org/modules/databases/jdbc/) for more information

### Compatibility

- See [TestContainers list of supported databases](https://www.testcontainers.org/modules/databases/) to check if your chosen database is compatible

### Example URL

```
jdbc:tc:postgresql:11-alpine://localhost:5432/databasename
```

## Limitations

- If Flyway doesn't ship with the JAR for your chosen database, you will still need to provide it in order to use it with TestContainers

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/database/postgresql">PostgreSQL <i class="fa fa-arrow-right"></i></a>
</p>
