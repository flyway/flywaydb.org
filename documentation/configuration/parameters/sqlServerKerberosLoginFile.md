---
layout: documentation
menu: configuration
pill: sqlServerKerberosLoginFile
subtitle: flyway.sqlServer.kerberosLoginFile
---

# SQL Server Kerberos Login File
{% include teams.html %}

## Description
The path to the SQL Server login module configuration file (e.g. `SQLJDBCDriver.conf`) for use in Kerberos authentication.

## Usage

### Commandline
```powershell
./flyway -sqlServer.kerberosLoginFile="/path/to/SQLJDBCDriver.conf" info
```

### Configuration File
```properties
flyway.sqlServer.kerberosLoginFile=/path/to/SQLJDBCDriver.conf
```

### Environment Variable
```properties
FLYWAY_SQL_SERVER_KERBEROS_LOGIN_FILE=/path/to/SQLJDBCDriver.conf
```

### API
```java
Flyway.configure()
    .sqlServerKerberosLoginFile("/path/to/SQLJDBCDriver.conf")
    .load()
```

### Gradle
```groovy
flyway {
    sqlServerKerberosLoginFile = '/path/to/SQLJDBCDriver.conf'
}
```

### Maven
```xml
<configuration>
    <sqlServerKerberosLoginFile>/path/to/SQLJDBCDriver.conf</sqlServerKerberosLoginFile>
</configuration>
```
