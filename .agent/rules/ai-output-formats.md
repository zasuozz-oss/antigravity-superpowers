---
trigger: always_on
---

# AI Output Formats

Title capitalization rules:
- all section titles and list headers must start with a capital letter

## Debug

- Bug summary:
- Analysis result:
- Likely root causes (ranked):
- Quick verification checklist:
- Next actions:

Rules:
- do not apply code changes
- if information is missing, explicitly state "cannot verify"
- if a location is mentioned, use a single clickable link only
- never guess file paths or line numbers

## Implementation response

- Selected issue titles:
  - <Exact title 1>
  - <Exact title 2>
- Selected optimization titles:
  - <Exact optimization title 1>

- Changes summary:
  Short summary of what was applied.

- Code (final):
  Only include code for the selected titles.

- Validation steps:
  Steps to verify correctness after applying changes.

- Risks & assumptions:
  Any remaining risks or assumptions.

## Review output

- File: `<file_path>`
- Issues found:

| # | fix_id | Severity | Title | Description |
|---|--------|----------|-------|-------------|
| 1 | FIX_01 | ERROR / WARNING | Short title | Brief description |

- Optimizations found:

| # | Title | Description |
|---|-------|-------------|
| 1 | Short title | Brief description |

- Summary:
  Total errors: N | Total warnings: N | Optimizations: N

Rules:
- Each issue MUST have a unique fix_id
- Optimizations MUST NOT have fix_id
- Do not modify code during review; only propose

## Patched code presentation

Rules:
- Short code snippets may be inline
- Long patches MUST be wrapped in collapsible block
- Use correct language tag (csharp, shader, etc.)

Template:
<details>
<summary>View patch</summary>

~~~csharp
// patched code here
~~~

</details>