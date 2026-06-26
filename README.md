# Data-Science-
Daily Notes on Data Science - Python | FastAPI | Stremlit 


# Python Day 2 - Tuples and f-Strings

Continuing from Day 1: Variables and Mathematical Operations

---

## What is a Tuple?

A tuple is an ordered, immutable collection of items in Python. Think of it like a list but once you create it, you cannot change it. Tuples use parentheses `( )` instead of square brackets `[ ]`.

Key characteristics:
- Ordered: items have a fixed position (index)
- Immutable: cannot add, remove, or change items after creation
- Allows duplicates: same value can appear more than once
- Mixed data types: integers, strings, floats, even other tuples

---

## Why Use Tuples in Python?

| Reason | Explanation |
|--------|-------------|
| Safety | Data cannot be accidentally modified |
| Performance | Tuples are faster than lists for reading |
| Dict Keys | Tuples can be dictionary keys; lists cannot |
| Data Integrity | Great for fixed data like coordinates, RGB colors |
| Unpacking | Easily assign multiple variables at once |

Analogy: A tuple is like a sealed envelope. Once packed, the contents cannot be changed without creating a new one.

---

## Tuple vs List

| Feature | Tuple | List |
|---------|-------|------|
| Syntax | `( )` | `[ ]` |
| Mutable | No | Yes |
| Speed | Faster | Slower |
| Dict Key | Yes | No |
| Use Case | Fixed data | Dynamic data |

---

## Tuples in Data Science

Tuples appear everywhere in data science workflows:

- `.shape` in NumPy/Pandas returns a tuple like `(1500, 8)` which means (rows, columns)
- Coordinates: `(latitude, longitude)` for geographic data
- RGB colors: `(255, 128, 0)` for orange
- Returning multiple values from functions: Python returns them as a tuple
- Immutable labels: column names or tags that should not change

```python
import pandas as pd

df = pd.read_csv("sales_data.csv")
print(df.shape)           # (1500, 8)  -- a tuple
print(type(df.shape))     # <class 'tuple'>
```

---

## Code Examples

### Creating Tuples

```python
# Empty tuple
empty = ()

# Single item tuple -- note the comma, it is required
single = (42,)

# Multiple items
fruits = ("apple", "banana", "cherry")

# Mixed data types
student = ("Ayesha", 22, 3.8, True)

# Nested tuple
matrix = ((1, 2), (3, 4), (5, 6))
```

### Accessing Elements

```python
fruits = ("apple", "banana", "cherry", "date")

# Indexing starts at 0
print(fruits[0])          # apple
print(fruits[-1])         # date  (negative index counts from end)

# Slicing
print(fruits[1:3])        # ('banana', 'cherry')
print(fruits[:2])         # ('apple', 'banana')
```

### Tuple Unpacking

```python
# Assign multiple variables at once
coordinates = (28.6139, 77.2090)
latitude, longitude = coordinates
print(latitude)           # 28.6139
print(longitude)          # 77.2090

# Swap variables
a, b = 10, 20
a, b = b, a
print(a, b)               # 20 10
```

### Tuple Methods

```python
numbers = (4, 7, 2, 7, 9, 7, 1)

print(numbers.count(7))   # 3    how many times 7 appears
print(numbers.index(9))   # 4    position of first 9
print(len(numbers))       # 7    total items
print(max(numbers))       # 9
print(min(numbers))       # 1
print(sum(numbers))       # 37
```

### Converting Tuple to List and Back

```python
colors = ("red", "green", "blue")

colors_list = list(colors)         # convert to list
colors_list.append("yellow")       # add item
colors = tuple(colors_list)        # convert back to tuple

print(colors)   # ('red', 'green', 'blue', 'yellow')
```

---

## f-Strings (Formatted String Literals)

f-strings were introduced in Python 3.6 and are the modern, preferred way to embed variables inside strings.

Syntax: Put `f` before the quote, then wrap variables in `{ }`

### Basic Usage

```python
name = "Zara"
age = 25

# Old way
print("Hello, my name is " + name + " and I am " + str(age))

# f-string
print(f"Hello, my name is {name} and I am {age} years old.")
# Hello, my name is Zara and I am 25 years old.
```

### Expressions Inside f-Strings

```python
x = 10
y = 3

print(f"{x} + {y} = {x + y}")          # 10 + 3 = 13
print(f"{x} * {y} = {x * y}")          # 10 * 3 = 30
print(f"Power: {x ** y}")              # Power: 1000
print(f"Square root: {x ** 0.5:.2f}") # Square root: 3.16
```

### f-Strings with Tuples

```python
student = ("Ali", 20, "Data Science", 3.75)
name, age, major, gpa = student

print(f"Student Name : {name}")
print(f"Age          : {age} years")
print(f"Major        : {major}")
print(f"GPA          : {gpa:.1f} / 4.0")

# Output:
# Student Name : Ali
# Age          : 20 years
# Major        : Data Science
# GPA          : 3.8 / 4.0
```

### Formatting Numbers

```python
price = 1299.9876
population = 1400000000
percentage = 0.8745

print(f"Price    : Rs. {price:,.2f}")     # Rs. 1,299.99
print(f"People   : {population:,}")       # 1,400,000,000
print(f"Accuracy : {percentage:.1%}")     # 87.5%
```

---

## Practice Exercise

```python
# Create a tuple with your personal info
my_info = ("YourName", 21, "Python Learner", 7.5)

# Unpack it
name, age, role, score = my_info

# Display using f-strings
print(f"Name  : {name}")
print(f"Age   : {age}")
print(f"Role  : {role}")
print(f"Score : {score}/10")
print(f"Tuple : {my_info}")
print(f"Length: {len(my_info)} items")
```

---

## Quick Reference

| Operation | Syntax |
|-----------|--------|
| Create tuple | `t = (1, 2, 3)` |
| Single item | `t = (42,)` |
| Access item | `t[0]` |
| Slice | `t[1:3]` |
| Unpack | `a, b = t` |
| Length | `len(t)` |
| Count value | `t.count(x)` |
| Find index | `t.index(x)` |
| To list | `list(t)` |
| f-string basic | `f"Hello {name}"` |
| f-string format | `f"{value:.2f}"` |
| f-string percent | `f"{ratio:.0%}"` |

---

Day 2 Complete. Next: Lists, Dictionaries and Loops.
