---
description: Code review workflow for Unity mobile projects - correctness, lifecycle, performance analysis
---

# Review Skill

## Purpose
- Review code for correctness and mobile performance risks
- Identify errors (definite bugs/crash) and warnings (likely risks)
- Propose minimal, safe fixes for correctness issues only (via fix_id)
- Provide optimization recommendations (no fix_id) without changing behavior
- Do not apply any code changes during review

## Scope
- Context-based only: review only files/snippets provided
- Runtime script focus: analyze runtime behavior and code paths
- Do not assume project-wide state

## Review Order (always)
1. Correctness first (logic + stability)
2. Lifecycle safety (Unity execution model)
3. Mobile performance (GC/FPS hot paths)
4. Minimal fix proposals (review-assigned IDs)
5. Optimization opportunities (recommendations only)
6. Output + confirmation + next steps

---

## Step 1 — Scope Lock (mandatory)

Do:
- Restate the review target in one sentence
- State what files/features are being reviewed
- State what the reported issue or intention is

Do not:
- Expand scope to unrelated systems
- Assume missing context

If scope is unclear: ask at most 2 short questions

---

## Step 2 — Correctness Scan (mandatory)

### Logic Correctness Checklist
- Arithmetic / formula correctness (division by self, wrong numerator/denominator, integer truncation)
- Conditions and branching (wrong comparisons, inverted conditions, missing guards)
- State transitions (invalid states, missing resets, double triggers, race conditions)
- Collections and indexing (out-of-range, null elements, modifying during iteration)
- Data mapping (wrong field mapped to UI, stale cached data)
- Time dependence (frame-based timers vs Time.deltaTime)
- Error handling (silent failure patterns, swallowed exceptions)

### Crash Risks Checklist
- Null reference risks (serialized fields not assigned, GetComponent not checked, destroyed but referenced)
- Unity object lifetime (using destroyed objects in async callbacks, missing guard after await/yield)
- Threading misuse (calling Unity API from background threads)
- Invalid casts (as-cast without null handling)

Output mapping:
- Definite bug/crash => ERRORS
- Likely/conditional risk => Warnings

---

## Step 3 — Lifecycle Safety (mandatory)

### Initialization Checklist
- Awake: internal wiring, cache references
- Start: dependencies that require scene ready
- OnEnable: subscribe events, start routines (guarded)
- OnDisable/OnDestroy: unsubscribe events, stop routines, release references

### Subscription Symmetry
- Each subscribe has a matching unsubscribe
- Avoid multiple subscriptions from repeated OnEnable

### Coroutine/Async Safety
- Coroutines stopped on disable/destroy if they drive UI/game state
- Async callbacks guarded against object destruction
- Cancellation tokens or guard flags for long-running flows

### Common Mobile UI Pitfalls
- UI updated while object is inactive
- Multiple listeners causing duplicated clicks
- Layout rebuild loops from enable/disable churn

---

## Step 4 — Mobile Performance Review (mandatory)

### Hot Path Identification
- Update/LateUpdate/FixedUpdate
- Frequently called UI refresh methods
- Per-frame animations/tweens
- List building, sorting, formatting in loops

### GC Allocation Checklist
- String allocations (concatenation in loops, ToString() per frame, string.Format in hot paths)
- LINQ allocations (.Where/.Select/.ToList/.OrderBy in hot paths)
- Boxing allocations (interface calls on structs, non-generic collections)
- Closures and lambdas (allocating delegates repeatedly)
- Repeated temporary allocations (new lists/dicts each frame)

### CPU Checklist
- Repeated GetComponent/Find in loops
- Expensive math per frame without caching
- Excessive sorting per frame
- Rebuilding UI elements unnecessarily

---

## Step 5 — Build Suggested Fixes (correctness only)

Rules:
- Use REVIEW-ASSIGNED finding ID as heading: "ERROR_XX - <title>" or "WARNING_XX - <title>"
- Each fix block must include: Location, Reason, Patched code (proposed)
- Keep changes minimal and localized
- Do not change public APIs unless explicitly requested

---

## Step 6 — Confirmation + Next Steps (mandatory)

Confirmation question:
- Ask if user wants to apply fixes now

Accepted inputs:
- "fix all ERROR"
- "fix all WARNING"
- "fix all"
- "fix <fix_id>"

---

## Output Format

### ❌ ERRORS

#### ❌ <Unique error title>
- Location: <single clickable link with line>
- Description: Describe exactly what is incorrect
- Impact: Runtime error / crash / incorrect logic / data corruption
- Confidence: High | Medium | Low

Rules:
- Error titles MUST be unique
- If location cannot be verified: write "cannot verify location"
- Missing null checks on serialized/public fields MUST NOT be ERROR

### ⚠️ Warnings

#### ⚠️ <Unique warning title>
- Location: <single clickable link with line>
- Description: Potential issue, edge case, or maintainability risk
- Impact: Possible future bug / degraded readability
- Confidence: High | Medium | Low

### ℹ️ Informational Notes
- <Unique note title>: Short explanation
- No severity icon, no location required
- Inspector-assignable reference issues go here ONLY

### 🚀 Optimization Opportunities

#### 🚀 <Unique optimization title>
- Location: <single clickable link if available>
- Reason: Why this improves performance
- Guarantee: This change does NOT alter intended behavior

### Suggested Minimal Fixes (Correctness)

#### ❌ <Unique issue title>
- Severity: ERROR | WARNING
- Location: <single clickable link with line>
- Reason: Why this fix resolves the issue
- Patched code (proposed): Minimal code changes only

### Apply Response

- Selected issue titles: list
- Changes summary: short summary
- Code (final): only selected titles
- Validation steps: how to verify
- Risks & assumptions: remaining risks
