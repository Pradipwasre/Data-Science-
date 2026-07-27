# Excel Formulas and Functions - Notes and Examples

This section focuses on Excel formulas and functions - the building blocks of data analysis.

---

## 1. Section Introduction

Formulas and functions are the core tools used in Excel to calculate, summarize, and analyze data. This section builds a strong foundation by using a real-world style dataset - Blanket Orders from the Pune area - to demonstrate each concept with practical examples.

---

## 2. Section Project and Dataset

**Project:** Blanket Orders - Pune Area

The dataset below simulates a wholesale/retail order register for blanket sales across different localities in Pune. It will be used as the reference dataset for every formula and function example in this section.

**Column Reference:**

| Column | Field |
|--------|-------|
| A | Order ID |
| B | Customer Name |
| C | Area (Pune) |
| D | Product |
| E | Quantity |
| F | Price per Unit (Rs) |
| G | Revenue (Rs) |
| H | Order Date |
| I | Delivery Date |
| J | Region/Zone |
| K | Salesperson |
| L | Payment Status |

**Sample Data (Rows 2 to 21):**

| Order ID | Customer Name | Area (Pune) | Product | Quantity | Price per Unit | Revenue | Order Date | Delivery Date | Region/Zone | Salesperson | Payment Status |
|----------|---------------|-------------|---------|----------|-----------------|---------|------------|----------------|-------------|-------------|-----------------|
| 2001 | Asha Kumar | Kothrud | Wool Blanket | 15 | 1200 | 18000 | 01-01-2026 | 05-01-2026 | West | Rohan Patil | Paid |
| 2002 | Vikram Shah | Hinjewadi | Fleece Blanket | 25 | 800 | 20000 | 02-01-2026 | 06-01-2026 | West | Neha Deshmukh | Pending |
| 2003 | Priya Nair | Wakad | Double Blanket | 10 | 1500 | 15000 | 02-01-2026 | 07-01-2026 | West | Rohan Patil | Paid |
| 2004 | Sameer Joshi | Baner | Single Blanket | 30 | 600 | 18000 | 03-01-2026 | 08-01-2026 | West | Neha Deshmukh | Paid |
| 2005 | Kiran Rao | Aundh | AC Blanket | 20 | 900 | 18000 | 03-01-2026 | 09-01-2026 | West | Amit Sawant | Pending |
| 2006 | Deepa Iyer | Viman Nagar | Mink Blanket | 12 | 2000 | 24000 | 04-01-2026 | 09-01-2026 | East | Amit Sawant | Paid |
| 2007 | Rahul Verma | Kharadi | Winter Quilt | 8 | 2500 | 20000 | 04-01-2026 | 10-01-2026 | East | Sneha Kulkarni | Paid |
| 2008 | Meena Pillai | Hadapsar | Baby Blanket | 40 | 400 | 16000 | 05-01-2026 | 11-01-2026 | East | Sneha Kulkarni | Pending |
| 2009 | Arjun Malhotra | Katraj | Wool Blanket | 18 | 1200 | 21600 | 05-01-2026 | 12-01-2026 | South | Rohan Patil | Paid |
| 2010 | Sonal Gupta | Swargate | Double Blanket | 14 | 1500 | 21000 | 06-01-2026 | 12-01-2026 | South | Amit Sawant | Paid |
| 2011 | Manish Kapoor | Shivaji Nagar | Fleece Blanket | 22 | 800 | 17600 | 06-01-2026 | 13-01-2026 | South | Neha Deshmukh | Pending |
| 2012 | Pooja Reddy | Camp | Single Blanket | 35 | 600 | 21000 | 07-01-2026 | 14-01-2026 | South | Sneha Kulkarni | Paid |
| 2013 | Anil Kulkarni | Deccan | AC Blanket | 16 | 900 | 14400 | 07-01-2026 | 15-01-2026 | South | Rohan Patil | Paid |
| 2014 | Sunita Menon | Pimpri | Mink Blanket | 10 | 2000 | 20000 | 08-01-2026 | 16-01-2026 | North | Amit Sawant | Pending |
| 2015 | Rakesh Bhatt | Chinchwad | Winter Quilt | 9 | 2500 | 22500 | 08-01-2026 | 16-01-2026 | North | Neha Deshmukh | Paid |
| 2016 | Nisha Agarwal | Wagholi | Baby Blanket | 45 | 400 | 18000 | 09-01-2026 | 17-01-2026 | North | Sneha Kulkarni | Paid |
| 2017 | Gaurav Singh | Magarpatta | Wool Blanket | 20 | 1200 | 24000 | 09-01-2026 | 18-01-2026 | North | Rohan Patil | Pending |
| 2018 | Ritu Chawla | Yerwada | Double Blanket | 11 | 1500 | 16500 | 10-01-2026 | 19-01-2026 | East | Amit Sawant | Paid |
| 2019 | Vivek Desai | Kondhwa | Fleece Blanket | 28 | 800 | 22400 | 10-01-2026 | 20-01-2026 | South | Sneha Kulkarni | Paid |
| 2020 | Kavita Bansal | Bavdhan | Single Blanket | 33 | 600 | 19800 | 11-01-2026 | 21-01-2026 | West | Neha Deshmukh | Pending |

This dataset (20 orders, rows 2 to 21) will be referenced throughout the formula and function examples below.

---

## 3. Formula Syntax

- Every formula starts with `=`
- Example: `=A1+B1`

---

## 4. Types of Functions

- **Math** -> `=SUM(A1:A10)`
- **Text** -> `=LEFT("Excel",2)`
- **Date/Time** -> `=TODAY()`
- **Logical** -> `=IF(A1>10,"Yes","No")`

---

## 5. Basic Math Functions

Using the Revenue column (G2:G21) from the Blanket Orders dataset:

- `=SUM(G2:G21)` -> Adds total revenue from all 20 orders.
- `=AVERAGE(G2:G21)` -> Average revenue per order.
- `=MIN(G2:G21)` -> Smallest order revenue.
- `=MAX(G2:G21)` -> Largest order revenue.

---

## 6. Fixed vs. Relative References

- Relative: `=E2*F2` -> changes automatically when copied down to E3*F3, E4*F4, and so on (used to calculate Revenue for each order).
- Absolute: `=$F$2*E2` -> keeps the price fixed while quantity changes, useful when one value (like a fixed unit price or tax rate) should not change on copying.

---

## 7. PRO TIP: Spill Ranges

Dynamic arrays spill results into multiple cells automatically.
Example: `=SEQUENCE(20)` -> generates Order Sr. No. 1 to 20 for the Blanket Orders list without manually dragging.

---

## 8. Explicit vs. Structured References

- Explicit: `=SUM(G2:G21)`
- Structured (Tables): `=SUM(BlanketOrders[Revenue])` (if the dataset is converted into an Excel Table named "BlanketOrders")

---

## 9. Common Error Types

- `#DIV/0!` -> Occurs when a formula divides by zero, e.g., calculating average price with zero quantity.
- `#N/A` -> Occurs when a lookup value (like an Order ID) is not found in the dataset.
- `#VALUE!` -> Occurs when text is used where a number is expected, e.g., quantity cell containing text instead of a number.

---

## 10. Counting Functions

- `=COUNT(E2:E21)` -> Counts numeric entries in the Quantity column.
- `=COUNTA(B2:B21)` -> Counts all non-empty customer names.
- `=COUNTIF(G2:G21,">20000")` -> Counts orders with revenue above Rs 20,000.

---

## 11. PRO TIP: SORT and UNIQUE

- `=SORT(C2:C21)` -> Lists Pune areas in alphabetical/ascending order.
- `=UNIQUE(D2:D21)` -> Extracts the unique list of blanket products sold (removes duplicate product names).

---

## 12. Logical Functions

- `=AND(E2>20,G2>15000)` -> Checks if quantity is above 20 AND revenue is above Rs 15,000.
- `=OR(J2="West",J2="East")` -> Checks if the region is either West or East.
- `=NOT(L2="Paid")` -> Returns TRUE if the payment status is not "Paid".

---

## 13. The IF Function

`=IF(G2>18000,"High Value","Low Value")`

Classifies each blanket order as High Value or Low Value based on revenue.

---

## 14. Nested IF Functions

`=IF(G2>22000,"Excellent",IF(G2>17000,"Good","Average"))`

Classifies orders into three revenue tiers: Excellent, Good, or Average.

---

## 15. AND/OR Operators (in combination with IF)

`=IF(AND(G2>18000,J2="West"),"Target Customer","Skip")`

Flags high-revenue customers specifically from the West zone as priority targets.

---

## 16. The IFERROR Function

`=IFERROR(G2/E2,"Error in calculation")`

Calculates price per unit safely; shows a custom message instead of `#DIV/0!` if quantity is zero.

---

## 17. Conditional Math Functions

- `=SUMIF(J2:J21,"West",G2:G21)` -> Total revenue generated from the West zone.
- `=AVERAGEIF(D2:D21,"Wool Blanket",G2:G21)` -> Average revenue from Wool Blanket orders.

---

## 18. PRO TIP: GROUPBY and PIVOTBY

Excel 365 introduces GROUPBY and PIVOTBY for summarizing data without a Pivot Table.

Example: `=GROUPBY(J2:J21,G2:G21,"Sum")` -> Summarizes total revenue by Region/Zone directly with a formula.

---

## 19. Lookup Functions

- `=VLOOKUP(2005,A2:L21,7,FALSE)` -> Finds the revenue for Order ID 2005.
- `=HLOOKUP("Product",A1:L1,4,FALSE)` -> Finds a column heading match in a horizontal layout.

---

## 20. The XLOOKUP Function

`=XLOOKUP(2010,A2:A21,B2:B21,"Order Not Found")`

Looks up Order ID 2010 in the Order ID column and returns the matching Customer Name; returns "Order Not Found" if no match exists.

---

## 21. Basic Date and Time Functions

- `=TODAY()` -> Returns the current date.
- `=NOW()` -> Returns the current date and time.
- `=DATEDIF(H2,I2,"D")` -> Calculates the number of days between Order Date and Delivery Date for each blanket order.

---

## 22. Basic Text Functions

- `=LEFT(D2,4)` -> Extracts the first 4 characters of the product name, e.g., "Wool" from "Wool Blanket".
- `=RIGHT(D2,8)` -> Extracts the last 8 characters, e.g., "Blanket" portion of the product name.
- `=LEN(B2)` -> Returns the number of characters in the customer name.
- `=CONCAT(B2," - ",C2)` -> Joins Customer Name and Area, e.g., "Asha Kumar - Kothrud".

---

## 23. PRO TIP: Flash Fill

Type a pattern and Excel automatically fills the rest based on it.

Example: Split "Asha Kumar" into separate First Name and Last Name columns by typing the first result manually and letting Flash Fill complete the rest for all 20 customers.

---

## 24. PRO TIP: Microsoft Copilot

Copilot can assist with the Blanket Orders dataset by helping to:

- Summarize total orders and revenue by area or region.
- Generate charts, such as revenue by product type.
- Answer natural language queries like "Show top 3 areas in Pune by revenue."

---

## 25. Key Takeaways

- Formulas are the building blocks of data analysis in Excel.
- Functions simplify repetitive and complex calculations.
- Logical and lookup functions add intelligence and decision-making to spreadsheets.
- Copilot enhances productivity by using AI on top of structured datasets.
