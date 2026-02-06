---
description: Search output format for code/symbol search results
---

# Search Skill

## Search Query Format

- Query:
- Timestamp:
- Scope:
- Filters:
- Assumptions / Cannot verify:

Rules:
- Do not guess file paths, line numbers, or symbols
- If location is not known → write "cannot verify location"
- Do not include full class or function bodies
- Keep output concise and scannable

---

## Search Result Summary

- Inferred intent:
- Result type: Class | Function | File | Text
- Confidence: High | Medium | Low
- Notes: Brief explanation of why these results were selected

---

## Primary Match

- Symbol: (Class / Method / File / Text identifier)
- Location: <single clickable link> OR "cannot verify location"
- Reason: Why this is the best match
- Confidence: High | Medium | Low

---

## Related Matches (optional)

Rules:
- List only relevant alternatives
- Maximum 3–5 items
- No duplicated information

Format:
- Symbol:
- Location: <single clickable link> OR "cannot verify location"
- Reason:
- Confidence: High | Medium | Low

---

## Usage Notes

- How to refine search: (add keyword, add file extension, narrow scope)
- How to confirm in editor: (Go to Definition / Find in Files)

---

## Assumptions / Cannot Verify

- Explicitly list any missing context or unverifiable information
