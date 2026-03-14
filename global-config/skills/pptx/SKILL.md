---
name: pptx
description: Use when creating, editing, reading, or analyzing PowerPoint (.pptx) presentations. Use when user needs to generate slide decks, modify existing presentations, or extract content from .pptx files.
---

# PPTX Skill

## Quick Reference

| Task | Approach |
|------|----------|
| Read/analyze content | `python-pptx` or `pip install markitdown && python -m markitdown file.pptx` |
| Create from scratch | `python-pptx` |
| Edit existing | `python-pptx` |
| Visual QA | Convert to images and verify with `browser_subagent` |

---

## Reading Content
```python
from pptx import Presentation

prs = Presentation('input.pptx')
for i, slide in enumerate(prs.slides):
    print(f"\n--- Slide {i+1} ---")
    for shape in slide.shapes:
        if shape.has_text_frame:
            print(shape.text_frame.text)
```

---

## Creating Presentations

### Install
```bash
pip install python-pptx
```

### Basic Structure
```python
from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN

prs = Presentation()
prs.slide_width = Inches(13.333)   # Widescreen 16:9
prs.slide_height = Inches(7.5)

# Add blank slide
slide_layout = prs.slide_layouts[6]  # Blank layout
slide = prs.slides.add_slide(slide_layout)

# Add text box
txBox = slide.shapes.add_textbox(Inches(1), Inches(1), Inches(8), Inches(2))
tf = txBox.text_frame
p = tf.paragraphs[0]
p.text = "Slide Title"
p.font.size = Pt(36)
p.font.bold = True
p.font.color.rgb = RGBColor(0x1E, 0x27, 0x61)
p.alignment = PP_ALIGN.LEFT

prs.save('presentation.pptx')
```

---

## Design Ideas

**Don't create boring slides.** Plain bullets on white background won't impress.

### Before Starting
- **Pick a bold color palette** specific to the topic
- **Dominance over equality**: One color dominates (60-70%), 1-2 supporting, one accent
- **Dark/light contrast**: Dark backgrounds for title + conclusion, light for content
- **Pick ONE visual motif** and repeat it (rounded frames, icons in circles, thick borders)

### Color Palettes

| Theme | Primary | Secondary | Accent |
|-------|---------|-----------|--------|
| **Midnight Executive** | `#1E2761` | `#CADCFC` | `#FFFFFF` |
| **Forest & Moss** | `#2C5F2D` | `#97BC62` | `#F5F5F5` |
| **Coral Energy** | `#F96167` | `#F9E795` | `#2F3C7E` |
| **Warm Terracotta** | `#B85042` | `#E7E8D1` | `#A7BEAE` |
| **Charcoal Minimal** | `#36454F` | `#F2F2F2` | `#212121` |

### For Each Slide
**Every slide needs a visual element** — image, chart, icon, or shape.

Layout options:
- Two-column (text left, illustration right)
- Icon + text rows
- 2x2 or 2x3 grid
- Half-bleed image with content overlay
- Large stat callouts (60-72pt numbers)

### Typography

| Element | Size |
|---------|------|
| Slide title | 36-44pt bold |
| Section header | 20-24pt bold |
| Body text | 14-16pt |
| Captions | 10-12pt muted |

### Common Mistakes to Avoid
- ❌ Same layout on every slide
- ❌ Center-aligned body text (left-align paragraphs)
- ❌ Text-only slides with no visual elements
- ❌ Default blue color scheme
- ❌ Accent lines under titles (hallmark of AI-generated slides)
- ❌ Low-contrast text on background

---

## QA (Required)

**Assume there are problems. Your job is to find them.**

### Content QA
- All text renders correctly (no overflow, no truncation)
- Fonts applied consistently
- Colors match the palette
- No placeholder text remaining

### Visual QA
Convert to images for verification:
```python
# Save each slide as image for visual inspection
from pptx import Presentation
# Use LibreOffice to convert:
# libreoffice --headless --convert-to png presentation.pptx
```

Or use `browser_subagent` to open the file and take screenshots.

### Verification Loop
1. Generate presentation
2. Convert to images / take screenshots
3. Check every slide for issues
4. Fix problems found
5. Re-verify until clean

---

## Dependencies
- `python-pptx` — create and edit presentations
- `markitdown` — extract text content (optional)
- LibreOffice — convert to images for QA (optional)
