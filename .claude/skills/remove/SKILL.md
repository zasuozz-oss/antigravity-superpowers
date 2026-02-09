---
name: Remove
description: Xoá feature/script/variable an toàn
trigger: /remove
---

## remove request

goal:
- Remove a feature / function / script / variable safely
- Prevent leftover references, compile errors, or orphaned UI/state
- Minimal impact outside the requested scope

input:
- remove target:
  (feature | function | script | variable | other)
- identifiers:
  (names, keywords, expected entry points)
- scope (optional):
  (folder(s), assembly, module, scene, prefab)
- constraints (optional):
  (scripts only, do not touch prefabs/scenes, etc.)
- acceptance criteria:
  (what should stop happening; what should still work)

rules:
- Do NOT guess file paths, line numbers, symbols, or project structure
- Do NOT remove anything outside the specified scope
- No refactor beyond what is required to remove the target
- If location cannot be verified → state "cannot verify" and request the missing reference
- Avoid behavior changes unrelated to the removal
- If Unity serialized/public fields are involved:
  - do NOT rename/move serialized identifiers unless explicitly requested
  - removing serialized fields may break prefab/scene bindings → must be called out as risk

output:
- Removal plan (scoped)
- Impact list (what will be affected)
- Proposed patches (minimal)
- Validation steps
- Risks & assumptions


======================WORKFLOW: REMOVE======================

## Step 1 – Confirm removal intent & boundary
- Identify target type:
  - feature: behavior flow or UI capability
  - function: method or API
  - script: entire .cs file or component
  - variable: field/local/const
- Define boundary:
  - what must be removed
  - what must remain unchanged
- If ambiguous → request minimum missing info (max 1 critical question)

## Step 2 – Locate all references (required)
- Find direct definitions:
  - class / method / field / file
- Find usages:
  - call sites
  - event subscriptions
  - Unity messages (Start/Update/etc.)
  - serialized references (prefab/scene)
  - string-based references (Animator params, resource paths, reflection)
- If only partial code is available → list what cannot be verified

## Step 3 – Build a dependency map (small + practical)
- Entry points:
  - who calls it / triggers it
- Exit points:
  - what it calls / affects (UI, state, network, save data)
- Runtime coupling:
  - events, coroutines, async tasks, singletons

## Step 4 – Choose removal strategy
- Feature removal:
  - remove entry points (UI button, menu route, event hook)
  - remove core implementation
  - remove leftover UI/state transitions
- Function removal:
  - remove method
  - replace call sites with:
    - nothing (delete call) OR
    - supported alternative (only if specified)
- Script removal:
  - detach from prefabs/scenes (if in scope)
  - delete file
  - remove references/usings
- Variable removal:
  - remove variable
  - remove dependent code
  - if serialized field: warn about prefab bindings

Rules:
- Prefer removing call sites first (stop behavior), then removing implementation
- Do NOT leave dead code paths or unused public APIs if removal is requested

## Step 5 – Apply minimal patches
Allowed changes:
- Delete code and references required for removal
- Remove unused using directives created by removal
- Remove unused files (script) ONLY if no longer referenced
- Replace removed symbols with stubs ONLY if required to keep compilation and explicitly acceptable

Not allowed by default:
- Broad refactors
- Renaming unrelated APIs
- Reformatting whole files (only local minimal formatting around edits)

## Step 6 – Cleanup & consistency checks
- Ensure no orphaned UI state:
  - if a feature had loading indicators, locks, overlays → ensure they can’t get stuck
- Ensure no dangling subscriptions:
  - OnEnable/OnDisable hooks removed or updated
- Ensure no leftover assets:
  - prefabs, addressables entries, resource files (only if in scope)
- Ensure no duplicate/unused defines or config flags

## Step 7 – Validation checklist (must include)
- Compile check (no missing symbols)
- Run the app and verify:
  - removed behavior no longer appears
  - key flows still work
- Search for leftovers:
  - keyword search for removed identifiers
  - references in serialized data (if applicable)
- If Unity:
  - check Console for Missing Script warnings
  - open affected prefabs/scenes (if in scope) and confirm no broken bindings

## Step 8 – Output summary
- What was removed (exact)
- What was updated (exact)
- What was NOT touched (to confirm boundary)
- Risks & assumptions:
  - anything not verifiable due to missing project context


======================SPECIAL RULES: UNITY SERIALIZATION======================

## Serialized field & prefab safety

- If removing a serialized/public field or component:
  - Prefabs/scenes may keep a reference and cause warnings/errors
- If prefabs/scenes are out of scope:
  - do not attempt to auto-fix them
  - report as risk and provide manual steps (how to remove bindings)

Rules:
- Do NOT add null checks to mask missing serialized assignments caused by removal
- Prefer explicit removal and clear warnings over hidden fail-safes
