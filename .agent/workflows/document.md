---
description: Tự động sinh documentation cho code/feature
---

# Document Workflow

> **Required Skill**: Read `skills/my-skills/document/SKILL.md` for documentation standards and format.

## Purpose
Automatically generate documentation for code, features, or folders.

## Next Steps
After generating the documentation:
1. Present the documentation (inline or markdown content).
2. If saving to a file, confirm the file path.
3. Wait for user input.

---

rules:
- do not modify code logic
- do not refactor or rename
- inline XML docs: modify file to add /// comments
- markdown docs: create separate .md file
- respect existing documentation style if present
- use Vietnamese for descriptions (per 00-ai-rules.md)

======================DOCUMENT SCRIPT WORKFLOW======================

## document script

steps:
1. analyze script structure:
   - class purpose and responsibility
   - public API surface
   - serialized fields (Inspector-facing)
   - events and callbacks
   - dependencies
2. generate documentation:
   - class summary
   - method descriptions (public only by default)
   - parameter descriptions
   - return value descriptions
   - important usage notes
3. output based on format:
   - inline-xml: add /// comments to code
   - markdown: create <ScriptName>.md

output format (inline-xml):
```csharp
/// <summary>
/// Mô tả ngắn gọn class/method
/// </summary>
/// <param name="paramName">Mô tả parameter</param>
/// <returns>Mô tả return value</returns>
```

output format (markdown):
```markdown
# ClassName

## Mô tả
...

## Public API
### MethodName(params)
...

## Inspector Fields
| Field | Type | Mô tả |
|-------|------|-------|
```

======================DOCUMENT FEATURE WORKFLOW======================

## document feature

purpose:
- create high-level documentation for a feature or system

steps:
1. identify feature scope:
   - entry scripts
   - related scripts
   - prefabs/scenes (if mentioned)
2. analyze:
   - feature purpose
   - user-facing behavior
   - data flow
   - key classes and their roles
   - dependencies
3. generate documentation:
   - overview
   - architecture diagram (text-based)
   - key components
   - usage guide
   - configuration notes

output:
- feature documentation (markdown)
- location: project docs folder or alongside feature

======================DOCUMENT FOLDER WORKFLOW======================

## document folder

purpose:
- generate README.md for a folder/module

steps:
1. scan folder contents
2. categorize scripts by role
3. generate README.md with:
   - folder purpose
   - file listing with one-line descriptions
   - dependencies
   - usage notes

output:
- README.md in target folder

---

### 📋 Next Steps (MANDATORY OUTPUT)
After generating documentation, ALWAYS output this section:

```
## Next Steps
Bạn có thể:
- Xem lại documentation đã sinh
- Yêu cầu chỉnh sửa/bổ sung
- Lưu file vào project

Vui lòng cho biết bạn muốn thực hiện gì tiếp theo.
```
