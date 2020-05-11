---
layout: documentation
menu: knownparserlimitations
subtitle: Known Parser Limitations
---

## Known Parser Limitations
The parser Flyway uses to parse sql into individual statements that can be executed has a few known limitations that it may help to be aware of:

### Control Flow Keyword Handling
If you see any of the error messages `Delimiter changed inside statement`, `Incomplete statement`, or `Unable to decrease block depth below 0` it may be because Flyway's control flow handling encountered an error. This can be caused by a number of different reasons:

- It may be because the particular keyword is not yet supported (in which case please create a github issue).
- It may be because you haven't closed that block (for example, and `IF` not closed by an `END IF`).
- It may be because you are using a control flow keyword as a variable name (which Flyway does not support). Control flow keywords are most commonly `BEGIN` and `END`, but may also include `IF`, `CASE`, `REPEAT`, `WHILE`, and more depending on database type. In this case please change the variable name to one that is not used for control flow.