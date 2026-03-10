---
description: Generate documentation for Unity C# scripts or folders. Outputs inline XML docs or markdown README. Use when user asks to document code.
---

# Document Workflow

## Purpose
Generate inline XML docs for scripts or README.md for folders.
Output is presented as a plan for user review — no files are written until user approves.

> **For detailed feature documentation** (HTML with Mermaid, edge cases, test summary):
> Use `/generate-document` instead.

---

## Rules
- Do not modify code logic
- Do not refactor or rename
- Do NOT write files directly — present as plan for user review first
- Inline XML docs: show proposed `///` comments in plan
- Markdown docs: show proposed content in plan
- Respect existing documentation style if present
- Use English for all descriptions and documentation content

---

## Document Script

### Steps
1. **Analyze script structure**:
   - Class purpose and responsibility
   - Public API surface
   - Serialized fields (Inspector-facing)
   - Events and callbacks
   - Dependencies
2. **Generate documentation**:
   - Class summary
   - Method descriptions (public only by default)
   - Parameter descriptions
   - Return value descriptions
   - Important usage notes
3. **Present as plan for review**:
   - `inline-xml`: show proposed `///` comments (do NOT apply yet)
   - `markdown`: show proposed `<ScriptName>.md` content (do NOT create yet)

### Output Format (inline-xml)
```csharp
/// <summary>
/// Brief description of class/method
/// </summary>
/// <param name="paramName">Parameter description</param>
/// <returns>Return value description</returns>
```

### Output Format (markdown)
```markdown
# ClassName

## Description
...

## Public API
### MethodName(params)
...

## Inspector Fields
| Field | Type | Description |
|-------|------|-------|
```

---

## Document Folder

### Steps
1. Scan folder contents
2. Categorize scripts by role
3. Generate `README.md` with:
   - Folder purpose
   - File listing with one-line descriptions
   - Dependencies
   - Usage notes

### Output
- Show proposed `README.md` content for user review (do NOT create yet)

---

## Next Steps (MANDATORY OUTPUT)
After presenting the documentation plan, ALWAYS output:

```
## Next Steps
You can:
- Approve → I will apply the documentation to your project
- `/generate-document` — generate detailed feature document
- Request edits before applying

Please let me know what you'd like to do next.
```
