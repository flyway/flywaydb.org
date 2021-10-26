---
layout: documentation
menu: configuration
pill: oracleKerberosConfigFile
subtitle: flyway.oracle.kerberosConfigFile
redirect_from: /documentation/configuration/oracleKerberosConfigFile/
---

# Oracle Kerberos Config File
{% include teams.html %}

This parameter is deprecated and will be removed in V9. Please use [`kerberosConfigFile`](/documentation/configuration/parameters/kerberosConfigFile) instead.

## Description
The location of the `krb5.conf` file for use in Kerberos authentication.

## Usage

### Commandline
```powershell
./flyway -oracle.kerberosConfigFile="/etc/krb5.conf" info
```

### Configuration File
```properties
flyway.oracle.kerberosConfigFile=/etc/krb5.conf
```

### Environment Variable
```properties
FLYWAY_ORACLE_KERBEROS_CONFIG_FILE=/etc/krb5.conf
```

### API
```java
Flyway.configure()
    .oracleKerberosConfigFile("/etc/krb5.conf")
    .load()
```

### Gradle
```groovy
flyway {
    oracleKerberosConfigFile = '/etc/krb5.conf'
}
```

### Maven
```xml
<configuration>
    <oracleKerberosConfigFile>/etc/krb5.conf</oracleKerberosConfigFile>
</configuration>
```
