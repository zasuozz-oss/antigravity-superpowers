---
name: Web Search
description: "Search web, forums, docs for Unity features, bugs, solutions, and best practices. Generates a structured research report. Use when user asks to research a topic, find bug fixes, or explore feature usage."
trigger: /web-search
---

# Web Search & Research Workflow

## Purpose
Search the web, forums (Unity Forum, Stack Overflow, GitHub Issues), and documentation
to research a Unity feature, investigate a bug, find usage patterns or fix solutions,
then compile findings into a structured report.

## Next Steps
After completing the research:
1. Present the report using the defined format.
2. Offer to apply fixes, create implementation plans, or continue research.
3. Wait for user input.

---

rules:
- do NOT modify any code during research
- do NOT apply fixes unless explicitly requested
- always cite sources with URLs
- if information cannot be confirmed → state "cannot verify"
- prioritize official Unity docs and recent forum posts (< 2 years old)
- mark Unity version–specific findings clearly
- language: all content in English

---

## Workflow Steps

### 1. Parse User Query
- extract the main topic (feature name, bug description, error message)
- identify query type:
  - `feature`: how to use a Unity feature or API
  - `bug`: investigate a known bug or unexpected behavior
  - `solution`: find fix / workaround for a specific problem
  - `general`: broad research topic
- extract constraints:
  - Unity version (default: 6000.60f1 from project rules)
  - platform (default: Android + iOS)
  - rendering pipeline (Built-in / URP)

### 2. Search Strategy
Execute searches in parallel across multiple sources:

#### 2a. Official Documentation
- search_web: `site:docs.unity3d.com <query>`
- search_web: `site:docs.unity.com <query>`

#### 2b. Unity Forums & Discussions
- search_web: `site:forum.unity.com <query>`
- search_web: `site:discussions.unity.com <query>`

#### 2c. Community & Stack Overflow
- search_web: `site:stackoverflow.com unity <query>`
- search_web: `site:github.com unity <query> issue OR bug`

#### 2d. General Web
- search_web: `unity <query> solution OR fix OR workaround`
- search_web: `unity <query> best practice OR tutorial`

### 3. Collect & Filter Results
For each search result:
- read_url_content for the top 2–3 most relevant results per source
- extract:
  - title and URL (citation)
  - date posted / last updated
  - Unity version mentioned
  - key findings / code snippets
  - upvotes / accepted answer status (if available)
- filter out:
  - results older than 3 years (unless still relevant)
  - results for different Unity versions (unless applicable)
  - duplicate information

### 4. Analyze & Synthesize
- group findings by category:
  - **Root cause** (for bugs)
  - **Official solution** (from Unity docs)
  - **Community solutions** (forums, SO)
  - **Workarounds** (temporary fixes)
  - **Best practices** (recommended approaches)
- rank solutions by:
  - reliability (official > accepted answer > upvoted > unverified)
  - recency (newer > older)
  - relevance to project constraints (mobile, Unity version)
- identify conflicts between sources
- note any unresolved issues or open bugs

### 5. Generate Report
Create a markdown report saved to the artifacts directory with this structure:

```markdown
# Web Research Report: <Topic>

**Date**: <timestamp>
**Unity Version**: <version>
**Platform**: <platform>
**Query Type**: feature | bug | solution | general

---

## Summary
<2-3 sentence overview of findings>

## Problem / Feature Description
<Clear description of what was researched>

## Findings

### Official Documentation
- <finding with [source](url)>

### Forum & Community Results
| # | Source | Title | Date | Relevance |
|---|--------|-------|------|-----------|
| 1 | Unity Forum | title | date | High/Med/Low |

### Solutions Found
| # | Solution | Source | Verified | Risk |
|---|----------|--------|----------|------|
| 1 | description | [link](url) | Yes/No | Low/Med/High |

### Code Snippets
<relevant code from findings>

## Recommended Approach
<Best solution ranked by reliability and project fit>

## Risks & Assumptions
- <risk 1>
- <assumption 1>

## Sources
1. [title](url) - brief note
2. [title](url) - brief note

## Cannot Verify
- <items that could not be confirmed>
```

### 6. Present Report
- display the report summary inline
- save full report as artifact if requested
- highlight the recommended approach

---

## Variations

### Bug Investigation Mode
When query type is `bug`:
1. search for the exact error message first
2. check Unity Issue Tracker: `search_web: site:issuetracker.unity3d.com <error>`
3. look for known regression or version-specific bugs
4. prioritize workarounds with minimal code changes

### Feature Research Mode
When query type is `feature`:
1. start with official docs
2. search for tutorials and usage examples
3. look for performance considerations on mobile
4. check for deprecated APIs or version changes

### Solution Hunting Mode
When query type is `solution`:
1. search for the specific problem description
2. collect multiple alternative solutions
3. compare trade-offs (performance, complexity, maintenance)
4. recommend the solution best suited for mobile

---

## Restrictions
- do NOT modify project code during research
- do NOT create scripts or assets
- do NOT assume findings are correct without cross-referencing
- always maintain source attribution

environment:
- Unity version from 00-ai-rules.md (6000.60f1)
- mobile-first constraints apply to all recommendations
- mark pipeline-specific findings clearly

---

### 📋 Next Steps (MANDATORY OUTPUT)
After completing the research, ALWAYS output this section:

```
## Next Steps
You can:
- `/web-search <another query>` - search for more information
- `/debug` - analyze bugs based on results
- `/fix` - apply fixes from found solutions
- `/add` - add features based on research
- Request to save the full report

Please let me know what you'd like to do next.
```
