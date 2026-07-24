# Excel Data Analysis Notes and Examples

## 1. Section Introduction

Excel is a powerful tool for data storage, cleaning, and analysis.
In this section, we will learn practical applications like formatting, validation, filtering, and using Copilot for insights.

## 2. Section Project and Dataset

**Sample Dataset (Sales Orders):**

| OrderID | Customer | Product | Region | Date       | Revenue |
|---------|----------|---------|--------|------------|---------|
| 1001    | Asha     | Laptop  | West   | 01-01-2024 | 55000   |
| 1002    | Ramesh   | Phone   | East   | 05-01-2024 | 22000   |
| 1003    | Sneha    | Tablet  | North  | 07-01-2024 | 30000   |
| 1004    | Vikram   | Laptop  | South  | 10-01-2024 | 60000   |
| 1005    | Priya    | Phone   | West   | 15-01-2024 | 25000   |

**Project Goal:** Build a mini dashboard showing sales trends, top products, and regional performance.

## 3. Data Terminology

- **Cell**: Intersection of row and column (e.g., A1).
- **Range**: Group of cells (A1:A10).
- **Dataset**: Structured table of related data.
- **Field**: Column in dataset.
- **Record**: Row in dataset.

## 4. Shortcuts for Navigating Data

- `Ctrl + Arrow Keys`: Jump to edge of data.
- `Ctrl + Home`: Go to first cell (A1).
- `Ctrl + End`: Go to last used cell.
- `Page Up / Page Down`: Scroll quickly.

## 5. Shortcuts for Entering and Editing Data

- `Ctrl + D`: Fill down.
- `Ctrl + R`: Fill right.
- `Ctrl + ;`: Insert today's date.
- `Ctrl + Shift + "+"`: Insert new row/column.
- `Ctrl + Z`: Undo.

## 6. Data Types

- **Text**: Names, labels.
- **Numbers**: Quantitative values.
- **Dates**: Stored as serial numbers.
- **Boolean**: TRUE/FALSE.

## 7. Dates in Excel

- `=TODAY()`: Current date.
- `=NOW()`: Current date and time.
- `=DATEDIF(A2,B2,"D")`: Days between two dates.

## 8. Number Formatting

- Currency: `#,##0.00`
- Percentage: `0.00%`
- Scientific: `0.00E+00`
- Custom: `00000` (forces 5 digit display).

## 9. Data Validation

Restrict input:

- Whole numbers only: Data > Data Validation > Allow: Whole Number.
- Dropdown list: Allow: List > Source: `Laptop,Phone,Tablet`.

## 10. PRO TIP: Checkboxes and Dropdown Lists

- Developer Tab > Insert > Form Controls.
- Add checkbox for Yes/No.
- Add dropdown for category selection.

## 11. Removing Duplicates

- Data > Remove Duplicates.
- Formula method (Excel 365): `=UNIQUE(A2:A100)`

## 12. Conditional Formatting

Highlight sales greater than 50,000:

- Formula: `=B2>50000`
- Use Color Scales to visualize growth trends.

## 13. Filtering Data

- Data > Filter.
- Example: Show only Region = West.
- Advanced Filter for custom criteria.

## 14. Sorting Data

- Sort by Revenue (Largest to Smallest).
- Multi level sort: Region, then Product, then Revenue.

## 15. PRO TIP: Microsoft Copilot

Copilot can:

- Summarize dataset automatically.
- Generate charts with natural language prompts.
- Example: "Show me top 5 products by revenue."

## 16. Key Takeaways

- Excel enables data cleaning, organization, and visualization.
- Shortcuts improve speed.
- Validation and formatting ensure accuracy.
- Copilot adds AI powered insights.
