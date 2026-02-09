---
name: Refactor
description: Refactor code (formatting, naming, structure)
trigger: /refactor
---

## refactor request

goal:
- Clean, readable, consistent, professional scripts
- No behavior change (default)

input:
- scripts:
  (one or more .cs files or code snippets)
- scope:
  (single script / folder / feature)
- constraints:
  - scripts only
  - no prefab/scene changes
  - no asset changes (animations/materials/textures)
  - keep public API stable
  - keep serialized/public field names stable
- output:
  (patch only / diff-style / before-after)

rules:
- Scripts only: modify `.cs` files ONLY
- DO NOT change logic, data flow, timing, or state unless explicitly requested
- DO NOT rename:
  - public classes
  - public methods
  - serialized fields (`[SerializeField]` or public inspector fields)
- DO NOT move responsibilities across lifecycle methods by default
- Avoid Awake unless strictly required; Awake is for caching references only
- DO NOT introduce new packages or frameworks
- If any change might alter behavior → do not apply; mark as **"cannot verify"** and propose as optional

---

## Compliance: ai-script-and-folder-rules.md (MANDATORY)

All refactor operations MUST strictly comply with the active  
`ai-script-and-folder-rules.md`.

This refactor workflow does NOT override script & folder rules.  
It operates fully under them.

### Scope enforcement
- Refactor is LIMITED to existing `.cs` files only.
- The refactor process MUST NOT:
  - create new scripts
  - delete scripts
  - move scripts between folders
  - rename files or folders
- If a refactor would require creating any NEW `.cs` file
  (including splitting a class into multiple files):
  - DO NOT apply automatically
  - Propose as an optional change requiring explicit approval

### Responsibility & architecture
- Refactor MUST NOT introduce new responsibilities to a script.
- Script role (UI / Gameplay / System / Utility) MUST remain unchanged.
- Do NOT merge or split responsibilities across scripts.
- Do NOT introduce new architectural patterns, layers, or abstractions.

### Folder & dependency rules
- Folder placement MUST remain unchanged.
- Dependency direction MUST be preserved:
  - UI must not depend on Gameplay internals
  - Systems must not depend on UI
- Circular dependencies MUST NOT be introduced.

### Naming & style authority
- All naming during refactor MUST comply with:
  - `ai-script-and-folder-rules.md`
  - Active Unity C# Naming / Formatting Rules (Unity 6)
- ONLY local variables and parameters may be renamed.
- Public APIs, serialized fields, and inspector-facing identifiers
  are STRICTLY immutable.

### Safety precedence
- If a requested refactor conflicts with:
  - behavior safety rules
  - folder rules
  - naming rules
then:
  - default to formatting-only changes
  - explicitly report the conflict
  - list optional changes separately (not applied)

### Rule precedence
Order of authority:
1. ai-script-and-folder-rules.md
2. ai-unity-mobile-rules.md (runtime bans & mobile performance)
3. Unity C# Naming / Formatting Rules (Unity 6), if present
4. refactor.md (this file)
5. Request-specific instructions

If a conflict exists, the higher-priority rule MUST win.

---

====================== REFACTOR WORKFLOW (SCRIPTS ONLY) ======================

## Step 1 – Identify script context
- Script role: UI / Gameplay / System / Utility
- Hot paths: Update / LateUpdate / FixedUpdate / tight loops
- Dependencies: serialized references, events, coroutines, async logic

---

## Step 2 – Safe refactor targets (cleanliness only)

Priority order:

### 1) Formatting & layout
- consistent braces (Allman style), spacing, line breaks
- consistent `using` order

### 2) Naming (local only)
- rename local variables and parameters for clarity
- DO NOT rename public, protected, serialized, or inspector-facing identifiers

### 3) Readability
- reduce nesting via early returns (logic-equivalent only)
- extract private helper methods (pure refactor, no logic change)
- remove dead code ONLY if provably unreachable

### 4) Duplication
- deduplicate identical blocks (exact equivalence only)
- local `const` / `readonly` for repeated literals (local scope only)

EXCEPT:
- DO NOT extract DOTween timing-related literals
  (duration, delay, loops, easing, sequence structure, time scale)
  into constants or readonly fields.

---

## Step 3 – Guardrails for behavior neutrality

Do NOT change by default:
- coroutine or async structure or timing
- lifecycle ordering (Awake / Start / OnEnable / OnDisable)
- event subscription or invocation logic
- allocation patterns in hot paths
- exception handling semantics (try / catch / finally)

If uncertain → keep as-is and mark **"cannot verify"**.

---

## Step 4 – Output (refactor report)

Provide:
- Changes summary (cleanliness-only)
- Proposed patch (minimal diffs)
- Risks & assumptions
- Validation steps MUST include:
  - compile check
  - play mode smoke test
  - inspector references unchanged
  - hot path sanity (no new allocations)

---

## Step 5 – When request conflicts with rules
- Default to formatting-only pass
- List optional refactors requiring explicit permission:
  - renaming public APIs
  - moving lifecycle logic
  - restructuring coroutines or async flows
  - changing serialized fields

---

## DOTween Refactor Restrictions (STRICT)

- DOTween timing behavior MUST NOT be refactored.
- Do NOT modify:
  - duration values
  - delays
  - ease types
  - sequence order
  - Join / Append / Insert structure
  - SetUpdate (scaled / unscaled)
  - SetLoops configuration
  - timeScale-related behavior

NOT allowed by default:
- rewriting DOTween calls if timing semantics may change
- merging or splitting tweens or sequences
- replacing tweens with coroutines or other tween systems
- normalizing magic numbers into constants

Allowed (SAFE ONLY):
- formatting and line breaks
- local variable naming for tween references
- extracting tween setup into a private method
  ONLY if call order and parameters are IDENTICAL

If DOTween behavior equivalence cannot be proven:
- DO NOT refactor
- Mark as **"DOTween behavior cannot be safely verified"**
