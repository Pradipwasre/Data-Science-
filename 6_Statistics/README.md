# Day 43 — Statistics for Machine Learning (Part 1)

A ready-to-teach package: board theory + a real-looking dataset + an interactive Streamlit app.

## 📂 What's inside

```
Day43_Statistics_ML/
├── THEORY.md                     ← Board notes: definitions + tiny hand-calculable examples
├── app.py                        ← Streamlit app (the main class demo)
├── requirements.txt              ← Python packages needed
├── data/
│   ├── generate_data.py          ← Script that generated the dataset (students can re-run/tweak it!)
│   └── student_life_dataset.csv  ← 500 synthetic students, ready to use
└── README.md                     ← You are here
```

## 🧑‍🏫 Suggested class flow (60–75 min)

1. **(10 min)** Teach `THEORY.md` section 1 — What is Statistics & why it matters — on the board.
2. **(15 min)** Teach Central Tendency (Mean/Median/Mode) on the board using the tiny 5-number examples in `THEORY.md`.
3. **(10 min)** Switch to the Streamlit app → **"Central Tendency"** page. Select `Monthly_Pocket_Money` and show how Mean ≠ Median because of outliers — this is the exact board example, just at scale (500 students instead of 5).
4. **(10 min)** Teach Variability on the board (cricket team example).
5. **(10 min)** Streamlit → **"Variability"** page. Compare `Math_Score` between Section A and Section B — same mean, different spread.
6. **(10 min)** Teach Skewness & Kurtosis on the board (income / retirement age examples).
7. **(10 min)** Streamlit → **"Shape"** page, then finish with **"Outlier Playground"** — let a student come up and drag the slider live. This is usually the "aha!" moment of the class.

## ▶️ How to run the app

```bash
cd Day43_Statistics_ML
pip install -r requirements.txt
streamlit run app.py
```

It will open automatically at `http://localhost:8501`.

## 🔄 Want a different dataset?

Run `python data/generate_data.py` — it regenerates `student_life_dataset.csv` with a new random
sample (same shapes/patterns: skewed pocket money, bimodal screen time, etc.). Great for giving
each batch of students a slightly different dataset, or as a "generate your own data" exercise.

## 🧠 Ideas for a student assignment (optional)

- Ask students to add a new column to `generate_data.py` (e.g. `Netflix_Hours`) and decide *in advance*
  whether they expect it to be symmetric, skewed, or bimodal — then verify in the app.
- Ask them to find which column has the highest kurtosis and explain *why*, in real-world terms.
- Ask them to use the **Outlier Playground** and write one sentence: "Mean is more sensitive to
  outliers than Median because ___."
