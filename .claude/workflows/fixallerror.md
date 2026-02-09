---
description: Áp dụng tất cả ERROR fixes
---

## fixallerror request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

command:
- fix all ERROR

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY fix_ids that exist in the latest /review output
- apply ONLY ERROR fixes
- do not apply WARNING fixes
- do not apply optimization changes
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md