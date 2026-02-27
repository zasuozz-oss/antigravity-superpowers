---
description: Export current conversation artifacts (implementation_plan.md, walkthrough.md) to self-contained HTML files with Mermaid diagram rendering. Use when user wants to share or print documentation with diagrams preserved.
---

# Export to HTML Workflow

## Purpose
Convert markdown artifacts from the current conversation to self-contained HTML files that render Mermaid diagrams, tables, and styled content. Output files are saved to `~/Desktop/` for easy access.

## Steps

1. **Identify artifacts to export**
   - Check the current conversation's artifact directory: `<appDataDir>/brain/<conversation-id>/`
   - Look for `implementation_plan.md` and/or `walkthrough.md`
   - If neither exists, inform the user and stop

2. **For each artifact found, convert to HTML**
   - Read the markdown file content
   - Convert to a self-contained HTML file with:
     - Mermaid.js CDN (`https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js`) for diagram rendering
     - GitHub-style CSS styling (tables, code blocks, headings, alerts)
     - Print-friendly `@media print` styles
   - Conversion rules:
     - `# heading` → `<h1>`, `## heading` → `<h2>`, etc.
     - `| table |` → `<table>` with styled borders
     - `` ```mermaid `` blocks → `<div class="mermaid">` (Mermaid.js auto-renders these)
     - `> [!NOTE]`, `> [!IMPORTANT]`, `> [!WARNING]`, `> [!CAUTION]` → styled alert boxes
     - `` `inline code` `` → `<code>` tags
     - `**bold**` → `<strong>`, `*italic*` → `<em>`
     - `- list items` → `<ul><li>`
     - Code blocks with language tags → `<pre><code>` with syntax class
     - `[text](file:///path)` → convert to plain text (file links not useful in HTML)
     - `---` horizontal rules → `<hr>`

3. **HTML template structure**
   Use this base template:
   ```html
   <!DOCTYPE html>
   <html lang="vi">
   <head>
   <meta charset="UTF-8">
   <title>{DOCUMENT_TITLE}</title>
   <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
   <script>mermaid.initialize({ startOnLoad: true, theme: 'default' });</script>
   <style>
     body {
       font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
       max-width: 900px; margin: 40px auto; padding: 0 20px;
       color: #333; line-height: 1.6;
     }
     h1 { color: #1a1a2e; border-bottom: 2px solid #e94560; padding-bottom: 10px; }
     h2 { color: #16213e; margin-top: 40px; }
     h3 { color: #0f3460; }
     table { border-collapse: collapse; width: 100%; margin: 16px 0; }
     th, td { border: 1px solid #ddd; padding: 8px 12px; text-align: left; }
     th { background: #f5f5f5; font-weight: 600; }
     tr:nth-child(even) { background: #fafafa; }
     code { background: #f0f0f0; padding: 2px 6px; border-radius: 3px; font-size: 0.9em; }
     pre { background: #f6f8fa; padding: 16px; border-radius: 6px; overflow-x: auto; }
     pre code { background: none; padding: 0; }
     .mermaid { margin: 20px 0; text-align: center; }
     .alert { padding: 12px 16px; margin: 16px 0; border-radius: 4px; border-left: 4px solid; }
     .alert-note { background: #e8f4fd; border-left-color: #0969da; }
     .alert-important { background: #fff3e0; border-left-color: #e65100; }
     .alert-warning { background: #fff8e1; border-left-color: #f9a825; }
     .alert-caution { background: #fce4ec; border-left-color: #c62828; }
     .alert-tip { background: #e8f5e9; border-left-color: #2e7d32; }
     ul { padding-left: 24px; }
     li { margin: 4px 0; }
     hr { border: none; border-top: 1px solid #eee; margin: 30px 0; }
     @media print {
       body { margin: 0; max-width: 100%; }
       .mermaid svg { max-width: 100% !important; }
     }
   </style>
   </head>
   <body>
   {CONVERTED_CONTENT}
   </body>
   </html>
   ```

// turbo
4. **Save output files**
   - Derive a meaningful filename from the document's `# H1` title:
     - Convert to lowercase, replace spaces with underscores, remove special characters
     - Example: `# Luồng chạy Generate Video: FCM + VideoStatusPoller` → `generate_video_fcm_videostatus_poller.html`
     - Example: `# Authentication Refactoring Plan` → `authentication_refactoring_plan.html`
   - If no H1 title found, fall back to source filename (`walkthrough.html`, `implementation_plan.html`)
   - Save to `~/Desktop/`
   - Open the file(s) in the default browser: `open ~/Desktop/{filename}.html`

5. **Inform user**
   - Tell the user the file(s) are saved to Desktop
   - Remind them: **Cmd + P → Save as PDF** to get PDF with diagrams
