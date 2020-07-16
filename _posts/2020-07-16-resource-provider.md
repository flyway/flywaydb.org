---
layout: blog
subtitle: Configure resource providers
permalink: /blog/Configure-resource-providers.html
author: mikiel
---

In May we received [request](https://github.com/flyway/flyway/issues/2822) from our friends at [Quarkus](https://quarkus.io/) asking that we allow users more control over how Flyway looks up resources. By resources, we mean things like migrations, callbacks, and so on. They were even kind enough to provide a Pull Request!

The Pull Request was merged, and the changes released in Flyway 6.5. In this blog I'll explain a bit more about how this new feature works.

## Injecting a ResourceProvider

By default, Flyway will use a process of recursive classpath scanning to find resources. Let's look at a simple programmatic configuration of Flyway:

```java
Flyway flyway = Flyway.configure()
  .dataSource("jdbc:h2:mem:db", "sa", "password")
  .locations("db/migration")
  .load();

flyway.migrate();
```

`locations` is set to a folder, `db/migration`. Flyway will perform a recursive scan of this folder to search for the resources it needs to perform the migration.

We've now expanded Flyway's API to allow you override this behavior with custom Java code. You can specify your own override of the `ResourceProvider` abstract class, which defines a contract for a class that can supply resources to Flyway.

A simple implementation might look like this:

```java
LoadableResource loadableResource = new LoadableResource() {
  @Override
  public Reader read() {
    try {
        return new FileReader("C:\\V1__migration.sql");
    } catch (FileNotFoundException e) {
        // No op
    }
      
    return null;
  }

  @Override
  public String getAbsolutePath() {
    return "C:\\V1__migration.sql";
  }

  @Override
  public String getAbsolutePathOnDisk() {
    return "C:\\V1__migration.sql";
  }

  @Override
  public String getFilename() {
    return "V1__migration.sql";
  }

  @Override
  public String getRelativePath() {
    return "V1__migration.sql";
  }
};

Flyway flyway = Flyway.configure()
  .dataSource("jdbc:h2:mem:db", "sa", "password")
  .resourceProvider(new ResourceProvider() {
    @Override
    public LoadableResource getResource(String name) {
      return loadableResource;
    }

    @Override
    public Collection<LoadableResource> getResources(String prefix, String[] suffixes) {
      ArrayList<LoadableResource> arr = new ArrayList<>();
      arr.add(loadableResource);
      return arr;
    }
  })
  .load();
flyway.migrate();
```

We've defined a `LoadableResource` object which points to a single migration `V1__migration.sql`. We call `.resourceProvider` when setting up the configuration to give Flyway a custom `ResourceProvider`, which in turn provides a `LoadableResource`.

This is a trivial example, but it demonstrates the principle. Given that we allow you to inject a plain Java object there are many possibilities. For instance, you could read resources from a cloud storage provider, parse a bespoke configuration file format, or perhaps even prompt for user input.

## Summary

That's a brief overview of how the new API methods work. This is a fairly advanced feature which is designed to make Flyway more flexible. You can also inject a Java migration resource provider too. You can read more about the API in the [documentation](../documentation/api/).