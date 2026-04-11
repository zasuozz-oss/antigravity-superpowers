---
name: spec-clarify
description: Use after writing a spec or design document to validate completeness. Identifies underspecified areas through up to 5 targeted clarification questions and encodes answers back into the spec.
---

# Spec Clarify

## Overview

Detect and reduce ambiguity or missing decision points in a feature specification by asking up to 5 highly targeted clarification questions. Encode clarifications directly back into the spec file.

**Announce at start:** "I'm using the spec-clarify skill to validate and refine this specification."

## When to Use

- **After brainstorming** — when a spec/design document has been produced
- **Before writing-plans** — to ensure the spec is clean enough for planning
- When a spec contains `[NEEDS CLARIFICATION]` markers
- When you suspect implicit assumptions or missing edge cases

## The Process

### Step 1: Load the Spec

1. Identify the spec/design document (ask user if unclear)
2. Read the full document
3. If spec file is missing: instruct user to run brainstorming first

### Step 2: Structured Ambiguity Scan

Perform a coverage scan using this taxonomy. For each category, mark status as **Clear** / **Partial** / **Missing**:

| # | Category | What to check |
|---|----------|---------------|
| 1 | **Functional Scope & Behavior** | Core user goals, success criteria, out-of-scope declarations |
| 2 | **Domain & Data Model** | Entities, attributes, relationships, identity rules, state transitions |
| 3 | **Interaction & UX Flow** | Critical user journeys, error/empty/loading states |
| 4 | **Non-Functional Quality Attributes** | Performance targets, scalability limits, reliability, security |
| 5 | **Integration & External Dependencies** | External services, failure modes, data formats |
| 6 | **Edge Cases & Failure Handling** | Negative scenarios, rate limiting, conflict resolution |
| 7 | **Constraints & Tradeoffs** | Technical constraints, rejected alternatives |
| 8 | **Terminology & Consistency** | Canonical terms, avoided synonyms |
| 9 | **Completion Signals** | Acceptance criteria testability, Definition of Done |
| 10 | **Misc / Placeholders** | TODO markers, unresolved decisions, vague adjectives |

### Step 3: Generate Question Queue

From categories with **Partial** or **Missing** status, generate a prioritized queue:

- **Maximum 5 questions** across the entire session
- Prioritize by **Impact × Uncertainty** heuristic
- Each question must be answerable with:
  - **Multiple-choice** (2-5 options), OR
  - **Short answer** (≤5 words)
- Only include questions that **materially impact** architecture, data modeling, task decomposition, test design, UX behavior, or compliance
- Skip questions already answered, trivial preferences, or plan-level details

### Step 4: Sequential Questioning (Interactive)

Present **exactly one question at a time**:

**For multiple-choice questions:**
1. Analyze all options and determine the most suitable one
2. Present recommended option: `**Recommended:** Option [X] — [reasoning]`
3. Show all options in a table:

| Option | Description |
|--------|-------------|
| A | [Option A description] |
| B | [Option B description] |
| C | [Option C description] |

4. Tell user: "Reply with the option letter, say 'yes' to accept recommendation, or provide your own short answer."

**For short-answer questions:**
1. Provide suggested answer: `**Suggested:** [answer] — [reasoning]`
2. Tell user: "Reply with your answer (≤5 words), or say 'yes' to accept suggestion."

**After each answer:**
- Validate it maps to an option or fits the constraint
- If ambiguous: ask disambiguation (same question, doesn't count as new)
- Record answer, move to next question

**Stop asking when:**
- All critical ambiguities resolved
- User says "done" / "stop" / "proceed"
- Reached 5 questions

### Step 5: Integrate into Spec (After Each Answer)

After each accepted answer, update the spec file:

1. Ensure a `## Clarifications` section exists (create if missing)
2. Under it, create `### Session YYYY-MM-DD` subheading
3. Append: `- Q: [question] → A: [answer]`
4. Apply clarification to the appropriate section:
   - Functional ambiguity → Update Functional Requirements
   - Data shape → Update Data Model / Key Entities
   - Non-functional → Add measurable criteria to Success Criteria
   - Edge case → Add to Edge Cases section
   - Terminology conflict → Normalize across spec
5. **Replace** any obsolete contradictory text (don't duplicate)
6. **Save after each integration** (atomic writes)

### Step 6: Report

After questioning ends, output:
- Number of questions asked & answered
- Path to updated spec
- Sections touched
- **Coverage summary table:**

| Category | Status | Notes |
|----------|--------|-------|
| Functional Scope | ✅ Resolved | Was Partial, addressed in Q1 |
| Domain & Data Model | ⏳ Deferred | Exceeds quota, better for planning |
| ... | ✅ Clear | Already sufficient |
| ... | ⚠️ Outstanding | Still Partial, low impact |

- Suggest next step (usually `writing-plans`)

## Constraints

- **NEVER** exceed 5 total asked questions
- **NEVER** reveal future queued questions
- Clarification retries for same question don't count as new questions
- Respect user early termination signals
- If no meaningful ambiguities found: report "No critical ambiguities detected" and suggest proceeding

## Integration

- **Predecessor:** `brainstorming` — produces the spec this skill validates
- **Successor:** `writing-plans` — consumes the clarified spec
- **Optional loop:** If clarification reveals major gaps → return to `brainstorming`
