---
name: webapp-testing
description: Use when testing, verifying, or debugging local web applications. Use when needing to interact with web UIs, capture screenshots, verify frontend functionality, or check browser behavior.
---

# Web Application Testing

Test and verify local web applications using the `browser_subagent` and `run_command` tools.

## Decision Tree

```
User task → Is it static HTML?
    ├─ Yes → Use browser_subagent to open file:// URL
    │         └─ Verify content, take screenshots, interact
    │
    └─ No (dynamic webapp) → Is the server already running?
        ├─ No → Start server with run_command first
        │        Then use browser_subagent to verify
        │
        └─ Yes → Use browser_subagent directly
            1. Navigate and wait for page load
            2. Take screenshot or inspect DOM
            3. Identify elements from rendered state
            4. Execute actions and verify
```

## Starting a Dev Server

Use `run_command` to start the server in the background:

```
run_command("npm run dev", Cwd="<project-dir>", WaitMsBeforeAsync=3000)
```

- Set `WaitMsBeforeAsync` high enough to catch startup errors (3000-5000ms)
- Check the command output for the local URL (usually `http://localhost:3000` or `:5173`)
- If server fails to start, check error output before proceeding

**Multiple servers (e.g., backend + frontend):**
Start each with separate `run_command` calls.

## Testing with browser_subagent

Use `browser_subagent` for all browser interactions:

```
browser_subagent(
    TaskName="Verifying Login Page",
    Task="Navigate to http://localhost:3000/login. Verify: 1) login form is visible with email and password fields, 2) submit button exists, 3) take a screenshot. Return the page title and any visible error messages.",
    TaskSummary="Testing the login page UI",
    RecordingName="login_page_test"
)
```

### Key Patterns

**Visual Verification:**
- Task the subagent to navigate and take screenshots
- Review screenshots to verify layout, styling, responsiveness

**Functional Testing:**
- Task the subagent to fill forms, click buttons, navigate links
- Verify expected state changes (redirects, modals, updated content)

**Error Detection:**
- Task the subagent to check for console errors
- Verify error states display correctly (404 pages, validation messages)

## Reconnaissance-Then-Action Pattern

For unfamiliar UIs, use a two-step approach:

1. **Recon step**: Send browser_subagent to navigate, take screenshot, and report visible elements
2. **Action step**: Based on recon results, send browser_subagent with specific interaction instructions

## Best Practices

| Practice | Details |
|----------|---------|
| Wait for load | Give dynamic apps time to hydrate before interacting |
| Screenshots | Always capture screenshots for visual verification |
| Recordings | Use descriptive `RecordingName` for debugging later |
| Specific tasks | Give browser_subagent precise, measurable objectives |
| Return conditions | Always specify when the subagent should return |
| Clean up | Terminate dev servers when testing is complete |

## Common Pitfalls

❌ **Don't** interact with elements before the page fully loads
✅ **Do** instruct browser_subagent to wait for specific elements

❌ **Don't** write vague tasks like "test the page"
✅ **Do** write specific tasks: "Click the Submit button, verify a success toast appears"

❌ **Don't** forget to start the dev server before testing
✅ **Do** start the server with `run_command` and verify it's running first
