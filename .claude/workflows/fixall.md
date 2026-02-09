---
name: fixall
description: Apply ALL correctness fixes (ERROR + WARNING) from latest /review
trigger: /fixall
disable-model-invocation: true
---

## Fix All request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

command:
- `/fixall` — apply ALL correctness fixes (ERROR_XX + WARNING_XX)

scope:
- apply all ERROR_XX + WARNING_XX from the latest /review

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY fix_ids that exist in the latest /review output
- do not apply optimization changes (use /optimize instead)
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md
