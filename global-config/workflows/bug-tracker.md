---
description: Create a Bug Tracker template file for tracking bugs in the project. Use when you need a structured issue list.
---

# Bug Tracker Workflow

Create a Bug Tracker file in Artifacts for the user to list bugs and change requests.

## When to Use

- Starting a debug session with multiple issues to track
- When the user wants to list bugs and have them resolved one by one
- When bugs need to be organized and prioritized by severity

## Steps

1. **Create the Bug Tracker file**
   - Create `bug_tracker.md` in the current conversation's Artifacts directory
   - Mark as Artifact (`IsArtifact: true`, `ArtifactType: "other"`)

2. **Populate with template**
   - Use the template below as initial content:

   ```markdown
   # Bug Tracker

   List all bugs or changes you need below.
   The Agent will use this file as a checklist to process them one by one:

   ## 🔴 Critical Bugs (Fix ASAP)
   - [ ]
   - [ ]

   ## 🟡 UI/UX Issues
   - [ ]
   - [ ]

   ## 🟢 Feature Requests
   - [ ]
   - [ ]

   ---
   *Tip: Use `[ ]` to mark items. When the Agent finishes a fix, it will automatically mark `[x]`.*
   ```

3. **Notify the user**
   - Confirm the file was created successfully in Artifacts
   - Guide the user to open the file and fill in their bug list

## Next Step

After the user fills in the list, read the file and process each item by priority: 🔴 → 🟡 → 🟢.
