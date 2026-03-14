---
name: xlsx
description: Use when creating, editing, analyzing, or processing Excel (.xlsx) files. Use when user needs to generate spreadsheets, work with formulas, format cells, or extract data from Excel documents.
---

# XLSX Creation, Editing, and Analysis

## Quick Reference

| Task | Tool | Install |
|------|------|---------|
| Create/edit with formulas | `openpyxl` | `pip install openpyxl` |
| Data analysis | `pandas` | `pip install pandas openpyxl` |
| Read existing file | `openpyxl` or `pandas` | Same as above |

---

## CRITICAL: Use Formulas, Not Hardcoded Values

**Always use Excel formulas instead of calculating values in Python and hardcoding them.** This ensures the spreadsheet remains dynamic and updateable.

```python
# ❌ WRONG — hardcoded calculation
total = sum(values)
ws['B10'] = total

# ✅ CORRECT — Excel formula
ws['B10'] = '=SUM(B2:B9)'
```

---

## Common Workflow

1. **Choose tool**: `pandas` for data, `openpyxl` for formulas/formatting
2. **Create/Load**: Create new workbook or load existing
3. **Modify**: Add/edit data, formulas, and formatting
4. **Save**: Write to file
5. **Verify**: Open and check formulas work correctly

---

## Creating Excel Files

### With openpyxl (Formulas + Formatting)
```python
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side, numbers

wb = Workbook()
ws = wb.active
ws.title = "Report"

# Headers with styling
headers = ["Item", "Quantity", "Price", "Total"]
header_font = Font(name="Calibri", size=12, bold=True, color="FFFFFF")
header_fill = PatternFill(start_color="2C5F2D", end_color="2C5F2D", fill_type="solid")

for col, header in enumerate(headers, 1):
    cell = ws.cell(row=1, column=col, value=header)
    cell.font = header_font
    cell.fill = header_fill
    cell.alignment = Alignment(horizontal="center")

# Data
data = [
    ["Widget A", 10, 25.99],
    ["Widget B", 5, 49.99],
    ["Widget C", 20, 9.99],
]

for row_idx, row_data in enumerate(data, 2):
    for col_idx, value in enumerate(row_data, 1):
        ws.cell(row=row_idx, column=col_idx, value=value)
    # Formula for Total column
    ws.cell(row=row_idx, column=4, value=f'=B{row_idx}*C{row_idx}')

# Summary row with formulas
summary_row = len(data) + 2
ws.cell(row=summary_row, column=1, value="TOTAL")
ws.cell(row=summary_row, column=4, value=f'=SUM(D2:D{summary_row-1})')

# Number formatting
for row in range(2, summary_row + 1):
    ws.cell(row=row, column=3).number_format = '$#,##0.00'
    ws.cell(row=row, column=4).number_format = '$#,##0.00'

# Column widths
ws.column_dimensions['A'].width = 15
ws.column_dimensions['B'].width = 12
ws.column_dimensions['C'].width = 12
ws.column_dimensions['D'].width = 15

wb.save("report.xlsx")
```

### With pandas (Data Analysis)
```python
import pandas as pd

# Create DataFrame
df = pd.DataFrame({
    "Name": ["Alice", "Bob", "Charlie"],
    "Score": [95, 87, 92],
    "Grade": ["A", "B+", "A-"]
})

# Export to Excel with formatting
with pd.ExcelWriter("output.xlsx", engine="openpyxl") as writer:
    df.to_excel(writer, sheet_name="Results", index=False)
```

---

## Reading Excel Files

### With openpyxl
```python
from openpyxl import load_workbook

wb = load_workbook("input.xlsx", data_only=True)  # data_only=True reads cached values
ws = wb.active

for row in ws.iter_rows(min_row=1, values_only=True):
    print(row)
```

### With pandas
```python
import pandas as pd

df = pd.read_excel("input.xlsx", sheet_name="Sheet1")
print(df.describe())
```

---

## Formatting Guide

### Number Formats
| Format | Example | Code |
|--------|---------|------|
| Currency | $1,234.56 | `'$#,##0.00'` |
| Percentage | 85.5% | `'0.0%'` |
| Date | 01/15/2024 | `'MM/DD/YYYY'` |
| Thousands | 1,234 | `'#,##0'` |
| Accounting | $ 1,234.56 | `'_($* #,##0.00_)'` |

### Color Coding (Financial Models)
| Color | Usage | Hex |
|-------|-------|-----|
| Blue | Input/assumption cells | `0000FF` |
| Black | Formulas/calculations | `000000` |
| Green | Links to other sheets | `008000` |
| Red | Hardcoded overrides | `FF0000` |

---

## Common Pitfalls

- **Don't hardcode calculated values** — always use Excel formulas
- **Use `data_only=True`** when reading to get cached values, not formula strings
- **Set column widths** — auto-width doesn't always work well
- **Number format strings** must match Excel's format exactly
- **Watch for `#REF!`, `#DIV/0!`, `#VALUE!`, `#NAME?`** errors in formulas

---

## Dependencies
- `openpyxl` — create/edit with formatting and formulas
- `pandas` — data analysis and simple exports
