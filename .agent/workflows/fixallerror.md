---
name: fixallerror
description: Apply ONLY ERROR fixes from latest /review, skip warnings
trigger: /fixallerror
disable-model-invocation: true
---

## Fix All Error request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

command:
- `/fixallerror` — apply ONLY ERROR_XX fixes

scope:
- apply all ERROR_XX, skip WARNING_XX

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY ERROR_XX fix_ids that exist in the latest /review output
- do not apply WARNING fixes
- do not apply optimization changes (use /optimize instead)
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md
