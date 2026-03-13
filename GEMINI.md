@~/.claude/global-config/skills/using-superpowers/SKILL.md
@~/.claude/global-config/skills/using-superpowers/references/gemini-tools.md

# CRITICAL RULES - MUST FOLLOW

## Skill Usage Rules (MANDATORY)

### Rule 1: Check Skills BEFORE Any Response

**BEFORE responding to ANY user message, you MUST:**

1. **Analyze the request** - What is the user asking for?
2. **Check if ANY skill applies** - Even 1% chance means invoke
3. **Invoke the skill FIRST** - Use view_file on .agents/skills/<skill-name>/SKILL.md
4. **Follow skill exactly** - No shortcuts, no adaptations
5. **THEN respond** - After following skill instructions

**This applies to:**
- ✅ Feature requests ("Add X")
- ✅ Bug reports ("Fix Y")
- ✅ Questions ("How do I Z?")
- ✅ Modifications ("Change A to B")
- ✅ ANY request that involves action

### Rule 2: Skill Priority Map (MANDATORY)

**You MUST invoke these skills for these situations:**

| User Request Type | MUST Invoke Skill | No Exceptions |
|-------------------|-------------------|---------------|
| "Add feature X" | `brainstorming` | ✅ REQUIRED |
| "Build Y" | `brainstorming` | ✅ REQUIRED |
| "Create Z" | `brainstorming` | ✅ REQUIRED |
| "Implement A" | `brainstorming` → `test-driven-development` | ✅ REQUIRED |
| "Fix bug B" | `systematic-debugging` | ✅ REQUIRED |
| "Tests failing" | `systematic-debugging` | ✅ REQUIRED |
| "Error in C" | `systematic-debugging` | ✅ REQUIRED |
| About to claim "done" | `verification-before-completion` | ✅ REQUIRED |
| About to commit | `verification-before-completion` | ✅ REQUIRED |
| Starting feature work | `using-git-worktrees` | ✅ REQUIRED |

### Rule 3: Red Flags - STOP and Invoke Skill

**If you think ANY of these, STOP and invoke skill:**

❌ "This is just a simple question"
❌ "I need more context first"
❌ "Let me explore the codebase first"
❌ "I'll just do this one thing first"
❌ "This doesn't need a formal skill"
❌ "I remember this skill"
❌ "This is too simple for a skill"
❌ "I can check git/files quickly"

**Reality:** These are rationalizations. Invoke the skill.

### Rule 4: The Iron Law

```
NO RESPONSE WITHOUT SKILL CHECK
NO ACTION WITHOUT SKILL INVOCATION
NO EXCEPTIONS
```

**Enforcement:**
- If you respond without checking skills → VIOLATION
- If you skip skill when one applies → VIOLATION
- If you rationalize not using skill → VIOLATION

### Rule 5: Skill Invocation Format

**Correct way to invoke skills in Antigravity:**

```python
# Use view_file to activate skill
view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
view_file("~/.claude/global-config/skills/test-driven-development/SKILL.md")
view_file("~/.claude/global-config/skills/systematic-debugging/SKILL.md")
```

**After invoking:**
1. Read the skill content completely
2. Follow instructions exactly
3. Do NOT adapt or skip steps
4. Do NOT rationalize shortcuts

---

## 3 Iron Laws (NEVER VIOLATE)

### Law 1: Brainstorming Before Implementation
```
❌ NEVER: Start coding without approved design
✅ ALWAYS: Invoke brainstorming → Design → Approval → Code
```

### Law 2: Test-Driven Development
```
❌ NEVER: Write production code without failing test first
✅ ALWAYS: Test (fail) → Code → Test (pass)
```

### Law 3: Root Cause Before Fixes
```
❌ NEVER: Fix bugs without root cause investigation
✅ ALWAYS: Bug → Investigate → Root Cause → Fix
```

---

## Workflow Enforcement

### For ANY Creative Work:
```
User request
    ↓
Check: Is this creative work? (add/build/create/modify)
    ↓ YES
MUST invoke: view_file("~/.claude/global-config/skills/brainstorming/SKILL.md")
    ↓
Follow brainstorming skill completely
    ↓
Get design approval
    ↓
THEN proceed to implementation
```

### For ANY Implementation:
```
About to write code
    ↓
MUST invoke: view_file("~/.claude/global-config/skills/test-driven-development/SKILL.md")
    ↓
Write failing test FIRST
    ↓
Verify it fails
    ↓
Write minimal code
    ↓
Verify it passes
```

### For ANY Bug/Error:
```
Bug or error encountered
    ↓
MUST invoke: view_file("~/.claude/global-config/skills/systematic-debugging/SKILL.md")
    ↓
Phase 1: Root Cause Investigation
    ↓
Phase 2: Pattern Analysis
    ↓
Phase 3: Hypothesis and Testing
    ↓
Phase 4: Implementation
```

### Before ANY Completion Claim:
```
About to claim "done" or "tests pass"
    ↓
MUST invoke: view_file("~/.claude/global-config/skills/verification-before-completion/SKILL.md")
    ↓
Run verification command
    ↓
Read output
    ↓
THEN claim result with evidence
```

---

## Self-Check Questions (Ask BEFORE Every Response)

1. **Did I check if any skill applies?**
   - [ ] Yes → Continue
   - [ ] No → STOP, check now

2. **Is there even 1% chance a skill applies?**
   - [ ] Yes → Invoke skill FIRST
   - [ ] No → Proceed

3. **Am I rationalizing not using a skill?**
   - [ ] Yes → STOP, invoke skill
   - [ ] No → Continue

4. **Did I follow the skill exactly?**
   - [ ] Yes → Continue
   - [ ] No → Go back, follow exactly

---

## Monitoring and Compliance

**User will monitor for:**
- ❌ Responses without skill check
- ❌ Actions without skill invocation
- ❌ Rationalizations for skipping skills
- ❌ Partial skill following
- ❌ Adaptations instead of exact following

**Consequences of violations:**
- Session will be redirected
- Work may be discarded
- Trust will be broken

---

## Examples

### ✅ CORRECT: User asks to add feature

```
User: "Add authentication feature"

Agent:
1. Analyze: This is creative work (add feature)
2. Check: brainstorming skill applies
3. Invoke: view_file(".agents/skills/brainstorming/SKILL.md")
4. Follow: Ask questions, present design, get approval
5. Then: Proceed to implementation
```

### ❌ WRONG: Skip skill

```
User: "Add authentication feature"

Agent: "I'll create a simple auth system with..."

❌ VIOLATION: Started without brainstorming
❌ VIOLATION: No design approval
❌ VIOLATION: Skipped skill
```

### ✅ CORRECT: User reports bug

```
User: "Login test is failing"

Agent:
1. Analyze: This is a bug/error
2. Check: systematic-debugging skill applies
3. Invoke: view_file(".agents/skills/systematic-debugging/SKILL.md")
4. Follow: Phase 1 → 2 → 3 → 4
5. Then: Propose fix with evidence
```

### ❌ WRONG: Quick fix

```
User: "Login test is failing"

Agent: "Let me check the code... I see the issue, it's missing..."

❌ VIOLATION: No root cause investigation
❌ VIOLATION: Skipped systematic-debugging
❌ VIOLATION: Proposed fix without evidence
```

---

## Summary

**MANDATORY BEHAVIOR:**

1. ✅ Check skills BEFORE every response
2. ✅ Invoke skill if ANY chance it applies (even 1%)
3. ✅ Follow skill exactly, no shortcuts
4. ✅ Never rationalize skipping skills
5. ✅ Enforce 3 Iron Laws always

**FORBIDDEN BEHAVIOR:**

1. ❌ Respond without checking skills
2. ❌ Skip skills when they apply
3. ❌ Rationalize not using skills
4. ❌ Adapt or shortcut skill instructions
5. ❌ Violate Iron Laws

---

**This is not optional. This is mandatory. No exceptions.**
