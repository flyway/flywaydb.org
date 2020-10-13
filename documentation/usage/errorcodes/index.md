---
layout: documentation
menu: errorcodes
subtitle: Error Codes
---

# Error Codes

When Flyway commands fail, they throw an exception with a message to help you identify the problem. They also contain an error code which users of the API or those who have enabled machine readable output can inspect and handle accordingly. Below are details of each error code under the command that causes it along with a suggested solution.


## Validate Error Codes
These error codes are surfaced when running `validate` or `validateWithResult`.

### `SCHEMA_DOES_NOT_EXIST`
- **Caused by:** The schema being validated against does not exist
- **Solution:** Manually create the schema or enable [`createSchemas`](/documentation/configuration/parameters/createSchemas)

### `FAILED_REPEATABLE_MIGRATION`
- **Caused by:** A failed repeatable migration was detected
- **Solution:** Remove any incompleted changes then run `repair` to fix the schema history

### `FAILED_VERSIONED_MIGRATION`
- **Caused by:** A failed versioned migration was detected
- **Solution:** Remove any incompleted changes then run `repair` to fix the schema history

### `APPLIED_REPEATABLE_MIGRATION_NOT_RESOLVED`
- **Caused by:** A repeatable migration that was applied wasn't resolved in any supplied locations
- **Solution:** If you removed this migration intentionally run `repair` to mark the migration as deleted

### `APPLIED_VERSIONED_MIGRATION_NOT_RESOLVED`
- **Caused by:** A versioned migration that was applied wasn't resolved in any supplied locations
- **Solution:** If you removed this migration intentionally run `repair` to mark the migration as deleted

### `RESOLVED_REPEATABLE_MIGRATION_NOT_APPLIED`
- **Caused by:** A repeatable migration that was resolved has not been applied
- **Solution:** To ignore this migration enable [`ignoreIgnoredMigrations`](/documentation/configuration/parameters/ignoreIgnoredMigrations)

### `RESOLVED_VERSIONED_MIGRATION_NOT_APPLIED`
- **Caused by:** A versioned migration that was resolved has not been applied
- **Solution:** To ignore this migration enable [`ignoreIgnoredMigrations`](/documentation/configuration/parameters/ignoreIgnoredMigrations) and to allow executing this migration enable [`outOfOrder`](/documentation/configuration/parameters/outOfOrder)

### `OUTDATED_REPEATABLE_MIGRATION`
- **Caused by:** An applied repeatable migration was resolved with a newer checksum and can be reapplied
- **Solution:** Run `migrate` to execute this migration

### `TYPE_MISMATCH`
- **Caused by:** The type of the resolved migration (`BASELINE`, `SQL`, `UNDO_SQL`, ...) is different from the applied migration's
- **Solution:** Either revert the changes to the migration or run `repair` to update the schema history

### `CHECKSUM_MISMATCH`
- **Caused by:** The checksum of the resolved migration is different from the applied migration's
- **Solution:** Either revert the changes to the migration or run `repair` to update the schema history

### `DESCRIPTION_MISMATCH`
- **Caused by:** The description of the resolved migration is different from the applied migration's
- **Solution:** Either revert the changes to the migration or run `repair` to update the schema history


## General Error Codes
These error codes may appear from any command, and are indicative of more general errors.

### `FAULT`
- **Caused by:** An unexpected error within Flyway (e.g. a null pointer exception)
- **Solution:** Please contact support or create a [GitHub issue](https://github.com/flyway/flyway/issues)

### `VALIDATE_ERROR`
- **Caused by:** Some migrations have failed validation
- **Solution:** Inspect the list `invalidMigrations` on the validate result to see the required actions


<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/usage/plugins">Community Plugins<i class="fa fa-arrow-right"></i></a>
</p>
