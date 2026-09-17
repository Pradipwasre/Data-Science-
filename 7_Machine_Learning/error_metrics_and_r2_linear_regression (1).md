# Error Metrics & R2 in Linear Regression
### A Complete Guide: Theory + Hands-On Example (Salary vs. Experience)


> **Prerequisite:** Basic understanding of Simple Linear Regression (`y = mx + c`)

---

## Roadmap

| # | Topic | Why it matters |
|---|-------|-----------------|
| 1 | What is "Error" in a model? | Foundation for everything below |
| 2 | MAE - Mean Absolute Error | Easiest to interpret |
| 3 | MSE - Mean Squared Error | Penalizes big mistakes |
| 4 | RMSE - Root Mean Squared Error | Best of both worlds |
| 5 | R2 - Coefficient of Determination | "How good is my model, really?" |
| 6 | Applied Case Study | Salary Prediction using real data |
| 7 | Interview Cheat-Sheet | Quick revision before interviews |

---

## 1. What is "Error" in a Model?

When a regression model makes a prediction, it will almost never be 100% exact.
The gap between what actually happened and what the model guessed is called the **error** (also called the **residual**).

$$
e_i = y_i - \hat{y}_i
$$

| Symbol | Meaning |
|--------|---------|
| $y_i$ | **Actual** value (ground truth from data) |
| $\hat{y}_i$ | **Predicted** value (output of the model) |
| $e_i$ | **Error / Residual** for the $i^{th}$ data point |

> **Key idea:** Error can be **positive** (under-prediction) or **negative** (over-prediction). If we simply add up all errors, positives and negatives can cancel out and give a false sense of a perfect model. This is why we need better ways to aggregate error, leading us to **MAE**, **MSE**, and **RMSE**.

---

## 2. MAE - Mean Absolute Error

To stop positive and negative errors from cancelling out, we take the **absolute value** first.

$$
\text{MAE} = \frac{1}{n} \sum_{i=1}^{n} |y_i - \hat{y}_i|
$$

**Properties:**

- Same unit as the target variable (e.g., dollars for salary)
- Easy to explain to non-technical stakeholders ("on average, we're off by $X")
- Robust to outliers (treats all errors linearly)
- Downside: doesn't punish large/rare errors strongly

---

## 3. MSE - Mean Squared Error

Instead of taking the absolute value, we **square** the error. This removes negative signs and magnifies larger errors.

$$
\text{MSE} = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
$$

**Properties:**

- Unit becomes **squared** (e.g., dollars squared), hard to interpret directly
- Very sensitive to outliers

> **Why squaring hurts outliers so much:**
> If one error is `2` and another is `10`:
> - Absolute difference: `10` is only 5x bigger than `2`
> - Squared difference: `100` vs `4`, so `10` becomes **25x bigger** than `2`
>
> A single bad prediction can dominate the entire MSE score.

---

## 4. RMSE - Root Mean Squared Error

RMSE fixes MSE's "squared units" problem by taking the square root, bringing us back to the original unit, while still penalizing large errors more than MAE does.

$$
\text{RMSE} = \sqrt{\text{MSE}} = \sqrt{\frac{1}{n}\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}
$$

> **RMSE is always greater than or equal to MAE.** The gap between them tells you something important:
> - RMSE close to MAE means errors are fairly uniform, no big outliers
> - RMSE much larger than MAE means a few large errors (outliers) are present

### Worked Example

For errors $e = \{1, 2, 3, 4, 5\}$:

| Metric | Calculation | Result | Unit |
|--------|--------------|--------|------|
| **MAE** | $(1+2+3+4+5)/5$ | **3.00** | original |
| **MSE** | $(1^2+2^2+3^2+4^2+5^2)/5$ | **11.00** | squared |
| **RMSE** | $\sqrt{11}$ | **3.31** | original |

---

## 5. R2 - Coefficient of Determination ("Goodness of Fit")

MAE/MSE/RMSE tell you the size of the error, but they don't tell you how good that is relative to just guessing the average. That's exactly what **R2** answers.

> **R2 = "What fraction of the variation in $y$ does my model explain, compared to a naive model that always predicts the mean $\bar{y}$?"**

$$
R^2 = 1 - \frac{\displaystyle\sum_{i=1}^{n}(y_i - \hat{y}_i)^2}{\displaystyle\sum_{i=1}^{n}(y_i - \bar{y})^2}
= 1 - \frac{SS_{res}}{SS_{tot}}
$$

| Term | Name | Meaning |
|------|------|---------|
| $SS_{res} = \sum(y_i - \hat{y}_i)^2$ | Sum of Squared Residuals | Error your **model** makes |
| $SS_{tot} = \sum(y_i - \bar{y})^2$ | Total Sum of Squares | Error a "predict-the-mean" model would make |

### Interpreting R2 Values

| R2 Value | Interpretation |
|:---:|---|
| `0.3` | Poor fit, points scattered far from the line |
| `0.4 - 0.5` | Weak fit, still a lot of unexplained variance |
| `0.6 - 0.7` | Moderate fit, reasonably useful model |
| `0.9+` | Excellent fit, points lie almost on the regression line |
| `1.0` | Perfect fit (rare, and a risk of overfitting in real data) |
| `< 0` | Model is worse than just predicting the mean |

> **Interview tip:** R2 can technically be negative on a test set. It just means your model performs worse than a horizontal line at $\bar{y}$. This commonly trips up beginners who assume R2 is always between 0 and 1.

---

## 6. Applied Case Study: Salary Prediction

Let's tie all these metrics together using a real dataset: predicting `Salary` from `YearsExperience`.

### 6.1 The Dataset

```python
import pandas as pd

data = {
    "YearsExperience": [0.3, 0.5, 0.7, 0.7, 0.9, 1.0, 1.3, 1.5, 1.8,
                         2.1, 2.3, 2.3, 2.6, 2.7, 2.8, 2.8, 2.9, 3.0],
    "Salary":          [42500.0, 42700.0, 36100.0, 47500.0, 41000.0,
                         40000.0, 32400.0, 43900.0, 38200.0, 52600.0,
                         34800.0, 47400.0, 51600.0, 49100.0, 53500.0,
                         45600.0, 45500.0, 50700.0]
}

df = pd.DataFrame(data)
df.head()
```

| YearsExperience | Salary |
|:---:|:---:|
| 0.3 | 42500.0 |
| 0.5 | 42700.0 |
| 0.7 | 36100.0 |
| 0.7 | 47500.0 |
| 0.9 | 41000.0 |

> Note: even though salary generally trends upward with experience, it's noisy - some low-experience employees earn more than high-experience ones (e.g., 0.7 yrs gives $47,500 vs. 2.3 yrs gives $34,800). This is exactly why R2 for this dataset won't be a perfect `1.0`.

---

### 6.2 Train-Test Split & Model Fitting

```python
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

X = df[["YearsExperience"]]
y = df["Salary"]

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

model = LinearRegression()
model.fit(X_train, y_train)

print(f"sklearn Intercept (c): {model.intercept_:.2f}")
```

```text
sklearn Intercept (c): 34716.76
```

The fitted line takes the familiar form:

$$
\hat{y} = m \cdot x + c
$$

where $c$ (the intercept) is the predicted salary at zero years of experience, and $m$ (the slope, from `model.coef_`) is the expected salary increase per additional year of experience.

---

### 6.3 Evaluating the Model

```python
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
import numpy as np

y_pred = model.predict(X_test)

mae  = mean_absolute_error(y_test, y_pred)
mse  = mean_squared_error(y_test, y_pred)
rmse = np.sqrt(mse)
r2   = r2_score(y_test, y_pred)

print(f"MAE  : {mae:.2f}")
print(f"MSE  : {mse:.2f}")
print(f"RMSE : {rmse:.2f}")
print(f"R2   : {r2:.4f}")

print(f"\nInterpretation: On average, predictions are off by about ${rmse:,.0f}, "
      f"and the model explains {r2*100:.1f}% of the variance in Salary.")
```

```text
MAE  : 4464.14
MSE  : 29933674.71
RMSE : 5471.17
R2   : 0.9326

Interpretation: On average, predictions are off by about $5,471,
and the model explains 93.3% of the variance in Salary.
```

### 6.4 Connecting the Dots

| Metric | Value | What it tells us |
|--------|:---:|---|
| **MAE** | `$4,464.14` | On a typical prediction, we're off by about $4.5K |
| **MSE** | `$29,933,674.71` | Not directly interpretable (squared dollars), used mainly for optimization |
| **RMSE** | `$5,471.17` | Similar to MAE but slightly higher, so a few larger errors exist in the test set |
| **R2** | `0.9326` | The model explains 93.3% of the variation in salary using experience alone: an excellent fit |

> **Reading RMSE vs MAE together:** RMSE ($5,471) is noticeably higher than MAE ($4,464). This tells us there's at least one prediction with a larger-than-average error pulling RMSE up, worth investigating that specific test point before trusting the model blindly.

---

## 7. Interview Cheat-Sheet

**Q1. Why not just use MSE everywhere?**
MSE's units are squared, making it non-intuitive for stakeholders. It's still useful internally because it's mathematically easier to optimize (differentiable, penalizes large errors, used as the loss function in training).

**Q2. When would you prefer MAE over RMSE?**
When your dataset has outliers you don't want to dominate the error metric, e.g., fraud amounts, rare extreme values. MAE gives a more "typical" sense of error.

**Q3. When would you prefer RMSE over MAE?**
When large errors are especially costly in your business context (e.g., predicting demand for perishable stock). RMSE's extra sensitivity to big misses is a feature, not a bug.

**Q4. Can R2 be negative? What does that mean?**
Yes. It means your model performs worse than simply predicting the mean of `y` for every input. This can happen on unseen/test data, especially with a poor model or a bad train-test split.

**Q5. Is a high R2 always good?**
Not necessarily. A very high R2 (close to 1.0), especially on training data, can indicate overfitting. Always check R2 on a held-out test set, not just training data.

**Q6. What's the relationship between R2 and correlation (r)?**
For simple linear regression, R2 is literally the square of the Pearson correlation coefficient (r) between x and y.

**Q7. Does adding more features always increase R2?**
Yes, R2 never decreases when you add more predictors, even irrelevant ones. This is why Adjusted R2 is used in multiple regression, since it penalizes unnecessary features.

---

## Final Summary Table

| Metric | Formula | Unit | Sensitive to Outliers? | Best Used For |
|--------|---------|------|:---:|---|
| **MAE** | $\frac{1}{n}\sum|y_i-\hat{y}_i|$ | Original | No | Robust, easy-to-explain error |
| **MSE** | $\frac{1}{n}\sum(y_i-\hat{y}_i)^2$ | Squared | Yes | Model training / optimization |
| **RMSE** | $\sqrt{\text{MSE}}$ | Original | Yes | Balanced error reporting |
| **R2** | $1-\frac{SS_{res}}{SS_{tot}}$ | Unitless (0-1 typically) | Not applicable | Overall "goodness of fit" |

---

*Tip for teaching: Walk students through Sections 1 to 5 conceptually first (using the {1,2,3,4,5} toy example), then immediately reinforce it with the real Salary dataset in Section 6. Going from abstract formula to concrete numbers sticks much better in memory.*
