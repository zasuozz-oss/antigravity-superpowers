---
name: fixallwarning
description: Apply ONLY WARNING fixes from latest /review, skip errors
trigger: /fixallwarning
disable-model-invocation: true
---

## Fix All Warning request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

command:
- `/fixallwarning` — apply ONLY WARNING_XX fixes

scope:
- apply all WARNING_XX, skip ERROR_XX

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY WARNING_XX fix_ids that exist in the latest /review output
- do not apply ERROR fixes unless explicitly requested separately
- do not apply optimization changes (use /optimize instead)
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md
