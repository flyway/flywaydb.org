---
layout: documentation
menu: errorcodes
subtitle: Error Codes
---

# Error Codes

When Flyway commands fail, they throw an exception with an error code as well as a message to help you identify the problem. Below you can find the meaning of each error code and the command that causes it.

## Validate Error Codes
- `SCHEMA_DOES_NOT_EXIST` - The schema being validated against does not exist
- `FAILED_REPEATABLE_MIGRATION` - A failed repeatable migration was detected
- `FAILED_VERSIONED_MIGRATION` - A failed versioned migration was detected
- `APPLIED_REPEATABLE_MIGRATION_NOT_RESOLVED` - A repeatable migration that was applied cannot be resolved in any supplied locations
- `APPLIED_VERSIONED_MIGRATION_NOT_RESOLVED` - A versioned migration that was applied cannot be resolved in any supplied locations
- `RESOLVED_REPEATABLE_MIGRATION_NOT_APPLIED` - A repeatable migration that was resolved has not been applied
- `RESOLVED_VERSIONED_MIGRATION_NOT_APPLIED` - A versioned migration that was resolved has not been applied
- `OUTDATED_REPEATABLE_MIGRATION` - A resolved repeatable migration's checksum differs from the checksum of the applied migration
- `TYPE_MISMATCH` - The type of the resolved migration (`BASELINE`, `SQL`, `UNDO_SQL`, ...) is different from the applied migration's
- `CHECKSUM_MISMATCH` - The checksum of the resolved migration is different from the applied migration's
- `DESCRIPTION_MISMATCH` - The description of the resolved migration is different from the applied migration's

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/usage/plugins">Community Plugins<i class="fa fa-arrow-right"></i></a>
</p>
