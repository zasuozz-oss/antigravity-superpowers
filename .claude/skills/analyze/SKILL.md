---
name: Analyze
description: Phân tích requirements từ image/text
trigger: /analyze
---

## analyze

intent:
- analyze requirements from an image (screenshot, mockup, diagram)
  or from a textual description provided by the user.
- transform visual or descriptive input into a structured
  implementation plan.
- do NOT implement code or create assets during analysis.
- recommend the appropriate /add workflow(s) based on the analysis.

non-goals:
- do NOT modify code, scenes, prefabs, or project settings.
- do NOT generate fix_id or opt_id.
- do NOT propose refactors or optimizations.
- do NOT assume project-wide state.

rules:
- analysis ONLY; no code changes.
- respect all existing rules (scope, mobile, folder, technology defaults).
- ask questions only if critical information is missing (max 3 short questions).
- if information cannot be confirmed, explicitly state "cannot verify".
- do not invent features beyond what can be inferred
  from the image or description.

analysis steps:
1) restate the user goal in 1–2 concise lines.
2) analyze input source:
   - image: identify visible UI elements, layout, hierarchy, states.
   - description: extract functional and visual requirements.
3) extract requirements:
   - user-visible behavior
   - UI states and transitions
   - interactions and triggers
   - required data and outputs
4) identify dependencies:
   - UI components (buttons, text, panels)
   - systems (settings, save, audio, etc.)
   - third-party tools implied by rules (e.g. DOTween, TextMeshProUGUI)
5) identify constraints:
   - mobile considerations
   - existing project rules and defaults
   - inspector vs runtime responsibilities
6) identify risks and unknowns:
   - missing context
   - assumptions
   - serialization or prefab risks
7) propose implementation breakdown:
   - feature name(s) suitable for /add
   - scope of each feature
   - suggested folder placement (must follow folder rules)
8) recommend next action:
   - list recommended /add commands
   - explain what each /add would create (high-level, no code)
   - provide a brief post-add verification checklist

output format:
- Goal summary:
- Input analysis:
- Extracted requirements:
- UI flow / states (if applicable):
- Data & interactions:
- Dependencies:
- Constraints & assumptions:
- Risks / cannot verify:
- Proposed feature breakdown:
- Suggested /add commands:
- Next steps:
