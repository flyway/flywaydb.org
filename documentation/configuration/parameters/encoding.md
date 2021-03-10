---
layout: documentation
menu: configuration
pill: encoding
subtitle: flyway.encoding
redirect_from: /documentation/configuration/encoding/
---

# Encoding

## Description
The encoding of Sql migrations.

The encodings that Flyway supports are:

- `US-ASCII`
- `ISO-8859-1`
- `UTF-8`
- `UTF-16BE`
- `UTF-16LE`
- `UTF-16`

All your scripts must have the same file encoding.

### Encoding mismatches

It's possible that Flyway will successfully read a script even if it doesn't match this configuration option.

For instance, an `ISO-8859-1` encoded script might work if Flyway's encoding is set to `UTF-8`. However it's inevitable that a failure will occur when an un-decodable character appears.

Therefore you must ensure all your scripts have the same encoding.

### Encoding names

It's possible that your text editor doesn't appear to allow you to save files in the supported formats. This could be because some format names are considered to be synonyms for others. For instance, an editor might allow you to save a file in `ANSI` format, which *might* actually be `ISO-8859-1` under the hood.

Therefore, you must be certain that your scripts are in a supported encoding.

### Malformed Input Exception

Inconsistent encoding configuration can result in Flyway producing a '`Cannot parse script - MalformedInputException`' error.

The solution is to ensure all your scripts have the same encoding, and that encoding is one Flyway supports.

`ISO-8859-1` appears to be the most broadly compatible encoding, so it's reasonable to try it in order to unblock this error. However, ideally you should take steps to be certain about how your scripts are encoded.

## Default
UTF-8

## Usage

### Commandline
```powershell
./flyway -encoding="UTF-16" info
```

### Configuration File
```properties
flyway.encoding=UTF-16
```

### Environment Variable
```properties
FLYWAY_ENCODING=UTF-16
```

### API
```java
Flyway.configure()
    .encoding("UTF-16")
    .load()
```

### Gradle
```groovy
flyway {
    encoding = 'UTF-16'
}
```

### Maven
```xml
<configuration>
    <encoding>UTF-16</encoding>
</configuration>
```