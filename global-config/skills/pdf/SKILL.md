---
name: pdf
description: Use when creating, reading, editing, merging, splitting, or extracting content from PDF files. Use when user needs to process PDF documents, extract tables, add watermarks, or generate new PDFs.
---

# PDF Processing Guide

## Quick Reference

| Task | Tool | Install |
|------|------|---------|
| Read/extract text | `pypdf` or `pdfplumber` | `pip install pypdf pdfplumber` |
| Extract tables | `pdfplumber` + `pandas` | `pip install pdfplumber pandas` |
| Create new PDF | `reportlab` | `pip install reportlab` |
| Merge/split PDFs | `pypdf` | `pip install pypdf` |
| OCR scanned PDFs | `pytesseract` + `pdf2image` | `pip install pytesseract pdf2image` |

---

## Reading PDFs

### Extract Text
```python
from pypdf import PdfReader

reader = PdfReader("document.pdf")
for page in reader.pages:
    print(page.extract_text())
```

### Extract Text with Layout (Better Quality)
```python
import pdfplumber

with pdfplumber.open("document.pdf") as pdf:
    for page in pdf.pages:
        print(page.extract_text())
```

### Extract Tables
```python
import pdfplumber
import pandas as pd

with pdfplumber.open("document.pdf") as pdf:
    for page in pdf.pages:
        tables = page.extract_tables()
        for table in tables:
            if table:
                df = pd.DataFrame(table[1:], columns=table[0])
                print(df)
```

---

## Creating PDFs

### Basic PDF
```python
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas

c = canvas.Canvas("hello.pdf", pagesize=letter)
width, height = letter
c.drawString(100, height - 100, "Hello World!")
c.save()
```

### Multi-Page Report
```python
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, PageBreak
from reportlab.lib.styles import getSampleStyleSheet

doc = SimpleDocTemplate("report.pdf", pagesize=letter)
styles = getSampleStyleSheet()
story = []

story.append(Paragraph("Report Title", styles['Title']))
story.append(Spacer(1, 12))
story.append(Paragraph("Body content here. " * 20, styles['Normal']))
story.append(PageBreak())
story.append(Paragraph("Page 2", styles['Heading1']))

doc.build(story)
```

**⚠️ NEVER use Unicode subscript/superscript characters** (₀₁₂₃₄₅₆₇₈₉) in ReportLab — they render as black boxes. Use `<sub>` and `<super>` tags in Paragraph objects instead.

---

## Common Operations

### Merge PDFs
```python
from pypdf import PdfWriter, PdfReader

writer = PdfWriter()
for pdf_file in ["doc1.pdf", "doc2.pdf"]:
    for page in PdfReader(pdf_file).pages:
        writer.add_page(page)

with open("merged.pdf", "wb") as output:
    writer.write(output)
```

### Split PDF
```python
reader = PdfReader("input.pdf")
for i, page in enumerate(reader.pages):
    writer = PdfWriter()
    writer.add_page(page)
    with open(f"page_{i+1}.pdf", "wb") as output:
        writer.write(output)
```

### Add Watermark
```python
from pypdf import PdfReader, PdfWriter

watermark = PdfReader("watermark.pdf").pages[0]
reader = PdfReader("document.pdf")
writer = PdfWriter()

for page in reader.pages:
    page.merge_page(watermark)
    writer.add_page(page)

with open("watermarked.pdf", "wb") as output:
    writer.write(output)
```

### Password Protection
```python
from pypdf import PdfReader, PdfWriter

reader = PdfReader("input.pdf")
writer = PdfWriter()
for page in reader.pages:
    writer.add_page(page)

writer.encrypt("userpassword", "ownerpassword")
with open("encrypted.pdf", "wb") as output:
    writer.write(output)
```

### OCR Scanned PDFs
```python
# Requires: pip install pytesseract pdf2image
# Also needs Tesseract OCR installed on system
import pytesseract
from pdf2image import convert_from_path

images = convert_from_path('scanned.pdf')
for i, image in enumerate(images):
    text = pytesseract.image_to_string(image)
    print(f"Page {i+1}:\n{text}")
```

### Extract Metadata
```python
reader = PdfReader("document.pdf")
meta = reader.metadata
print(f"Title: {meta.title}, Author: {meta.author}")
```

---

## Dependencies
- `pypdf` — read, merge, split, encrypt
- `pdfplumber` — advanced text/table extraction
- `reportlab` — create new PDFs
- `pytesseract` + `pdf2image` — OCR (optional)
- `pandas` — table data processing (optional)
