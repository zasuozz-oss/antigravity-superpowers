---
name: docx
description: Use when creating, editing, analyzing, or converting Word (.docx) documents. Use when user needs to generate reports, edit existing Word files, or extract content from .docx format.
---

# DOCX Creation, Editing, and Analysis

A .docx file is a ZIP archive containing XML files.

## Quick Reference

| Task | Approach |
|------|----------|
| Read/analyze content | `pandoc` or unpack for raw XML |
| Create new document | Use `docx` npm package (docx-js) |
| Edit existing document | Unpack → edit XML → repack |

---

## Creating New Documents

Generate .docx files with JavaScript. Install: `npm install -g docx`

### Setup
```javascript
const { Document, Packer, Paragraph, TextRun, Table, TableRow, TableCell, ImageRun,
        Header, Footer, AlignmentType, PageOrientation, LevelFormat, ExternalHyperlink,
        HeadingLevel, BorderStyle, WidthType, ShadingType, PageBreak } = require('docx');
const fs = require('fs');

const doc = new Document({ sections: [{ children: [/* content */] }] });
Packer.toBuffer(doc).then(buffer => fs.writeFileSync("doc.docx", buffer));
```

### Page Size
```javascript
// docx-js defaults to A4 — always set explicitly
sections: [{
  properties: {
    page: {
      size: {
        width: 12240,   // 8.5 inches in DXA (1440 DXA = 1 inch)
        height: 15840   // 11 inches in DXA
      },
      margin: { top: 1440, right: 1440, bottom: 1440, left: 1440 } // 1 inch
    }
  },
  children: [/* content */]
}]
```

| Paper | Width (DXA) | Height (DXA) |
|-------|-------------|--------------|
| US Letter | 12,240 | 15,840 |
| A4 (default) | 11,906 | 16,838 |

### Styles
Use Arial as default font. Override built-in heading styles:
```javascript
const doc = new Document({
  styles: {
    default: { document: { run: { font: "Arial", size: 24 } } }, // 12pt
    paragraphStyles: [
      { id: "Heading1", name: "Heading 1", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 32, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 240, after: 240 }, outlineLevel: 0 } },
      { id: "Heading2", name: "Heading 2", basedOn: "Normal", next: "Normal", quickFormat: true,
        run: { size: 28, bold: true, font: "Arial" },
        paragraph: { spacing: { before: 180, after: 180 }, outlineLevel: 1 } },
    ]
  },
  sections: [{ children: [
    new Paragraph({ heading: HeadingLevel.HEADING_1, children: [new TextRun("Title")] }),
  ]}]
});
```

### Lists (NEVER use unicode bullets)
```javascript
// ❌ WRONG
new Paragraph({ children: [new TextRun("• Item")] })

// ✅ CORRECT — use numbering config
const doc = new Document({
  numbering: {
    config: [
      { reference: "bullets",
        levels: [{ level: 0, format: LevelFormat.BULLET, text: "•",
          alignment: AlignmentType.LEFT,
          style: { paragraph: { indent: { left: 720, hanging: 360 } } } }] },
      { reference: "numbers",
        levels: [{ level: 0, format: LevelFormat.DECIMAL, text: "%1.",
          alignment: AlignmentType.LEFT,
          style: { paragraph: { indent: { left: 720, hanging: 360 } } } }] },
    ]
  },
  sections: [{ children: [
    new Paragraph({ numbering: { reference: "bullets", level: 0 },
      children: [new TextRun("Bullet item")] }),
  ]}]
});
```

---

## Editing Existing Documents

### Step 1: Unpack
```bash
# Extract and pretty-print the XML
python -c "import zipfile, os; z=zipfile.ZipFile('doc.docx'); z.extractall('unpacked/')"
```

### Step 2: Edit XML
Edit files in `unpacked/word/document.xml` using `replace_file_content`.

**Smart quotes** — use XML entities for professional typography:

| Entity | Character |
|--------|-----------|
| `&#x2018;` | ' (left single) |
| `&#x2019;` | ' (right single / apostrophe) |
| `&#x201C;` | " (left double) |
| `&#x201D;` | " (right double) |

### Step 3: Repack
```bash
# Repack into .docx
python -c "
import zipfile, os
with zipfile.ZipFile('output.docx', 'w', zipfile.ZIP_DEFLATED) as z:
    for root, dirs, files in os.walk('unpacked/'):
        for f in files:
            fp = os.path.join(root, f)
            z.write(fp, os.path.relpath(fp, 'unpacked/'))
"
```

### Common Pitfalls
- **Replace entire `<w:r>` elements** when adding tracked changes
- **Preserve `<w:rPr>` formatting** — copy from original runs
- **Use smart quote entities** for all new text content

---

## Reading Content
```bash
# Install pandoc: https://pandoc.org/installing.html
pandoc document.docx -t plain    # Plain text
pandoc document.docx -t markdown # Markdown
```

## Dependencies
- `docx` npm package (for creating)
- `pandoc` (for reading/converting)
- Python standard library (for unpack/repack)
