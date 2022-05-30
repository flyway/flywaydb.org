---
layout: documentation
menu: snapshot
subtitle: snapshot
---

# Snapshot

**The `snapshot` command is currently in beta. This feature will be available in future products, but during the beta phase you can access it through your Flyway Teams or Redgate Deploy license.**

{% include enterprise.html %}

`snapshot` captures the schema of the database specified in `flyway.url` into a file.

#### Requirements
- .NET 6 is required in order to generate reports. You can download it from [here](https://dotnet.microsoft.com/en-us/download/dotnet/6.0).

#### Configuration parameters:
 _Format: -key=value_

| Parameter                    | Description
| ---------------------------- | -----------------------------------------------------------
|    snapshot.filename         | **[REQUIRED]** Destination filename for the snapshot

#### Usage Example:
```
flyway snapshot -url=jdbc:example:database -user=username -password=password -snapshot.filename=C:\snapshots\my_snapshot
```

##### Example configuration file

```properties
flyway.url=jdbc:example:database
flyway.user=username
flyway.password=password
flyway.snapshot.filename=C:\snapshots\my_snapshot
```
