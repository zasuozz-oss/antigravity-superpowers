---
name: Test Case
description: "Generate professional QA test case checklists for a feature. Written from real user scenarios, with Pass/Fail checklist and summary table."
trigger: /testcase
---

# QA Test Case Generation Workflow

> Generate a professional test case document based on real user scenarios.

## Purpose
Analyze the feature → list all possible user scenarios → write test cases for each scenario → output a document with Pass/Fail checklist.

## Next Steps
After completing this workflow:
1. Output the test case document using the format below.
2. Ask the user if they want to add or modify any scenario.
3. Wait for user input.

---

## Step 1 – Analyze the Feature

1. Read all files related to the feature (scripts, prefabs, configs).
2. Identify:
   - Input: what does the user interact with?
   - Processing: internal logic (state machine, async flow, API calls)
   - Output: UI changes, data changes, notifications
3. Map dependencies between classes/components.

---

## Step 2 – List User Scenarios

List all realistic scenarios the user may encounter, grouped as follows:

| Group | Description |
|-------|-------------|
| Happy Path | Main flow works correctly |
| Fallback / Retry | When the main flow fails, the system handles it via fallback |
| App Lifecycle | Kill app, reopen, background/foreground transitions |
| Multi-item | User interacts with multiple items at once |
| Race Conditions | Multiple events occurring simultaneously / duplicates |
| Network Error | No connection, API error, timeout |
| Auth / Account | Logout, switch account, session expired |
| UI State | Popup, toast, loading, countdown, enable/disable |
| Edge Cases | Unusual interactions, extreme timing |

> Not all groups are required. Only select groups relevant to the feature.

---

## Step 3 – Write Test Cases

For each scenario, write a test case with the following information:

### Test Case Format

| Field | Description |
|-------|-------------|
| **ID** | TC-XX (sequential numbering) |
| **Test Case** | Short description of the scenario |
| **Steps** | Specific steps to perform (numbered) |
| **Expected Result** | Expected outcome (bullet list) |
| **Status** | ⬜ (Not tested) / ✅ (Pass) / ❌ (Fail) / ⏭️ (Skip) |
| **Notes** | Platform, special conditions |

### Rules

rules:
- Each scenario group must have clear **Preconditions**.
- Steps must be detailed enough for a junior tester to execute.
- Expected Results must be verifiable (observable behavior, log message, UI state).
- Do not write test cases about internal code logic — only write about user-observable behavior.
- Prioritize cases that users actually encounter in production.
- Number of test cases should match feature complexity (5-50 cases).

---

## Step 4 – Create Summary Table

The document must end with:

```markdown
## 📊 Summary Table

| # | Group | Total TC | ✅ Pass | ❌ Fail | ⏭️ Skip |
|---|-------|----------|--------|--------|---------|
| 1 | Happy Path | X | | | |
| 2 | ... | X | | | |
| | **TOTAL** | **XX** | | | |

**Overall Result**: ⬜ PASS / ⬜ FAIL
**Tester**: _______________
**Reviewer**: _______________
**Test Date**: _______________
**Review Date**: _______________
```

---

## Output Format

### Document Header

```markdown
# 📋 Test Cases – [Feature Name]

**Feature**: [Feature Name]
**Module**: [Related modules/classes]
**Tester**: _______________
**Test Date**: _______________
**Build/Version**: _______________
**Device**: _______________

> **Legend**: ✅ = Pass | ❌ = Fail | ⏭️ = Skip | ⬜ = Not tested
```

### Each Scenario Group

```markdown
## X. [GROUP NAME] – [Short description]

**Preconditions**: [Prerequisites]

| ID | Test Case | Steps | Expected Result | Status | Notes |
|----|-----------|-------|-----------------|--------|-------|
| TC-XX | ... | 1. ...<br>2. ... | - ...<br>- ... | ⬜ | |
```

---

## Output Location

Test case document is saved to the artifact directory with the name:
`test_cases_[feature_name].md`

---

### 📋 Next Steps (MANDATORY OUTPUT)
After presenting the test cases, you MUST ALWAYS output this section exactly:

```
## Next Steps
You can:
1. **Verify test cases** — Run `/verify-testcase` to review and update test results (mark ✅/❌/⏭️)
2. **Export to HTML** — Run `/export-html` to export the test case document to a self-contained HTML file for sharing or printing
3. Add new scenarios or modify expected results

Please let me know what you'd like to do next.
```
