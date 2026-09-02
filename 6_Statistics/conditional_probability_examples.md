# Conditional Probability - Complete Notes with Examples

## The Formula

P(A|B) = P(A ∩ B) / P(B)

This reads as: "The probability of A happening, given that B has already happened."

- P(A|B) = Probability of A, given B has occurred
- P(A ∩ B) = Probability that both A and B occur together (intersection)
- P(B) = Probability that B occurs

---

## Example 1: DMart Shopping (Fruit and Milk)

**Setup**

- A = Customer bought fruit
- B = Customer bought milk

**Question:** If we know a customer bought milk, what is the probability they also bought fruit?

**Data (out of 100 customers):**

- 40 customers bought milk (B)
- 25 customers bought both fruit and milk (A ∩ B)

**Calculation**

- P(Milk) = 40/100 = 0.40
- P(Fruit ∩ Milk) = 25/100 = 0.25
- P(Fruit | Milk) = 0.25 / 0.40 = 0.625

**Result:** If a customer bought milk, there is a 62.5 percent chance they also bought fruit.

**Interpretation (real world use):** A supermarket like DMart can use this to decide store layout and cross-selling. If milk buyers have a high chance of also buying fruit, the store can place fruit stalls near the dairy section, or bundle offers like "Buy milk, get fruit at discount". This is the same logic used in retail analytics and market basket analysis.

---

## Example 2: Students and Sports (Cricket and Football)

**Setup**

- B = Student plays cricket
- A = Student plays football
- A ∩ B = Student plays both football and cricket

**Question:** If a student plays cricket, what is the probability they also play football?

**Data (out of 1000 students):**

- 400 students play cricket (B)
- 250 students play both cricket and football (A ∩ B)

**Calculation**

- P(Cricket) = 400/1000 = 0.40
- P(Football ∩ Cricket) = 250/1000 = 0.25
- P(Football | Cricket) = 0.25 / 0.40 = 0.625

**Result:** If a student plays cricket, there is a 62.5 percent chance they also play football.

**Interpretation (real world use):** A school or college sports department can use this kind of analysis to plan schedules and infrastructure. If a large share of cricket players also play football, the department knows these two sports compete for the same students' time, so match schedules should not clash. This is also useful in sports analytics to identify multi-sport athletes for talent programs.

---

## Example 3: Car Insurance and Accidents

**Setup**

- B = Insurance (customer has car insurance)
- A = Accident (customer had an accident)
- A ∩ B = Customer had an accident and also had insurance

**Question:** If a customer has insurance, what is the probability they will have an accident?

**Data (out of 1000 customers):**

- 400 customers have car insurance (B)
- 120 customers had an accident and also had insurance (A ∩ B)

**Calculation**

- P(Insurance) = 400/1000 = 0.40
- P(Accident ∩ Insurance) = 120/1000 = 0.12
- P(Accident | Insurance) = 0.12 / 0.40 = 0.30

**Result:** If a customer has insurance, there is a 30 percent chance they will have an accident.

**Interpretation (real world use):** Insurance companies use exactly this kind of calculation to assess risk and decide premiums. A higher conditional probability of accidents among insured customers means higher expected claims, so the company will price policies higher for similar customer profiles. This is the foundation of actuarial risk modeling and underwriting.

---

## Example 4: Weather Forecast (Clouds and Rain)

**Setup**

- B = Clouds (a day is cloudy)
- A = Rain (it rains on that day)
- A ∩ B = It is cloudy and it rains

**Question:** If a day is cloudy, what is the probability it will rain?

**Data (out of 1000 days):**

- 300 days were cloudy (B)
- 180 days were cloudy and it also rained (A ∩ B)

**Calculation**

- P(Clouds) = 300/1000 = 0.30
- P(Rain ∩ Clouds) = 180/1000 = 0.18
- P(Rain | Clouds) = 0.18 / 0.30 = 0.60

**Result:** If a day is cloudy, there is a 60 percent chance it will rain.

**Interpretation (real world use):** Weather departments use conditional probability like this to build forecasting models. When forecasters see clouds forming, historical conditional probabilities like this one help them announce a rain forecast percentage (for example, "60 percent chance of rain today"), which is exactly what appears in weather apps.

---

---

# Bayes Theorem

Conditional probability answers a forward question: "Given B, what is the probability of A?"

Bayes theorem answers the reverse question: "Given A, what is the probability of B?"

## The Formula

P(A|B) = P(B|A) . P(A) / P(B)

## Terms

- P(A) = Prior Probability (what we believed before seeing new evidence)
- P(B) = Evidence Probability (overall probability of the evidence occurring)
- P(A ∩ B) = Joint Probability (probability that both events occur together)
- P(A|B) = Posterior Probability (probability of A after knowing B has occurred)
- P(B|A) = Likelihood (probability of B occurring given that A has occurred)

---

## Example 1: Car Insurance and Accidents (Bayes Theorem)

**Setup (1000 customers):**

- 400 customers took insurance (Event B = Insurance)
- 120 customers had an accident and also had insurance (Event A ∩ B = Accident ∩ Insurance)
- 200 customers had an accident (Event A = Accident)

### Step 1: Conditional Probability (Forward direction)

Question: If a customer has insurance, what is the probability they had an accident?

- P(Insurance) = 400/1000 = 0.4
- P(Accident ∩ Insurance) = 120/1000 = 0.12
- P(Accident | Insurance) = 0.12 / 0.4 = 0.30

Result: If a customer has insurance, there is a 30 percent chance they had an accident.

### Step 2: Bayes Theorem (Reverse direction)

Question: If a customer had an accident, what is the probability they had insurance?

Terms:

- P(A) = Probability of Accident = 200/1000 = 0.2
- P(B) = Probability of Insurance = 400/1000 = 0.4
- P(A|B) = Accident given Insurance = 0.3 (calculated above)

Formula:

P(Insurance | Accident) = P(Accident | Insurance) . P(Insurance) / P(Accident)
= (0.3 x 0.4) / 0.2
= 0.12 / 0.2
= 0.60

Result: If a customer had an accident, there is a 60 percent chance they had insurance.

**Interpretation (real world use):** This is exactly how insurance companies work in practice. The forward calculation (Accident given Insurance = 30 percent) is used for risk analysis and setting premiums when a new customer applies. The reverse calculation (Insurance given Accident = 60 percent) is used after a claim is filed, to check how likely it is that a person filing an accident claim genuinely holds a valid policy, which supports claim verification and fraud analysis. Conditional probability moves from cause to effect (Insurance leads to Accident risk), while Bayes theorem moves from effect back to cause (Accident leads back to Insurance likelihood).

---

## Example 2: Weather Forecast, Clouds and Rain (Bayes Theorem)

**Setup (1000 days):**

- 300 days had clouds (Event B = Clouds)
- 180 days had both clouds and rain (Event A ∩ B = Rain ∩ Clouds)
- 250 days had rain (Event A = Rain)

### Step 1: Conditional Probability (Forward direction)

Question: If a day is cloudy, what is the probability it will rain?

- P(Clouds) = 300/1000 = 0.3
- P(Rain ∩ Clouds) = 180/1000 = 0.18
- P(Rain | Clouds) = 0.18 / 0.3 = 0.60

Result: If a day is cloudy, there is a 60 percent chance it will rain.

### Step 2: Bayes Theorem (Reverse direction)

Question: If it rained, what is the probability that the day was cloudy?

Terms:

- P(A) = Probability of Rain = 250/1000 = 0.25
- P(B) = Probability of Clouds = 300/1000 = 0.3
- P(A|B) = Rain given Clouds = 0.6 (calculated above)

Formula:

P(Clouds | Rain) = P(Rain | Clouds) . P(Clouds) / P(Rain)
= (0.6 x 0.3) / 0.25
= 0.18 / 0.25
= 0.72

Result: If it rained on a given day, there is a 72 percent chance that day was cloudy.

**Interpretation (real world use):** Weather departments use the forward direction (Clouds given Rain) for day to day forecasting, since clouds are observed first and rain is predicted from them. The reverse direction (Rain given Clouds, computed backward from actual rain records) helps meteorologists validate their forecasting models by checking how consistently rain was preceded by clouds in historical data. This is used to improve and calibrate forecasting systems over time.

---

## Continuity: Conditional Probability versus Bayes Theorem

| Direction | Question Type | Insurance Example | Weather Example |
|---|---|---|---|
| Conditional Probability | Cause leads to Effect (Forward) | P(Accident \| Insurance) = 30% | P(Rain \| Clouds) = 60% |
| Bayes Theorem | Effect leads back to Cause (Reverse) | P(Insurance \| Accident) = 60% | P(Clouds \| Rain) = 72% |

## Key Takeaway on Bayes Theorem

- Conditional Probability moves from Cause to Effect.
- Bayes Theorem moves from Effect back to Cause.
- Insurance companies use both: Conditional Probability for Risk Analysis, and Bayes Theorem for Claim Verification.
- Weather departments use both: Conditional Probability for Forecasting, and Bayes Theorem for validating and calibrating their models using historical outcomes.
- Bayes theorem is essentially conditional probability applied in reverse, combining Prior belief and Likelihood of new evidence to produce an updated Posterior probability.

---

## Summary Table

| Example | B (Given) | A (To Find) | P(B) | P(A ∩ B) | P(A\|B) |
|---|---|---|---|---|---|
| DMart Shopping | Milk | Fruit | 0.40 | 0.25 | 0.625 |
| Sports | Cricket | Football | 0.40 | 0.25 | 0.625 |
| Insurance | Insurance | Accident | 0.40 | 0.12 | 0.30 |
| Weather | Clouds | Rain | 0.30 | 0.18 | 0.60 |

## Key Takeaway

Conditional probability tells us how the chance of one event changes once we already know another event has happened. It answers questions like:

- Retail: If a customer buys X, will they buy Y?
- Sports: If a student plays one sport, will they play another?
- Insurance: If a customer has insurance, will they have an accident?
- Weather: If it is cloudy, will it rain?

This same formula is the building block for Bayes theorem, where prior knowledge and likelihood are combined to update probabilities as new evidence arrives.
