---
layout: documentationv6
menu: repair
subtitle: Repair
---
# Repair

Repairs the schema history table.

![Repair](/assets/balsamiq/command-repair.png)

Repair is your tool to fix issues with the schema history table. It has two main uses:
- Remove failed migration entries (only for databases that do NOT support DDL transactions)
- Realign the checksums, descriptions and types of the applied migrations with the ones of the available migrations

<p class="next-steps">
    <a class="btn btn-primary" href="v6/documentation/commandline/">Command-line <i class="fa fa-arrow-right"></i></a>
</p>