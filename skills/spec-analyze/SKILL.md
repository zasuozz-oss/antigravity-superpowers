---
name: spec-analyze
description: Use after generating a plan and tasks to perform cross-artifact consistency analysis. Detects contradictions, coverage gaps, and ambiguities across spec, plan, tasks, and constitution without modifying any files.
---

# Spec Analyze

## Overview

Perform a non-destructive cross-artifact consistency and quality analysis across spec, plan, tasks, and constitution documents. Identify inconsistencies, duplications, ambiguities, and underspecified items before implementation.

**Announce at start:** "I'm using the spec-analyze skill to check consistency across project artifacts."

## When to Use

- After **task-decomposition** — to validate spec ↔ plan ↔ tasks alignment
- After **writing-plans** — to check spec ↔ plan consistency (even without tasks)
- When **suspecting drift** between artifacts
- Before **executing-plans** — as a quality gate

## Operating Constraints

**STRICTLY READ-ONLY**: Do **not** modify any files. Output a structured analysis report only. Offer an optional remediation plan (user must explicitly approve before any editing).

**Constitution Authority**: If `.superpowers/constitution.md` exists, it is **non-negotiable** within analysis scope. Constitution conflicts are automatically CRITICAL severity.

## The Process

### Step 1: Load Artifacts

Identify and load available artifacts:
- **Spec/Design** — brainstorming output (design doc, spec)
- **Plan** — `docs/superpowers/plans/<feature>/plan.md` or implementation plan
- **Tasks** — `docs/superpowers/plans/<feature>/tasks.md` (if task-decomposition was run)
- **Constitution** — `.superpowers/constitution.md` (if project-constitution was run)

Minimum requirement: **at least 2 artifacts** must exist. Abort if only 1 available.

### Step 2: Build Semantic Models

Create internal representations (do NOT output raw artifacts):

- **Requirements inventory**: For each FR-### and SC-### in spec, record a stable key
- **User story inventory**: Discrete user actions with acceptance criteria
- **Task coverage mapping**: Map each task to requirements/stories (by keyword/ID matching)
- **Constitution rule set**: Extract principle names and MUST/SHOULD directives

### Step 3: Detection Passes

Run 6 detection passes. Focus on high-signal findings. Limit to **50 findings total**.

#### A. Duplication Detection
- Near-duplicate requirements in spec
- Mark lower-quality phrasing for consolidation

#### B. Ambiguity Detection
- Vague adjectives lacking measurable criteria: fast, scalable, secure, intuitive, robust
- Unresolved placeholders: TODO, TKTK, ???, `<placeholder>`, `[NEEDS CLARIFICATION]`

#### C. Underspecification
- Requirements with verbs but missing object or measurable outcome
- User stories missing acceptance criteria
- Tasks referencing files/components not defined in spec or plan

#### D. Constitution Alignment
- Any requirement or plan element conflicting with a MUST principle
- Missing mandated sections or quality gates from constitution
- **Constitution violations are always CRITICAL severity**

#### E. Coverage Gaps
- Requirements with zero associated tasks
- Tasks with no mapped requirement/story
- Success Criteria requiring buildable work not reflected in tasks

#### F. Inconsistency
- Terminology drift (same concept named differently across files)
- Data entities referenced in plan but absent in spec (or vice versa)
- Task ordering contradictions (integration tasks before foundational tasks)
- Conflicting tech choices across artifacts

### Step 4: Severity Assignment

| Severity | Criteria |
|----------|----------|
| **CRITICAL** | Violates constitution MUST, missing core artifact, requirement with zero coverage blocking baseline |
| **HIGH** | Duplicate/conflicting requirement, ambiguous security/performance attribute, untestable acceptance criteria |
| **MEDIUM** | Terminology drift, missing non-functional task coverage, underspecified edge case |
| **LOW** | Style/wording improvements, minor redundancy |

### Step 5: Output Analysis Report

Output a Markdown report (NO file writes) with:

**Findings Table:**

| ID | Category | Severity | Location(s) | Summary | Recommendation |
|----|----------|----------|-------------|---------|----------------|
| A1 | Duplication | HIGH | spec:L120 | Two similar requirements... | Merge, keep clearer version |
| D1 | Constitution | CRITICAL | plan:§Architecture | Violates Principle II... | Revise plan approach |

**Coverage Summary:**

| Requirement Key | Has Task? | Task IDs | Notes |
|-----------------|-----------|----------|-------|
| FR-001 | ✅ | T003, T005 | |
| FR-002 | ❌ | — | No associated task |

**Constitution Alignment Issues:** (if applicable)

**Unmapped Tasks:** (if any)

**Metrics:**
- Total Requirements: N
- Total Tasks: N
- Coverage %: N%
- Ambiguity Count: N
- Duplication Count: N
- Critical Issues: N

### Step 6: Next Actions

- If **CRITICAL issues** exist: Recommend resolving before executing-plans
- If only **LOW/MEDIUM**: User may proceed, provide improvement suggestions
- Suggest specific actions: "Revise spec requirement FR-003", "Add task for SC-002"

### Step 7: Offer Remediation

Ask: "Would you like me to suggest concrete edits for the top N issues?"

**Do NOT apply edits automatically** — user must explicitly approve.

## Integration

- **Predecessors:** `writing-plans`, `task-decomposition`
- **Successor:** `executing-plans` (if analysis passes)
- **Loop back:** If CRITICAL issues → return to `writing-plans` or `brainstorming`
- **Reads:** `project-constitution` output for alignment checks

## Remember

- **NEVER modify files** — this is read-only analysis
- **NEVER hallucinate missing sections** — report accurately
- **Prioritize constitution violations** — always CRITICAL
- **Use specific examples** — cite instances, not generic patterns
- **Report zero issues gracefully** — emit success report with coverage statistics
- Maximum 50 findings — summarize overflow
