---
layout: documentation
menu: configuration
pill: locations
subtitle: flyway.locations
---

# Locations

## Description
Comma-separated list of locations to scan recursively for migrations. The location type is determined by its prefix.

Unprefixed locations or locations starting with <code>classpath:</code> point to a package on the classpath and may contain both SQL and Java-based migrations.

Locations starting with <code>filesystem:</code> point to a directory on the filesystem, may only contain SQL migrations and are only scanned recursively down non-hidden directories.

Locations starting with <code>s3:</code> point to a bucket in AWS S3, may only contain SQL migrations, and are scanned recursively. They are in the format <code>s3:&lt;bucket&gt;(/optionalfolder/subfolder)</code>. To use AWS S3, the AWS environment variables <code>AWS_REGION</code>, <code>AWS_ACCESS_KEY_ID</code> and <code>AWS_SECRET_ACCESS_KEY</code> need to be set to the appropriate values for your S3 account.<br/>

Locations starting with <code>gcs:</code> point to a bucket in Google Cloud Storage, may only contain SQL migrations, and are scanned recursively. They are in the format <code>gcs:&lt;bucket&gt;(/optionalfolder/subfolder)</code>. To use GCS, the GCS library must be included, and the GCS environment variable <code>GOOGLE_APPLICATION_CREDENTIALS</code> must be set to the credentials file for the service account that has access to the bucket.<br/>

Locations can contain wildcards. This allows matching against a path pattern instead of a single path. Supported wildcards:<br/>
<ul>
    <li>
        <code>**</code> : Matches any 0 or more directories. (e.g. <code>db/**/test</code> will match <code>db/version1.0/test</code>, <code>db/version2.0/test</code>, <code>db/development/version/1.0/test</code> but not <code>db/version1.0/release</code>)
    </li>
    <li>
        <code>*</code> : Matches any 0 or more non-separator characters. (e.g. <code>db/release1.*</code> will match <code>db/release1.0</code>, <code>db/release1.1</code>, <code>db/release1.123</code> but not <code>db/release2.0</code>)
    </li>
    <li>
        <code>?</code> : Matches any 1 non-separator character. (e.g. <code>db/release1.?</code> will match <code>db/release1.0</code>, <code>db/release1.1</code> but not <code>db/release1.11</code>)
    </li>
</ul>

## Default
classpath:db/migration

## Usage

### Commandline
```
./flyway -locations="filesystem:./sql" info
```

### Configuration File
```
flyway.locations=filesystem:./sql
```

### Environment Variable
```
FLYWAY_LOCATIONS=filesystem:./sql
```

### API
```
Flyway.configure()
    .locations("filesystem:./sql")
    .load()
```

### Gradle
```
flyway {
    locations = ['filesystem:./sql']
}
```

### Maven
```
<configuration>
    <locations>
        <location>filesystem:./sql</location>
    </locations>
</configuration>
```

## Related Reading

- [Blog Post: Organising your migrations](/blog/organising-your-migrations)