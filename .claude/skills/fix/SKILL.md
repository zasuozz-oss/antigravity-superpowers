---
name: Fix
description: Áp dụng fix cụ thể từ review (fix_id)
trigger: /fix
---

## fix request

requires:
- latest /review output (from this conversation)
- requested fix_ids (e.g., ERROR_01,ERROR_02 or WARNING_01)
- code snippets/files referenced by that /review (if not already provided)

command:
- fix <fix_id1>,<fix_id2>

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY requested fix_ids that exist in the latest /review output
- do not apply any other fixes
- do not apply optimization changes
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md