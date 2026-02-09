---
description: Debug workflow - investigate bugs without modifying code
---

# Debug Workflow

## Purpose
- Investigate a reported bug and determine likely root causes
- Analyze issues based on reported symptoms and system behavior
- Provide investigation results and next actions
- Do NOT apply code changes

## Trigger
- User provides a tester report or bug description

---

## Steps

1. **Scope Lock**: Restate the bug report in one sentence

2. **Analyze Possible Causes**:
   - Data flow
   - UI binding
   - Sorting / calculation logic
   - Async timing and caching

3. **Identify Likely Root Causes**:
   - Rank by probability
   - Location: use exactly ONE clickable link (or "not available")

4. **Propose Quick Verification Checks**:
   - Logs to inspect
   - Values to verify
   - Execution order to confirm

5. **Conclude with Next Actions**

---

## Output Format

- Bug summary:
- Analysis result:
- Likely root causes (ranked):
- Quick verification checklist:
- Next actions:

---

## Output Rules
- Do NOT output file path or line number separately
- Do NOT guess or fabricate paths or locations
- Do NOT propose patched code snippets (analysis only)
- If information missing: state "cannot verify"

---

## Exception
- One (1) critical clarification question is allowed
- Only if required to identify root cause
- Must ask for a single fact or signal (log, value, execution order)
- Do NOT describe reproduction steps

---

## Restrictions
- Debug must NOT modify code
- Do NOT refactor
- Do NOT rename
- Do NOT introduce new systems

---

## Handoff
- If user requests to proceed:
  - Use /review to propose fixes
  - Fixing only occurs after explicit fix request
