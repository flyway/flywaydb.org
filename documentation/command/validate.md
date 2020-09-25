---
layout: documentation
menu: validate
subtitle: Validate
---
# Validate

Validates the applied migrations against the available ones.

![Validate](/assets/balsamiq/command-validate.png)

Validate helps you verify that the migrations applied to the database match the ones available locally.

This is very useful to detect accidental changes that may prevent you from reliably recreating the schema.

Validate works by storing a checksum (CRC32 for SQL migrations) when a migration is executed. The validate mechanism checks if the migration locally still has the same checksum as the migration already executed in the database.

See [configuration](/documentation/configuration/#validate) for validate specific configuration parameters.

<p class="next-steps">
    <a class="btn btn-primary" href="/documentation/command/undo">Undo <i class="fa fa-arrow-right"></i></a>
</p>