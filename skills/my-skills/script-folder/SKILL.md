---
description: Unity script creation and folder structure rules
---

# Unity Script & Folder Rules

## 1. General Principles
- Scripts MUST NOT be created unless explicitly required
- Do NOT create scripts "just in case" (YAGNI)
- Prefer modifying existing scripts over creating new ones
- Consistency across codebase > personal preference

---

## 2. Script Creation Rules

### Purpose & Scope
- Every script MUST have single, clear responsibility (SRP)
- Newly created scripts MUST be used immediately
- Unused scripts are NOT allowed

### Clean Code
- Keep responsibilities small and cohesive
- Prefer clear naming over clever naming
- Avoid tight coupling to specific scenes
- Code MUST be readable without excessive comments

### Maintainability
- Separate concerns: UI vs data/business logic
- Gameplay rules vs presentation
- Platform-specific vs shared logic

### Abstractions
- Introduce interfaces ONLY when needed
- Prefer composition over inheritance
- Do NOT introduce new frameworks unless requested

---

## 3. Mobile Performance Baseline
- No per-frame allocations in Update/LateUpdate/FixedUpdate
- Avoid LINQ and reflection in hot paths
- Cache component lookups
- No hidden allocations in frequently called code

---

## 4. Validation
- Each new script MUST include verification checklist

---

## 5. Script Size
- Preferred: under 300 lines
- Warning: over 500 lines
- If exceeding, AI MUST ask before splitting

---

## 6. File & Class Rules
- One script = one responsibility
- One file = one class
- Class name MUST match file name
- One MonoBehaviour per file
- Avoid god classes

---

## 7. Folder Structure

### Script Placement
- Scripts MUST be placed under `Scripts` folder
- Search for existing `Scripts` folder first
- Scripts MUST NOT be placed outside `Assets/`
- Scripts MUST NOT be at root of `Assets/`

### Recommended Top-level Folders
- Core (bootstrap, lifecycle)
- Gameplay (player, enemy, combat)
- UI (UI logic only)
- Systems (save, audio, localization)
- Data (ScriptableObjects, configs)
- Utils (pure stateless utilities)

---

## 8. Dependency Rules
- UI MUST NOT depend on Gameplay internals
- Systems MUST NOT depend on UI
- Circular dependencies forbidden
