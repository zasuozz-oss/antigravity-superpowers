---
description: Walkthrough workflow - explain existing features/systems (read-only)
---

# Walkthrough Skill

## Purpose
- Explain how an existing feature or system works
- Guide developers or reviewers through code, flow, or setup
- Support onboarding, debugging, or review discussions

Walkthrough is NOT used to:
- Propose refactors
- Apply fixes
- Introduce new features
- Optimize code

---

## Scope Rules
- MUST stay strictly within provided scope
- Do NOT assume project-wide context
- If information is missing: state "cannot verify"

---

## Required Structure

1. Overview  
2. Feature tree layout  
3. Entry points  
4. Flow breakdown  
5. Key responsibilities  
6. Dependencies & interactions  
7. Configuration & Inspector setup (if applicable)  
8. Common pitfalls / failure points  
9. How to verify behavior  

---

## Add Walkthrough (tree layout required)

When /add targets any feature:
- MUST include "Feature tree layout" section
- Tree describes what will be created in hierarchical form
- Tree appears before implementation details

For UI features:
- Tree is UI hierarchy suitable for prefab
- Follow UI performance rules

For non-UI features:
- Tree describes folders + scripts + assets
- No abstraction "just in case"

---

## UI Tree Layout (performance-optimized)

Template:
```
- `<UIRoot>` (RectTransform, CanvasGroup)
  - `SafeArea` (RectTransform)
    - `Header` (RectTransform)
      - `Title` (TextMeshProUGUI)
      - `Btn_Close` (Button + Image)
    - `Content` (RectTransform)
      - `Body` (RectTransform)
        - `...` (only required elements)
      - `Footer` (RectTransform)
        - `Btn_Primary` (Button + Image)
          - `Label` (TextMeshProUGUI)
```

---

## UI Performance Rules (tree-level)

- Keep hierarchy shallow
- Avoid stacking LayoutGroups in deep chains
- Prefer single LayoutGroup per section
- Disable Raycast Target on non-interactive elements
- Use single CanvasGroup at UIRoot
- All UI text MUST use TextMeshProUGUI
- UI animations MUST use DOTween

---

## Detail Level Rules
- Explain intent before implementation
- Focus on *why* things exist
- Prefer conceptual flow over raw code listing
- Do NOT paste full files unless requested

---

## Unity-Specific Rules

Scene & Prefab:
- Treat as read-only
- Explain hierarchy and ownership clearly

Serialized Fields:
- Assume configured via Inspector
- Do NOT treat missing assignments as defects

Lifecycle:
- Explain Awake/OnEnable/Start/Update/OnDisable/OnDestroy usage
- Explain *why* a lifecycle hook is used

---

## Dependency Rules
- Distinguish: required vs optional vs runtime-injected
- Explain source: Inspector vs bootstrap vs runtime
- Do NOT suggest null-checks for required Inspector dependencies

---

## Forbidden in Walkthrough
- No fixes
- No refactors
- No optimization patches
- No speculative suggestions
- No architecture redesign proposals

---

## Language
- Explanations in Vietnamese
- Section titles in English
