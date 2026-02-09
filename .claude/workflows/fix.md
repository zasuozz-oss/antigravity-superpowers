---
name: Fix
description: Áp dụng fixes từ review (specific, all, error-only, warning-only)
trigger: /fix
disable-model-invocation: true
---

## Fix request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

commands:
- `/fix <fix_id1>,<fix_id2>` — apply specific fix_ids only
- `/fixall` — apply ALL correctness fixes (ERROR_XX + WARNING_XX)
- `/fixallerror` — apply ONLY ERROR_XX fixes
- `/fixallwarning` — apply ONLY WARNING_XX fixes

scope resolution:
- `/fix ERROR_01,WARNING_02` → apply only those two
- `/fixall` → apply all ERROR_XX + WARNING_XX
- `/fixallerror` → apply all ERROR_XX, skip WARNING_XX
- `/fixallwarning` → apply all WARNING_XX, skip ERROR_XX

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
