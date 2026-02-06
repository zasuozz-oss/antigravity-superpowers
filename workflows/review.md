---
description: Review code for correctness and mobile performance
---

# Unity Mobile Code Review Workflow

> **Required Skills**: 
> - Read `skills/my-skills/review/SKILL.md` for detailed checklist and process.
> - Read `skills/my-skills/csharp-conventions/SKILL.md` for naming and code style.

## Purpose
Review Unity C# code for mobile games with focus on performance, memory safety, and maintainability.

## Next Steps
After completing this workflow:
1. Provide the review output following the format below.
2. Ask the user if they want to apply any fixes using commands: `/fix <id>`, `/fixall`, etc.
3. Wait for user input.

---

## Step 1 – Context Identification
- Identify the script role (Gameplay, UI, Manager, System, Utility).
- Determine execution frequency (per frame, event-driven, one-time).
- Detect over-responsibility or tight coupling.

---

## Step 2 – Performance Analysis (Mobile First)

### Update Loop Usage
- Inspect logic inside Update, LateUpdate, FixedUpdate.
- Flag heavy computations or unnecessary per-frame execution.
- Suggest event-based or timed execution when applicable.

### Garbage Collection
- Detect allocations in runtime loops.
- Identify string concatenation and LINQ usage.
- Recommend pooling, caching, and reuse strategies.

### Memory Management
- Check for temporary object creation.
- Validate proper event unsubscription.
- Identify potential memory leaks.

---

## Step 3 – Unity API Best Practices
- Avoid runtime object searching (Find, FindObjectOfType).
- Ensure GetComponent calls are cached.
- Validate correct lifecycle usage (Awake, Start, OnEnable, OnDisable).
- Check mobile pause and resume handling.

---

## Step 4 – Code Quality
- Validate naming clarity and consistency.
- Identify oversized methods or classes.
- Ensure correct access modifiers.
- Prefer serialized private fields over public exposure.

---

## Step 5 – Runtime Safety
- Validate null safety.
- Check coroutine and async lifecycle control.
- Ensure safe execution on low-end devices.
### Incomplete Error Handling Pattern

#### Definition
When exception handling catches an error but fails to perform required cleanup,
leaving UI elements or resources in an inconsistent or incorrect state.

This typically occurs when cleanup logic is placed only inside the `try` block
and is skipped if an exception is thrown.

#### Problem example

```csharp
try
{
    // ... logic ...
    loadingElement.SetActive(false); // Runs only if no exception
}
catch (System.Exception ex)
{
    Debug.LogError(ex);
}
```

---

## Step 5.5 – Resource Pairing & State Flow Analysis (Generic Principle)

### Paired Resource Principle
Every "acquire" operation MUST have a matching "release" in ALL exit paths.

**Common pairs to verify:**
| Acquire | Release |
|---------|---------|
| Show / Open / Enable | Hide / Close / Disable |
| Subscribe / += | Unsubscribe / -= |
| Lock / Acquire | Unlock / Release |
| Start animation | Kill / Complete animation |

**Check ALL exit points:**
- Normal completion path
- Early returns (guard clauses)
- Exception handlers (catch/finally)
- Cancellation paths (CancellationToken)

### State Flow Principle
For methods with multiple state variables affecting control flow:

1. **Enumerate state combinations**: List boolean/enum states that affect branching
2. **Trace edge cases**: What happens when unusual combinations occur?
3. **Verify cleanup**: Does every path clean up resources properly?

**Example questions to ask:**
- If `!hasMorePage && !isRefresh` → Is cleanup performed before return?
- If async operation is cancelled → Are pending UI states reset?
- If initialization fails → Are flags and resources in consistent state?

---

## Step 6 – Scalability and Maintainability
- Detect magic numbers and hard-coded logic.
- Identify scene or object name dependencies.
- Suggest configuration or abstraction where appropriate.

---

## Step 7 – Review Summary
- List strengths.
- List issues with reasoning.
- Provide prioritized recommendations.

---

## Output Format

### ❌ ERRORS
#### ❌ <Unique error title>
- Location: <clickable link>
- Description: (behavior, not solution)
- Impact: Runtime error / crash / incorrect logic
- Confidence: High | Medium | Low

### ⚠️ Warnings
#### ⚠️ <Unique warning title>
- Location: <clickable link>
- Description: (potential issue, edge case)
- Impact: Future bug / readability risk
- Confidence: High | Medium | Low

### 🚀 Optimization Opportunities
#### 🚀 <Unique title>
- Location: <clickable link if available>
- Issue: (what causes performance problem)
- Guarantee: Does NOT alter behavior

> **Note**: Use `/optimize` to view details and apply optimizations.

### Suggested Minimal Fixes (Correctness Only)
- Each fix maps to ONE Error/Warning (same title)
- Location + Reason + Patched code
- Do NOT include optimization fixes here

### Rules
- Correctness before optimization
- No auto-apply; user must request fix
- Location = single clickable link only
- Missing null checks on serialized fields → NOT ERROR
- Optimization details → only via `/optimize` command

---

### 📋 Next Steps (MANDATORY OUTPUT)
After presenting the review results, ALWAYS output this section:

```
## Next Steps
You can:
- `/fix <id>` - apply specific fix
- `/fixall` - apply all fixes
- `/fixallerror` - apply all ERROR fixes
- `/fixallwarning` - apply all WARNING fixes
- `/optimize` - apply optimizations (if any)

Please let me know what you'd like to do next.
```