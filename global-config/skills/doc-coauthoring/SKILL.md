---
name: doc-coauthoring
description: Use when co-authoring documents with the user — PRDs, design docs, decision docs, RFCs, proposals, specs, or any substantial writing task. Provides a structured 3-stage workflow for high-quality collaborative document creation.
---

# Doc Co-Authoring Workflow

A structured workflow for collaborative document creation. Walk users through three stages: **Context Gathering**, **Refinement & Structure**, and **Reader Testing**.

## When to Offer This Workflow

**Trigger conditions:**
- User mentions writing documentation: "write a doc", "draft a proposal", "create a spec", "write up"
- User mentions specific doc types: "PRD", "design doc", "decision doc", "RFC"
- User seems to be starting a substantial writing task

**Initial offer:** Explain the three stages and ask if they want structured workflow or freeform. If declined, work freeform.

---

## Stage 1: Context Gathering

**Goal:** Close the gap between what the user knows and what you know.

### Initial Questions
Ask for meta-context:
1. What type of document is this?
2. Who's the primary audience?
3. What's the desired impact when someone reads this?
4. Is there a template or specific format to follow?
5. Any other constraints or context?

### Info Dumping
Encourage user to dump ALL context:
- Background on the problem
- Related discussions or documents
- Why alternatives aren't being used
- Organizational context
- Timeline pressures or constraints
- Technical architecture or dependencies
- Stakeholder concerns

Tell them: don't worry about organizing — just get it all out.

**If user mentions URLs or documents:** Use `read_url_content` to pull in context directly.

### Clarifying Questions
After initial dump, ask 5-10 numbered questions based on gaps. Allow shorthand answers.

**Exit condition:** Sufficient context gathered — you can ask about edge cases and trade-offs without needing basics explained.

---

## Stage 2: Refinement & Structure

**Goal:** Build the document section by section through brainstorming, curation, and iterative refinement.

### Setup
1. If structure is clear: ask which section to start with
2. If unclear: suggest 3-5 sections appropriate for the doc type
3. Create initial scaffold using `write_to_file` with section headers and `[To be written]` placeholders

### For Each Section

**Step 1: Clarifying Questions** — Ask 5-10 specific questions about what to include

**Step 2: Brainstorming** — Generate 5-20 numbered options for what to include. Look for:
- Context shared that might have been forgotten
- Angles or considerations not yet mentioned

**Step 3: Curation** — Ask which points to keep/remove/combine:
- "Keep 1,4,7,9"
- "Remove 3 (duplicates 1)"
- "Combine 11 and 12"

**Step 4: Gap Check** — Ask if anything important is missing

**Step 5: Drafting** — Use `replace_file_content` to replace placeholder with drafted content

**Step 6: Iterative Refinement** — As user provides feedback:
- Use `replace_file_content` for surgical edits (never reprint the whole doc)
- Continue iterating until user is satisfied

### Key Instruction for User
"Instead of editing the doc directly, tell me what to change — this helps me learn your style for future sections."

### Near Completion (80%+ sections done)
Re-read entire document and check for:
- Flow and consistency across sections
- Redundancy or contradictions
- Anything that feels like generic filler
- Whether every sentence carries weight

---

## Stage 3: Reader Testing

**Goal:** Test that the document works for someone reading it fresh (no prior context).

### Step 1: Predict Reader Questions
List 5-10 questions a reader might have after reading the doc.

### Step 2: Self-Review
Re-read the document from scratch as if you have zero context. Identify:
- Unclear sections (reader wouldn't understand)
- Missing context (reader would be confused)
- Ambiguous language
- Assumptions that aren't stated

### Step 3: Report and Fix
Present findings to user. For each issue:
- Quote the problematic text
- Explain why it's unclear
- Suggest a fix

Apply approved fixes using `replace_file_content`.

### Exit Condition
Reader testing passes when no major comprehension issues remain.

---

## Final Review

Before declaring the document complete:
1. Read through the entire document one final time
2. Check for overall coherence, flow, completeness
3. Provide any final suggestions
4. Ask user for sign-off

## Tips for Effective Guidance
- Always use `replace_file_content` for edits — never dump the full document
- Track what you learn about user's style across sections
- If user edits the doc directly, note their changes to learn preferences
- After 3 consecutive iterations with no substantial changes, suggest trimming
