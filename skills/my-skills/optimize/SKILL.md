---
description: Optimize workflow - apply performance improvements after review
---

# Optimize Workflow

## Purpose
- Apply performance optimization changes after /review
- Do NOT fix correctness issues via this command

---

## Precondition
- /review MUST have been run before
- Optimization recommendations MUST exist in latest /review output

---

## Constraints
- Do NOT apply correctness fixes (ERROR_XX, WARNING_XX)
- Optimization MUST NOT change intended behavior
- Do NOT refactor beyond what is required for optimization

---

## Process
1. Reference optimization recommendations from latest /review
2. Apply only the requested optimizations
3. Verify behavior is unchanged
4. Report what was optimized
