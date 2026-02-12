---
name: Walkthrough
description: "Explain existing feature or system in detail (read-only). Use when user asks 'how does X work', 'explain this system', or wants to understand code flow."
trigger: /walkthrough
---

# Walkthrough Workflow

## Purpose
Explain an existing feature or system in detail (read-only).

## Next Steps
After completing the walkthrough:
1. Present the walkthrough content following the structure.
2. Ask if the user needs clarification on any specific section.
3. Wait for user input.

---

rules:
- READ-ONLY: do not modify any code
- do not propose fixes or refactors
- do not generate fix_id or opt_id
- do not assume project-wide state
- if information is missing → state "cannot verify"
- explanations in Vietnamese (per 00-ai-rules.md)
- section titles in English

======================WALKTHROUGH WORKFLOW======================

## walkthrough structure (required)

Every walkthrough MUST include:

1. Overview
   - what the feature/system does
   - why it exists
   - key responsibilities

2. Entry Points
   - how the feature is triggered
   - user actions or system events that start it

3. Flow Breakdown
   - step-by-step execution flow
   - decision points and branches
   - async/coroutine flows (if any)

4. Key Components
   - main classes and their roles
   - relationships between components
   - data models involved

5. Dependencies & Interactions
   - required systems (managers, services)
   - external APIs (backend, SDK)
   - events listened to or raised

6. Configuration & Inspector Setup
   - serialized fields and their purpose
   - prefab/scene requirements
   - ScriptableObject configs (if any)

7. Common Pitfalls / Failure Points
   - known edge cases
   - race conditions
   - lifecycle issues

8. How to Verify Behavior
   - how to test in Editor
   - expected logs or outputs
   - success criteria

======================WALKTHROUGH UI FEATURE======================

## walkthrough (UI feature)

additional sections:
- UI Tree Layout (if prefab exists)
- State Flow (loading/content/empty/error)
- Animation/Transition behavior
- Button bindings (method names)

======================WALKTHROUGH SYSTEM======================

## walkthrough (system/manager)

additional sections:
- Singleton/lifecycle pattern
- Initialization order
- Public API summary
- Event catalog (events raised/listened)

======================OUTPUT RULES======================

## output rules

- do NOT paste full files unless explicitly requested
- reference code with single clickable link only
- prefer conceptual explanation over line-by-line code listing
- explain WHY, not just WHAT
- use code snippets sparingly (only for key logic)

## restrictions

- no fixes
- no refactors
- no optimization patches
- no speculative suggestions
- no architecture redesign proposals

---

### 📋 Next Steps (MANDATORY OUTPUT)
After completing the walkthrough, ALWAYS output this section:

```
## Next Steps
Bạn có thể:
- Hỏi thêm về một phần cụ thể
- `/review <file>` - review code liên quan
- `/debug` nếu phát hiện vấn đề

Vui lòng cho biết bạn muốn thực hiện gì tiếp theo.
```
