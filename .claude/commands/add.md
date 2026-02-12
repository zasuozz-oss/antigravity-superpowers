---
name: Add
description: "Add new C# scripts, UI components, or features to Unity project. Use when user requests new functionality, UI from screenshots, or gameplay mechanics."
trigger: /add
---

# Add Workflow

## Next Steps
After completing the implementation plan or code generation:
1. Output the result using the format defined in `ai-output-formats.md`.
2. Ask user to verify the changes in Unity.
3. Wait for user input.

---

rules:
- minimal impact
- no refactor
- no rename
- follow script-folder skill
- do not invent file paths, line numbers, packages, or project settings. If not provided → cannot verify.

output:
use add format from ai-output-formats.md

## add workflow (ui from screenshot)

when input includes a ui screenshot:
1. analyze the visual layout and identify ui components
2. infer required ui states (loading, empty, error, content)
3. identify data models needed to render the screen
4. design class responsibilities:
   - screen/view
   - item view (if list-based)
   - controller/presenter
   - data provider interface (if data-driven)
5. propose folder placement and script names
6. implement ui-only logic unless backend integration is explicitly requested
7. provide usage notes and validation steps
8. If screenshot-only and no existing code shared → implement new scripts only, do not propose edits to unknown files.

restrictions:
- do not modify unrelated scripts
- do not refactor existing code
- do not introduce backend or network logic unless requested

environment:
- if Unity version / pipeline / platform not provided → assume from 00-ai-rules.md and mark cannot verify for pipeline-specific claims.
- add a short "Assumptions / Cannot verify" bullet if any dependency is unknown.

---

### 📋 Next Steps (MANDATORY OUTPUT)
After completing the add workflow, ALWAYS output this section:

```
## Next Steps
You can:
- Check the code in Unity Editor
- `/review <file>` - review the newly created file
- Request modifications if needed

Please let me know what you would like to do next.
```