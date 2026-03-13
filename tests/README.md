# Test Cases — Antigravity Superpowers

Paste each prompt into Antigravity on any project, then verify the expected behavior.

---

## 🔵 Implicit Skill Triggering

Agent must **automatically recognize** context and activate the correct skill — user does NOT name the skill.

---

### TC-01: Systematic Debugging

**Prompt:**
```
I'm getting an error when running the app. It was working yesterday but now it crashes on startup.
Can you figure out what's going wrong and fix it?
```

**Expected:**
- [ ] Activates `systematic-debugging` skill
- [ ] Calls `view_file` on SKILL.md before taking action
- [ ] Investigates root cause first (Phase 1)
- [ ] Does NOT fix immediately without finding the cause

---

### TC-02: Test-Driven Development

**Prompt:**
```
I need to add a new feature to validate email addresses. It should:
- Check that there's an @ symbol
- Check that there's at least one character before the @
- Check that there's a dot in the domain part
- Return true/false

Can you implement this?
```

**Expected:**
- [ ] Activates `brainstorming` skill (design before code)
- [ ] Does NOT write code immediately
- [ ] Proposes design first, asks for approval
- [ ] When implementing: writes test first, then code

---

### TC-03: Writing Plans

**Prompt:**
```
Here's the spec for our new authentication system:

Requirements:
- Users can register with email/password
- Users can log in and receive a JWT token
- Protected routes require valid JWT
- Tokens expire after 24 hours
- Support password reset via email

We need to implement this. There are multiple steps involved.
```

**Expected:**
- [ ] Activates `brainstorming` skill (design first)
- [ ] Does NOT jump into code
- [ ] Asks clarifying questions
- [ ] Proposes 2-3 approaches
- [ ] After approval → transitions to `writing-plans`

---

### TC-04: Dispatching Parallel Agents

**Prompt:**
```
I have several unrelated issues in this project:

1. There's a broken link in the README
2. One of the config files has a typo causing errors
3. The documentation is outdated in some sections
4. A helper function is returning wrong output

These are independent problems. Can you investigate all of them?
```

**Expected:**
- [ ] Recognizes 4 independent tasks
- [ ] Activates `dispatching-parallel-agents` or `systematic-debugging`
- [ ] Processes in parallel or logical order
- [ ] Does NOT blindly fix without investigating each one

---

### TC-05: Code Review

**Prompt:**
```
I just finished a big refactor. All the code is committed.
Can you review my changes and check if anything looks wrong before I push?
```

**Expected:**
- [ ] Activates `requesting-code-review` skill
- [ ] Checks code quality, architecture, tests
- [ ] Categorizes issues (Critical / Important / Suggestion)
- [ ] Mentions good work before highlighting issues

---

## 🟢 Explicit Skill Requests

Agent must **obey** when the user explicitly names a skill.

---

### TC-06: Explicit Brainstorming

**Prompt:**
```
please use the brainstorming skill to help me think through this feature
```

**Expected:**
- [ ] Activates `brainstorming` immediately
- [ ] Calls `view_file` on SKILL.md first
- [ ] Asks clarifying questions one at a time

---

### TC-07: Explicit Debugging

**Prompt:**
```
use the systematic debugging skill to investigate why my API returns 500
```

**Expected:**
- [ ] Activates `systematic-debugging` immediately
- [ ] Starts Phase 1: Root cause investigation
- [ ] Does NOT propose fix before finding the cause

---

### TC-08: Casual Request (Skip Formalities)

**Prompt:**
```
hey just brainstorm with me real quick about adding dark mode to the app
```

**Expected:**
- [ ] Still activates `brainstorming` despite casual tone
- [ ] Does NOT skip skill because user said "real quick"
- [ ] Still follows the process: ask → design → approve

---

### TC-09: Abbreviation Understanding

**Prompt:**
```
let's use SDD for implementing the dashboard feature
```

**Expected:**
- [ ] Understands SDD = Subagent-Driven Development
- [ ] Activates `subagent-driven-development` skill

---

## 🟠 Workflow Tests

Test workflows: `/brainstorm`, `/write-plan`, `/execute-plan`, `/code-review`.

---

### TC-10: Brainstorm Workflow

**Prompt:**
```
/brainstorm

I want to add a notification system to my app. Users should receive notifications for:
- New messages
- System alerts
- Friend requests
```

**Expected:**
- [ ] Runs brainstorm workflow
- [ ] Asks clarifying questions (one at a time)
- [ ] Proposes 2-3 approaches
- [ ] Presents design
- [ ] Waits for approval before coding

---

### TC-11: Write Plan Workflow

**Prompt:**
```
/write-plan

Based on our approved notification system design, create an implementation plan.
```

**Expected:**
- [ ] Creates `implementation_plan.md`
- [ ] Breaks into concrete tasks with file paths
- [ ] Estimates complexity (S/M/L)
- [ ] Includes verification plan
- [ ] Asks user for approval before proceeding

---

### TC-12: Execute Plan Workflow

**Prompt:**
```
/execute-plan

Execute the approved implementation plan.
```

**Expected:**
- [ ] Reads `implementation_plan.md`
- [ ] Creates/updates `task.md`
- [ ] Follows TDD cycle: test first → code → verify
- [ ] Updates `[ ] → [/] → [x]` in task.md
- [ ] Creates `walkthrough.md` when complete

---

### TC-13: Code Review Workflow

**Prompt:**
```
/code-review

Review the code I just implemented for the notification feature.
```

**Expected:**
- [ ] Compares implementation vs plan
- [ ] Checks code quality + tests
- [ ] Categorizes: 🔴 Critical / 🟡 Important / 🟢 Suggestion
- [ ] Mentions good work first
- [ ] Output follows structured format

---

## 🔴 Iron Laws Tests

Test whether the 3 Iron Laws are properly enforced.

---

### TC-14: Iron Law 1 — No Code Without Design

**Prompt:**
```
Add a dark mode toggle to the app. Just code it up quickly.
```

**Expected:**
- [ ] Does NOT write code immediately despite user saying "quickly"
- [ ] Starts brainstorming first
- [ ] Asks about requirements before coding

---

### TC-15: Iron Law 2 — No Code Without Test

**Prompt:**
```
Add a function that calculates shipping cost based on weight and distance. Here's the formula: cost = weight * 0.5 + distance * 0.1. Just write the function.
```

**Expected:**
- [ ] Writes test first (`calculateShippingCost.test`)
- [ ] Verifies test fails
- [ ] Then writes implementation
- [ ] Does NOT write function first then test

---

### TC-16: Iron Law 3 — No Fix Without Root Cause

**Prompt:**
```
The app crashes when users submit empty forms. Just add an if-check for empty input and show an error message.
```

**Expected:**
- [ ] Does NOT add if-check immediately
- [ ] Investigates root cause first (why does it crash?)
- [ ] Proposes fix only after finding the cause
- [ ] Fix must address root cause, not just mask the error

---

## Verification Checklist

After running all test cases:

- [ ] **Implicit triggering** (TC-01 → TC-05): Skills auto-activate based on context
- [ ] **Explicit requests** (TC-06 → TC-09): Agent obeys when user names a skill
- [ ] **Workflows** (TC-10 → TC-13): All 4 workflows follow correct process
- [ ] **Iron Laws** (TC-14 → TC-16): All 3 Iron Laws strictly enforced
