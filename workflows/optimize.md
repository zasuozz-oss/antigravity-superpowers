---
description: Áp dụng optimization changes sau khi review
---

# Optimize Workflow

> **Required Skills**: 
> - Read `skills/my-skills/optimize/SKILL.md` for optimization rules.
> - Read `skills/my-skills/csharp-conventions/SKILL.md` for naming and code style.

## Purpose
Apply performance optimizations to Unity C# code for mobile games. Focus on reducing allocations, caching, and improving runtime efficiency without changing behavior.

## Prerequisites
- This workflow can be used:
  1. **After `/review`**: Apply optimizations identified in the review
  2. **Standalone**: Analyze and optimize a specific file directly

---

## Step 1 – Context Identification
- Identify the script role (Gameplay, UI, Manager, System, Utility).
- Determine execution frequency (per frame, event-driven, one-time).
- Prioritize hot paths (Update, LateUpdate, FixedUpdate, frequently called methods).

---

## Step 2 – Allocation Analysis

### Update Loop Allocations
- Detect `new` statements in Update loops.
- Flag boxing operations (value type → object).
- Identify delegate/lambda creation in loops.

### String Operations
- Detect string concatenation in hot paths.
- Flag `string.Format` without caching.
- Recommend StringBuilder for repeated concatenations.

### Collection Operations
- Detect LINQ in hot paths (.Where, .Select, .ToList, etc.).
- Flag foreach on non-cached collections.
- Recommend pre-allocated lists/arrays.

---

## Step 3 – Caching Opportunities

### Component Caching
- Detect repeated GetComponent calls.
- Flag Find/FindObjectOfType in runtime code.
- Recommend caching in Awake/Start.

### Calculation Caching
- Detect repeated expensive calculations.
- Flag property access in loops that could be cached.
- Recommend local variable caching.

---

## Step 4 – Loop Optimization

### Early Exit
- Detect loops that could exit early after finding result.
- Flag missing `break` after match found.

### Iteration Reduction
- Detect nested loops that could be flattened.
- Flag O(n²) patterns that could be O(n).
- Recommend dictionary/hashset for lookups.

---

## Step 5 – Event-Driven Patterns

### Polling Detection
- Detect Update-based polling patterns.
- Recommend event-driven alternatives.
- Flag unnecessary per-frame checks.

---

## Output Format

### 🚀 Optimization Opportunities
#### 🚀 OPT-XX: <Unique title>
- **Location**: <clickable link>
- **Issue**: (what causes performance problem)
- **Category**: Allocation | Caching | Loop | Event-Driven
- **Impact**: High | Medium | Low
- **Guarantee**: Does NOT alter behavior

### Suggested Optimization Fixes
#### Fix OPT-XX: <Same title>
- **Location**: <clickable link>
- **Before/After**: Show code change
- **Performance gain**: Estimated improvement

### Rules
- Optimization MUST NOT change intended behavior
- No logic changes, only performance improvements
- No rewrite beyond what is required
- No refactor unless explicitly allowed
- Verify behavior remains identical

---

## Allowed Optimization Types
- Caching (GetComponent, Find, repeated calculations)
- Allocation reduction (object pooling, reuse collections)
- Loop optimization (reducing iterations, early exits)
- String handling (StringBuilder, string caching)
- LINQ removal in hot paths
- Event-driven replacement for polling patterns

## Not Allowed
- Changing gameplay logic or timing
- Modifying DOTween sequence behavior
- Altering UI state flow
- Changing serialized field values
- Introducing new dependencies or packages

---

## Apply Commands
```
/optimize all         - Apply all optimizations
/optimize OPT-01      - Apply specific optimization
/optimize OPT-01,OPT-02  - Apply multiple optimizations
```

---

### 📋 Next Steps (MANDATORY OUTPUT)
After presenting optimization results, ALWAYS output this section:

```
## Next Steps
You can:
- `/optimize all` - apply all optimizations
- `/optimize OPT-XX` - apply specific optimization
- Compile and test in Unity Editor
- Run Profiler to compare performance

Please let me know what you'd like to do next.
```
