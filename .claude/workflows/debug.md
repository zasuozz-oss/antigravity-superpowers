---
name: Debug
description: "Investigate bugs and errors in Unity C# scripts. Use when encountering runtime errors, unexpected behavior, or crash logs. Outputs root causes and verification checklist."
trigger: /debug
---

# Debug Workflow

## Purpose
- Investigate a reported bug and determine likely root causes
- Do NOT apply code changes

## Next Steps
After completing the analysis:
1. Output the analysis results.
2. If bug is identified, suggest using `/review` on specific files to propose fixes.
3. Wait for user input.

---

## workflow steps

### step 1 — scope lock (mandatory)
- restate the bug report in one sentence
- do NOT expand scope to unrelated systems

### step 2 — analysis
analyze possible causes based on:
- data flow
- ui binding
- sorting / calculation logic
- async timing and caching

### step 3 — identify root causes
- rank by probability (high → low)
- Location:
  - use exactly ONE clickable link if available
  - otherwise write: (cannot verify location)

### step 4 — quick verification
- logs to inspect
- values to verify
- execution order to confirm

### step 5 — conclude
- next actions (use `/review` to propose fixes if needed)

---

## rules
- do NOT modify code
- do NOT introduce new systems
- do NOT refactor
- do NOT rename
- do NOT invent file paths, line numbers, packages, or project settings
- if not provided → cannot verify
- one (1) critical question allowed ONLY if needed to narrow root cause

---

## output format

### Bug summary
(1 sentence)

### Analysis result
(data flow, ui binding, logic, async timing)

### Likely root causes (ranked)
1. [High] ...
2. [Medium] ...
3. [Low] ...

### Quick verification checklist
- [ ] log to check: ...
- [ ] value to verify: ...
- [ ] execution order: ...

### Steps to reproduce (if bug confirmed)
1. ...
2. ...
3. ...
(required when bug is identified)

### Next actions
- ...

---

## handoff
- if user requests to proceed → use `/review` to propose fixes
- fixing only occurs after explicit fix request

---

### 📋 Next Steps (MANDATORY OUTPUT)
After presenting the debug analysis, ALWAYS output this section:

```
## Next Steps
Bạn có thể:
- `/review <file>` - review file để đề xuất fixes
- Cung cấp thêm logs/thông tin để phân tích sâu hơn

Vui lòng cho biết bạn muốn thực hiện gì tiếp theo.
```