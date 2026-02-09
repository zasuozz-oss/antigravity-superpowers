---
name: Fixallwarning
description: Áp dụng tất cả WARNING fixes
trigger: /fixallwarning
---

## fixallwarning request

requires:
- latest /review output (from this conversation)
- code snippets/files referenced by that /review (if not already provided)

command:
- fix all WARNING

rules:
- precondition: /review must have been run before this command
- conversation scope rule: this command is valid ONLY within the same conversation as the latest /review output
- apply ONLY fix_ids that exist in the latest /review output
- apply ONLY WARNING_XX fixes
- do not apply ERROR fixes unless explicitly requested separately
- do not apply optimization changes
- no rewrite
- no refactor unless explicitly allowed
- no rename

output:
use implementation response format from ai-output-formats.md