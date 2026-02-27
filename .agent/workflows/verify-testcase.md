---
description: Verify and update test case results from a previous /test-case run. Walk through each test case, record Pass/Fail/Skip, update the summary table, and suggest next steps.
---

# Verify Test Case Workflow

> Interactively verify test case results and update the test case document.

## Purpose
Walk through an existing test case document, help the user record results for each test case (✅ Pass / ❌ Fail / ⏭️ Skip), update the summary table, and provide an overall verdict.

---

## Step 1 – Locate the Test Case Document

1. Search the current conversation's artifact directory for `test_cases_*.md` files.
2. If multiple test case documents exist, list them and ask the user which one to verify.
3. If no test case document is found:
   - Inform the user: "No test case document found. Please run `/test-case` first to generate one."
   - Stop.

---

## Step 2 – Present Verification Session

1. Read the test case document.
2. Display a summary of all test case groups and total number of TCs:

```
## Verification Session — [Feature Name]
Total: XX test cases across Y groups

| # | Group | Total TC | Status |
|---|-------|----------|--------|
| 1 | Happy Path | X | ⬜ Not started |
| 2 | ... | X | ⬜ Not started |
```

3. Ask the user how they want to proceed:
   - **Group by group** — verify one group at a time
   - **Bulk update** — user provides results for all TCs at once (e.g., "TC-01 Pass, TC-02 Fail, TC-05 Skip")
   - **Mark all as Pass** — shortcut if everything passed

---

## Step 3 – Record Results

### Option A: Group by Group
For each group:
1. Display all test cases in the group with their Steps and Expected Results.
2. Ask the user for the result of each TC: **Pass / Fail / Skip**.
3. If **Fail**: ask the user for a brief failure note (optional).
4. Update each TC status in the document.

### Option B: Bulk Update
1. Accept user input in format: `TC-01 Pass, TC-02 Fail: [reason], TC-03 Skip`
2. Parse and apply all results.
3. Any TC not mentioned remains ⬜ (Not tested).

### Option C: Mark All as Pass
1. Set all TCs to ✅ Pass.
2. Confirm with the user before saving.

---

## Step 4 – Update the Document

1. Update each test case's **Status** column in the markdown table.
2. For failed TCs, add the failure reason to the **Notes** column.
3. Update the **Summary Table** at the bottom:

```markdown
## 📊 Summary Table

| # | Group | Total TC | ✅ Pass | ❌ Fail | ⏭️ Skip |
|---|-------|----------|--------|--------|---------|
| 1 | Happy Path | X | X | X | X |
| 2 | ... | X | X | X | X |
| | **TOTAL** | **XX** | **XX** | **XX** | **XX** |

**Overall Result**: ✅ PASS / ❌ FAIL
**Tester**: _______________
**Reviewer**: _______________
**Test Date**: _______________
**Review Date**: _______________
```

4. Set **Overall Result**:
   - ✅ **PASS** — if zero ❌ Fail
   - ❌ **FAIL** — if any ❌ Fail exists

5. Save the updated document back to the artifact directory.

---

## Step 5 – Present Final Report

Display a concise verification report:

```
## ✅ Verification Complete — [Feature Name]

- **Total**: XX test cases
- **Pass**: XX ✅
- **Fail**: XX ❌
- **Skip**: XX ⏭️
- **Not tested**: XX ⬜
- **Overall**: PASS / FAIL

### Failed Test Cases (if any)
| ID | Test Case | Failure Note |
|----|-----------|--------------|
| TC-XX | ... | ... |
```

---

### 📋 Next Steps (MANDATORY OUTPUT)
After presenting the verification report, you MUST ALWAYS output this section exactly:

```
## Next Steps
You can:
1. **Export to HTML** — Run `/export-html` to export the verified test case document to a self-contained HTML file for sharing or printing
2. **Fix failed cases** — Investigate and fix the root cause of failed test cases
3. **Re-verify** — Run `/verify-testcase` again after fixes are applied
4. **Add new scenarios** — Run `/test-case` to add more test cases

Please let me know what you'd like to do next.
```
