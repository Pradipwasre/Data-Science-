# Probability and Statistics for Data Science

A concise reference covering random variables, common probability distributions, the Central Limit Theorem, and point estimation, along with their applications in data science and machine learning.

---

## 1. Random Variables: Discrete vs Continuous

### 1.1 Definition

A random variable is a variable that takes numerical values based on the outcome of a random experiment.

**Example:** Toss a coin. Assign Head = 1, Tail = 0. The outcome (1 or 0) is a random variable.

### 1.2 Discrete Random Variable

**Definition:** Takes a countable set of values (0, 1, 2, 3, ...).

**Example:** Number of heads in 10 coin tosses. Possible values: 0, 1, 2, ..., 10.

**More examples:**
- Number of defective items in a batch of 50.
- Number of emails received in an hour.
- Number of customers who make a purchase out of 100 visitors.

**Used in data science for:**
- Classification problems (spam = 1, not spam = 0).
- Predicting counts, such as how many customers will buy a product today.

### 1.3 Continuous Random Variable

**Definition:** Takes any value within a range; the number of possible values is infinite.

**Example:** Height of students. Can be 160.2 cm, 160.25 cm, 160.251 cm, and so on.

**More examples:**
- House prices (₹45.6 lakh, ₹45.65 lakh, ...).
- Temperature readings.
- Time taken to complete a task.

**Used in data science for:**
- Regression problems, such as predicting house prices, salary, or exam scores.

### 1.4 Discrete vs Continuous at a Glance

| Aspect | Discrete | Continuous |
|---|---|---|
| Values | Countable (0, 1, 2, ...) | Infinite, within a range |
| Example | Number of heads in 10 tosses | Height of students |
| ML task type | Classification | Regression |
| Typical output | Category or count | A real number |

![Discrete vs Continuous](images/discrete_vs_continuous.png)

*Left: a discrete distribution only has bars at whole numbers. Right: a continuous distribution is a smooth curve because values can fall anywhere along the axis.*

---

## 2. Common Probability Distributions

### 2.1 Bernoulli Distribution

**What it is:** A single trial with two possible outcomes, success (1) or failure (0).

**Example:** One coin toss. Head = 1 (success), Tail = 0 (failure).

**Formula:** P(X = 1) = p, P(X = 0) = 1 - p

**Used in data science for:**
- Binary classification tasks (spam vs not spam, fraud vs not fraud).
- Logistic regression models a Bernoulli outcome.

**Why it matters:** It is the simplest distribution and the building block for the Binomial distribution.

![Bernoulli Distribution](images/bernoulli.png)

### 2.2 Binomial Distribution

**What it is:** The result of repeating a Bernoulli trial n times and counting the number of successes.

**Example:** Toss a coin 10 times. The number of heads can be 0, 1, 2, ..., up to 10.

**Formula:** P(X = k) = C(n, k) · p^k · (1 - p)^(n - k)

**Used in data science for:**
- Predicting how many customers out of 100 visitors will make a purchase.
- A/B testing, such as comparing click counts between version A and version B.

**Why it matters:** It models the probability of a certain number of successes when an event is repeated a fixed number of times.

![Binomial Distribution](images/binomial.png)

### 2.3 Poisson Distribution

**What it is:** Models the number of times a rare, independent event occurs in a fixed interval of time or space.

**Example:** Number of accidents at a crossing per day, or number of emails received per hour.

**Formula:** P(X = k) = (lambda^k · e^(-lambda)) / k!

**Used in data science for:**
- Website traffic analysis, such as the number of clicks per minute.
- Call center modeling, such as the number of calls received per hour.

**Why it matters:** It is the right tool whenever events are rare, independent, and occur at a known average rate.

![Poisson Distribution](images/poisson.png)

### 2.4 Normal Distribution

**What it is:** A bell-shaped, symmetric distribution centered on the mean. Most naturally occurring data tends to follow this shape.

**Example:** Heights of students, exam scores, measurement errors.

**Formula:** f(x) = (1 / (sigma · sqrt(2·pi))) · e^(-(x - mu)^2 / (2·sigma^2))

**Used in data science for:**
- Linear regression, which assumes errors are normally distributed.
- Hypothesis testing and confidence intervals.

**Why it matters:** The Central Limit Theorem (covered next) explains why the Normal distribution appears so often, making it the foundation of classical statistics.

![Normal Distribution](images/normal.png)

### 2.5 Summary Table

| Distribution | Models | Example | Common ML Use |
|---|---|---|---|
| Bernoulli | One trial, success or failure | Single coin toss | Binary classification |
| Binomial | Count of successes in n trials | Heads in 10 tosses | A/B testing, conversion counts |
| Poisson | Count of rare events in fixed time/space | Emails per hour | Traffic and event prediction |
| Normal | Continuous, symmetric spread of values | Exam scores | Regression, hypothesis testing |

---

## 3. Central Limit Theorem (CLT)

### 3.1 The Core Idea

If repeated random samples are drawn from any population, regardless of the shape of that population's distribution, the distribution of the sample means approaches a Normal distribution as the sample size increases.

### 3.2 Step-by-Step Breakdown

1. **Start with a population that may not be Normal.** For example, exam marks in a class could be skewed, with many low scores and a few very high ones.
2. **Draw a sample.** Randomly pick, say, 30 students and calculate the average of their marks.
3. **Repeat many times.** Draw many such samples and record each sample's average.
4. **Observe the result.** When all these sample averages are plotted, they form a bell-shaped curve, even though the original population was skewed.

### 3.3 Why This Matters in Data Science

- **Statistical tools become usable:** Confidence intervals, hypothesis tests, and many regression assumptions rely on the Normal distribution. The CLT justifies using these tools even when the raw data is not Normal.
- **Model stability:** When a model is trained on sample data, the CLT explains why parameter estimates tend to behave predictably across different samples.
- **Error analysis:** The CLT explains why prediction errors often look approximately Normal, which makes uncertainty easier to measure.

### 3.4 Real-World Examples

- **Website analytics:** Daily visitor counts may vary widely, but weekly average visitor counts tend to look Normal.
- **Manufacturing:** Individual defect occurrences may be random, but the average defect rate across many batches follows a Normal distribution.
- **Finance:** Daily stock returns are volatile, but average monthly returns tend to look Normal.

### 3.5 Visual Demonstration

![Central Limit Theorem](images/clt_demo.png)

*The leftmost panel shows a skewed population (an exponential distribution). As the sample size used to calculate each mean increases from 5, to 30, to 100, the distribution of those sample means becomes increasingly Normal and increasingly narrow.*

**Key takeaway:** The CLT is the bridge between messy, real-world data and the well-understood mathematics of the Normal distribution. It is why statistics and machine learning techniques can be applied reliably to almost any dataset.

---

## 4. Point Estimation

### 4.1 What is Point Estimation?

In statistics, the goal is often to learn something about an entire population, such as the average height of all students in a country. Measuring the entire population is usually impossible, so a sample is taken instead, and a single number is calculated from that sample. This single number is called a point estimate — the best available guess of the true population value.

- **Population parameter:** The true value, which is generally unknown.
- **Point estimate:** A value calculated from a sample, used as a guess for the population parameter.

### 4.2 Example

A school has 2000 students, and the average height of all of them is needed.

- Measuring all 2000 students is impractical.
- Instead, 5 students are measured: 160, 162, 158, 161, 159 cm.
- Average of the sample = 160 cm.
- Conclusion: the school's average height is estimated to be about 160 cm.

That value, 160 cm, is the point estimate of the population mean.

![Point Estimation](images/point_estimation.png)

*The gray histogram is the full population. The five red points are a small sample drawn from it. The blue dashed line is the point estimate (the sample mean), and the green dotted line is the true population mean it is trying to approximate.*

### 4.3 Why Point Estimation Matters

- **Data science and machine learning:** Model parameters, such as weights and biases, are never known exactly. They are estimated from training data, and those estimates are point estimates.
- **Business:** Estimating average customer spend from a sample of transactions.
- **Medicine:** Estimating average recovery time from a sample of patients.

### 4.4 Types of Point Estimators

| Estimator | Estimates |
|---|---|
| Sample mean | Population mean |
| Sample variance | Population variance |
| Sample proportion | Population proportion (for example, percentage of customers who prefer a product) |

**Key takeaway:** Point estimation is how limited data is used to draw conclusions about a larger population. It is the same principle by which machine learning models learn their parameters from training data.

---

## Quick Recap

| Topic | Core Idea | Data Science Connection |
|---|---|---|
| Random variables | Assigning numbers to outcomes; discrete (countable) vs continuous (any value in a range) | Classification uses discrete outcomes, regression uses continuous outcomes |
| Bernoulli / Binomial | Single or repeated trials with success/failure outcomes | Binary classification, A/B testing |
| Poisson | Counting rare events over time or space | Traffic, arrivals, event-rate prediction |
| Normal | Bell-shaped distribution that most natural data approximates | Regression assumptions, hypothesis testing |
| Central Limit Theorem | Sample means become Normally distributed as sample size grows | Justifies using Normal-based statistical methods on almost any data |
| Point estimation | Using a sample statistic to guess a population parameter | How ML models learn parameters from training data |
