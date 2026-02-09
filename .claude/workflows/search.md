---
description: Tìm kiếm code/symbols trong project
---

# Search Workflow

> **Required Skill**: Read `skills/my-skills/search/SKILL.md` for search strategy and ranking rules.

## Purpose
Find code, symbols, or text within the project based on a query or context.

## Next Steps
After completing the search:
1. Present the search results using the defined format.
2. If results are found, offer to open relevant files or perform deep analysis.
3. Wait for user input.

---

rules:
- no refactor
- no rename
- minimal impact
- follow script-and-folder-rules
- do not invent file paths, line numbers, packages, or project settings.  
  If not provided → cannot verify.

output:
use search format from ai-output-formats.md


## search workflow

when input includes a query (text entered by user):

1. normalize query
   - trim whitespace
   - keep original casing for display
   - tokenize camelCase / snake_case / kebab-case
   - split words and symbols
   - preserve original query string

2. infer intent (do not ask user to pick a type)
   - function-like: contains () or verb-style camelCase
   - class-like: PascalCase
   - file-like: has extension (.cs / .js / .py / ...)
   - text-like: phrases, TODO, comments
   - intent is used only to weight ranking, never to exclude results

3. search all indexes in parallel (then rank)
   - functions / methods
   - classes / structs
   - files / paths
   - comments / strings / plain text

4. rank results (antigravity)
   - exact match > prefix match > contains > fuzzy / semantic
   - boost by intent confidence
   - boost by recency and usage frequency (if known)
   - ensure at least one fallback group when confidence is low

5. choose response mode
   - best match (default): top 1 + 3–10 related results
   - multi-match: grouped list by type or file
   - export mode: generate a .md report

6. export .md report (when requested or when asked to “create search file”)
   include:
   - original query
   - timestamp
   - assumptions / cannot verify
   - results list

   for each result:
   - file path (only if known)
   - symbol (class / method / function) if known
   - location info (line range) only if known
   - reason and confidence
   - small, relevant code snippet

   special case:
   - if best match is a class-name match
     include full class only if provided or safely retrievable

7. usage notes & validation
   - how to refine the query (add token, add file extension, add folder)
   - how to confirm in editor (Go to Definition / Find in Files)

8. screenshot-only or partial context
   - do not claim exact file paths or line numbers
   - return conceptual matches
   - list what information is needed to locate it in the project


## search workflow (ui from screenshot)

when input includes a UI screenshot:

1. identify the UI surface
   - search bar
   - results list
   - filters
   - empty / loading / error states

2. infer required UI states
   - loading
   - empty
   - error
   - content
   - no-permission (if applicable)

3. identify data model (SearchResultItem)
   - id
   - title
   - subtitle
   - type
   - path
   - snippet
   - score
   - tags

4. define class responsibilities
   - SearchScreen / View (input + state rendering)
   - SearchResultItemView (list row)
   - SearchController / Presenter (query → results → state)
   - ISearchProvider interface (data source abstraction)

5. propose folder placement and script names

6. implement UI-only logic
   - do not integrate backend unless explicitly requested

7. provide usage notes and validation steps

8. screenshot-only with no existing code
   - create new scripts only
   - do not modify unknown or unrelated files


## restrictions

- do not refactor existing code
- do not rename symbols
- do not modify unrelated scripts
- do not introduce backend, indexing, or network logic unless requested

environment:
- if Unity version / pipeline / platform is not provided
  → assume from 00-ai-rules.md
  → mark pipeline-specific behavior as "cannot verify"

add a short **Assumptions / Cannot verify** section when dependencies are unknown.

---

### 📋 Next Steps (MANDATORY OUTPUT)
After completing the search, ALWAYS output this section:

```
## Next Steps
Bạn có thể:
- Mở file để xem chi tiết
- `/walkthrough <file>` - giải thích code
- `/review <file>` - review file
- Tìm kiếm thêm với query khác

Vui lòng cho biết bạn muốn thực hiện gì tiếp theo.
```