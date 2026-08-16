<p align="center">
  <img src="Project%20Images/ember-mobile.png" alt="Ember Mobile" width="400">
</p>

<h1 align="center">Ember Mobile — Customer Churn Analytics</h1>

<p align="center">
  <em>Diagnosis, prediction and prescriptive intervention across the subscriber base.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/SQL-MySQL-4479A1?style=flat-square"/>
  <img src="https://img.shields.io/badge/Python-3.10+-3776AB?style=flat-square"/>
  <img src="https://img.shields.io/badge/Model-XGBoost-EB6E4B?style=flat-square"/>
  <img src="https://img.shields.io/badge/Explainability-SHAP-6C4CB4?style=flat-square"/>
  <img src="https://img.shields.io/badge/NLP-HuggingFace-FFD21E?style=flat-square"/>
  <img src="https://img.shields.io/badge/BI-Power%20BI-F2C811?style=flat-square"/>
  <img src="https://img.shields.io/badge/Measures-DAX-000000?style=flat-square"/>
</p>

---

## 1. About This Project

Ember Mobile is a mobile network operator working from a rebranded real-world telecom customer dataset (the underlying data is synthetic, seeded from an anonymised public telecom source and remodelled to represent the Ember Mobile business).

Please read this summary slide deck for the project: [Ember Mobile Churn Deck](<Project Slide Deck & BI Dash/Ember_Mobile_Churn_Deck.pdf>)

When the engagement began, Ember Mobile had operational customer records only — no analytics layer, no dashboards, no derived metrics, and no view of subscriber health beyond raw billing extracts. This project delivered the analytics stack end-to-end:

- Cleaned and modelled a MySQL data warehouse from the raw CRM extract
- Designed and built the Power BI executive dashboard, including all DAX measures used to derive MRR, ARR, ARPU, churn rate and retention risk
- Trained and deployed a customer churn prediction model with per-customer risk scoring
- Applied natural language sentiment analysis to customer disconnection reasons
- Produced a three-tier retention playbook now guiding the intervention programme

 ![Data Pipeline](Project%20Images/pipeline.png)

---

## 2. The Business Question

Revenue growth was masking a widening retention gap. MRR was up 17.6% over six quarters, but ARPU had fallen 10.5% and churn rate had risen +4 points over the same period. Every additional point of churn was compounding against the acquisition motion.

The analytics stack was commissioned to answer four questions:

- **Who is leaving?** — which segments of the subscriber base are driving the rise in churn.
- **Why are they leaving?** — the structural and behavioural drivers, and how customers feel when they go.
- **Who is going to leave next?** — a forward-looking, per-customer view of churn risk.
- **What should we do about it?** — a treatment framework that matches intervention intensity to risk and value.

Everything that follows is organised around answering those four questions in order.

---

## 3. Executive Summary

Ember Mobile's top-line revenue is growing, but the growth is being driven by subscriber volume rather than per-customer value. ARPU is compressing, churn is trending up for the sixth consecutive quarter, and roughly one third of the active base is now flagged at elevated churn risk.

The analytics stack built for this engagement makes the retention problem visible, predictable and actionable — from the KPIs on the executive dashboard down to the recommended intervention for every individual customer.

| Metric | Value |
|---|---|
| Customers in analytical base | ~21,000 |
| Baseline churn rate | 26% |
| Combined at-risk (High + Medium tier) | ~7,500 (36% of base) |
| Departing customers with negative sentiment | 37% |
| Chosen model operating threshold | 0.30 (recall-weighted) |

---

## 4. Key Findings

The analysis surfaced five findings that reframed how the retention problem should be approached.

- **Churn is a first-year problem, not a long-tail problem.** New customers leave at a materially higher rate than long-tenured ones, yet retention effort was concentrated on stable, mature accounts. The onboarding window is the highest-leverage intervention point.
- **Month-to-month contracts are the structural driver of the churn base.** Rolling-contract subscribers leave at multiples of the rate seen on fixed-term contracts. This is a contract-design issue as much as a customer-behaviour issue.
- **Fibre customers are the biggest revenue-at-risk segment.** They generate the strongest ARPU but churn at a noticeably higher rate than DSL customers — a product-quality signal, not a pricing one.
- **Value-added services behave as retention products.** Customers with OnlineSecurity, TechSupport or DeviceProtection are markedly stickier. These add-ons are underused as a retention lever.
- **How customers feel when they leave matters as much as why.** 37% of departing customers left with a negative sentiment. Service Quality complaints came through as 100% negative — the highest-priority root cause and the biggest brand-damage risk.

---

## 5. Recommendations to Ember Senior Leadership

The following recommendations are drawn from the findings above and are intended as strategic areas to explore rather than prescriptive targets.

### 1. Prioritise the early tenure window
New customers are consistently the most likely to leave, yet retention effort tends to concentrate on long-standing accounts that are already stable. There is a clear opportunity to rebalance onboarding and early-life engagement — structured check-ins, proactive support, and a recognisable loyalty moment before the end of the first year — so that customers form a habit before the churn risk peaks.

### 2. Move customers off rolling monthly contracts
Month-to-month subscribers are structurally the most volatile segment of the base. A deliberate migration strategy toward longer-term contracts, supported by pricing incentives that protect margin, would materially reduce the size of the at-risk population without requiring any change to the underlying product.

### 3. Investigate the fibre customer experience
Fibre-optic customers churn at a noticeably higher rate than customers on other connection types, despite generating the strongest revenue per account. This points to a product or service-quality issue rather than a pricing one, and warrants a joint review with Network Operations covering installation experience, early-life fault rates, and support responsiveness before further fibre acquisition investment is committed.

### 4. Reposition value-added services as retention tools
Customers who take add-ons such as online security, technical support, and device protection are markedly stickier than those who do not. These products are behaving as retention levers, not just revenue lines. Leadership should consider bundling them by default into new contracts and offering trial periods to at-risk customers, rather than treating them as optional upsells.

### 5. Reduce billing friction
Payment method is a strong signal of churn risk, with customers on manual or less committed payment types leaving at higher rates. Encouraging a shift toward automated payment methods — through small incentives and a smoother switching journey — would reduce involuntary churn and remove a recurring source of customer effort.

### 6. Operationalise churn prediction
The analysis demonstrates that churn is predictable from a small set of customer attributes. The natural next step is to move from descriptive reporting into a production risk score that feeds directly into the retention team's day-to-day workflow, with clear thresholds for automated save offers versus human outreach. This shifts the operating model from reactive to preventative.

### 7. Segment retention offers by customer value
Not all at-risk customers are equally valuable to retain. A tiered save-offer framework — aligned to expected lifetime value rather than applied uniformly — would improve the return on retention spend and protect margin on the accounts that matter most.

### Areas to explore further
Deeper investigation is recommended in three areas: the drivers behind fibre dissatisfaction, the behavioural differences between customers on automatic and manual payment methods, and the interaction between contract length and add-on adoption. Each has the potential to unlock further retention gains beyond the actions listed above.

---

## 6. Data Foundation

The analysis draws on the full customer file extracted from the CRM — subscriber demographics, contract terms, service subscriptions, billing history and account lifecycle events — reconciled into a single analytical layer.

**Scope**
- ~21,000 active and lapsed customer records
- Full account lifecycle: signup, contract start and end, last payment, last activity, disconnection date and reason
- 20+ service and billing attributes per customer
- Churn defined operationally from account status and disconnection date — no reliance on a pre-existing label

**Data quality treatment**
- De-duplication of repeated customer records
- Standardisation of categorical values (case, whitespace, spelling variants)
- Out-of-range values flagged and nulled (tenure, charges)
- Missing service and payment attributes imputed as `Unknown` to preserve row-level analytics
- All transformations logged and reproducible

Raw source data: [`Raw CSV Files/ember_mobile_raw.csv`](<Raw CSV Files/ember_mobile_raw.csv>)

---

## 7. Data Architecture

The warehouse is a star schema in MySQL — two fact tables and four dimensions, one row per customer per table, joined on `customerID`. This structure supports both the BI dashboards and downstream modelling from a single trusted source.

<p align="center">
  <img src="Project%20Images/BI-Star-Schema.png" alt="Ember Mobile Star Schema" width="700">
</p>

| Layer | Tables |
|---|---|
| **Facts** | `fact_billing`, `fact_activity` |
| **Dimensions** | `dim_customer`, `dim_account`, `dim_contract`, `dim_services` |

---

## 8. SQL Layer

The SQL layer handles normalisation, cleaning, and view creation for downstream consumers (Power BI and the ML notebooks).

| File | Purpose |
|---|---|
| [`SQL Queries/Normalisation & Table split.sql`](<SQL Queries/Normalisation & Table split.sql>) | Splits the flat CRM extract into the star schema; de-duplicates on customer ID; parses dates. |
| [`SQL Queries/clean star tables.sql`](<SQL Queries/clean star tables.sql>) | Standardises casing, nulls out-of-range values, imputes `Unknown` for missing categoricals. |
| [`SQL Queries/Customer Data Join.sql`](<SQL Queries/Customer Data Join.sql>) | Joins the fact and dimension tables into a single flat table. |
| [`SQL Queries/Customer Data Join & View.sql`](<SQL Queries/Customer Data Join & View.sql>) | Creates the analytical view joining all fact and dimension tables. |
| [`SQL Queries/prepared view for python ML with churned.sql`](<SQL Queries/prepared view for python ML with churned.sql>) | Derives the `IsChurned` label from `disconnection_date` and produces the ML-ready view. |

---

## 9. Power BI Dashboard

Ember Mobile had no BI capability prior to this engagement. The dashboard was built from the star schema up in Power BI Desktop, with a full set of DAX measures written to derive the retention KPIs the business needed.

**Dashboard pages**
- Executive KPI overview — MRR, ARR, ARPU, churn rate, at-risk customer count
- Segment cuts — churn by Contract, Payment Method, Internet Service and tenure band
- Risk-tier view — customer distribution across High / Medium / Low with stacked recommended actions
- Sentiment view — reason category and sentiment breakdown for departing customers

  ![Ember Mobile KPI Dashboard](Project%20Images/ember-mobile-main-KPI-dashboard.png)

**Key DAX measures**

```dax
-- Monthly Recurring Revenue
MRR =
CALCULATE (
    SUM ( fact_billing[MonthlyCharges] ),
    dim_account[account_status] IN { "Active", "Suspended" }
)
```

```dax
-- Annualised Recurring Revenue
ARR = [MRR] * 12
```

```dax
-- Average Revenue Per User
ARPU =
DIVIDE (
    [MRR],
    CALCULATE (
        DISTINCTCOUNT ( dim_customer[customerID] ),
        dim_account[account_status] IN { "Active", "Suspended" }
    )
)
```

```dax
-- Churn Rate (%)
Churn Rate =
DIVIDE (
    CALCULATE (
        DISTINCTCOUNT ( dim_customer[customerID] ),
        dim_account[account_status] IN { "Cancelled", "Ported-Out" }
    ),
    DISTINCTCOUNT ( dim_customer[customerID] )
)
```

```dax
-- At-Risk Customer Count (from scored table)
At-Risk Customers =
CALCULATE (
    DISTINCTCOUNT ( ember_scored[customerID] ),
    ember_scored[RiskTier] IN { "High", "Medium" }
)
```

```dax
-- Recovered MRR (from High-tier retention actions)
Recovered MRR =
CALCULATE (
    SUM ( fact_billing[MonthlyCharges] ),
    ember_scored[RiskTier] = "High",
    ember_scored[RetentionOutcome] = "Retained"
)
```

Deliverable: [Ember Mobile Dash](<Project Slide Deck & BI Dash/Ember Mobile Dash.pdf>)

---

## 10. Machine Learning Workflow & Performance

A gradient-boosted tree model (XGBoost) scores every customer's likelihood of churn. The workflow moves from a cleaned warehouse view through feature engineering, a baseline logistic regression, the production XGBoost model, threshold tuning, SHAP explainability, and per-customer risk-tier assignment.

<p align="center">
  <img src="Project%20Images/ML_Workflow_Flowchart.png" alt="ML workflow" width="720"/>
</p>

**Pipeline**
1. Pull cleaned customer table from the MySQL warehouse
2. Feature engineering across contract, service, billing and tenure attributes
3. Stratified 80/20 hold-out to preserve churn base rate
4. Baseline logistic regression as a reference
5. Gradient-boosted trees (XGBoost, 300 estimators, depth 5, lr 0.1) as the production model
6. Threshold tuning against precision / recall trade-off
7. Feature-level explainability via SHAP `TreeExplainer`
8. Every customer scored and assigned a risk tier (High / Medium / Low)

**Model performance**

The threshold sweep across 0.2–0.7 shows F1 peaking in the 0.30–0.40 band. The recommended operating point is **0.30**, chosen to prioritise recall — the cost of missing an at-risk customer materially exceeds the cost of a wasted outreach.

| Threshold | Precision | Recall | F1 |
|:---:|:---:|:---:|:---:|
| 0.20 | 0.51 | 0.92 | 0.66 |
| **0.30** | **0.63** | **0.85** | **0.72** |
| 0.40 | 0.72 | 0.75 | 0.73 |
| 0.50 | 0.80 | 0.63 | 0.70 |
| 0.60 | 0.85 | 0.48 | 0.61 |
| 0.70 | 0.90 | 0.31 | 0.46 |

Threshold is reviewed quarterly against retention programme outcomes.

Notebook: [`Python Files/ember mobile ml.ipynb`](<Python Files/ember mobile ml.ipynb>)

---

## 11. Risk-Tier Segmentation

Every customer is placed into a risk tier based on their predicted churn probability. The tiers drive the retention playbook — treatment intensity scales with tier.

<p align="center">
  <img src="Project%20Images/risk-tier-churn.png" alt="Risk Tier Churn" width="600">
</p>

| Tier | Customers | Share | Programme role |
|---|---:|---:|---|
| **Low** | 13,300 | 64% | Monitor and maintain |
| **High** | 4,600 | 22% | Priority intervention |
| **Medium** | 2,900 | 14% | Automated bundled offer |
| **Combined at-risk** | **~7,500** | **36%** | Active retention book |

Recommended actions are matched to each customer's profile and can be combined — a Medium-risk fibre customer on manual payment may receive an OnlineSecurity bundle, a TechSupport trial and an auto-pay credit as a single stacked treatment.

---

## 12. Sentiment Analysis

A HuggingFace transformer was applied to the free-text disconnection reasons captured in the CRM to distinguish *why* customers leave from *how they feel* about leaving. The distinction matters — an angry leaver needs a relationship reset, a neutral leaver often just needs a better offer.

<p align="center">
  <img src="Project%20Images/sentiment-analysis-python.png" alt="Sentiment Analysis" width="600">
</p>

**Findings**
- **Service Quality: 100% negative** — every mention is a complaint. This is the highest-priority root cause and the biggest brand-damage risk.
- **Pricing: 33% negative / 67% neutral** — a segmented response. Some customers left for a better deal; a subset are genuinely dissatisfied with value.
- **Life Change / Account Issue: 100% neutral** — structural, largely non-recoverable losses.
- **37% of departing customers left with a negative sentiment** — the headline number for the retention programme.

Notebook: [`Python Files/ember mobile customer sentiment ipynb.ipynb`](<Python Files/ember mobile customer sentiment ipynb.ipynb>)

---

## 13. Recommended Retention Playbook

| Tier | Customers | Treatment | Expected effect |
|---|---:|---|---|
| **High** | 4,600 | Dedicated retention call from account manager · personalised bundle or contract renewal offer · priority ticket routing · 48-hour first-contact SLA | Protect the highest-value revenue at risk of departure |
| **Medium** | 2,900 | Automated bundle offer (OnlineSecurity + TechSupport trial) · credit incentive to migrate to auto-pay · email/SMS nudge sequence · escalate to High if no engagement in 14 days | Efficient, scalable intervention on the mid-risk segment |
| **Low** | 13,300 | Onboarding outreach for customers in first 90 days · loyalty communications · monthly tier-drift monitoring | Maintain relationship and monitor for movement into higher tiers |

---

## 14. Deliverables

The tangible outputs of the engagement, each linked below:

| Deliverable | File |
|---|---|
| Executive slide deck | [`Ember_Mobile_Churn_Deck.pdf`](<Project Slide Deck & BI Dash/Ember_Mobile_Churn_Deck.pdf>) |
| Power BI dashboard export | [`Ember Mobile Dash.pdf`](<Project Slide Deck & BI Dash/Ember Mobile Dash.pdf>) |
| Scored customer file | [`Ember_Churn_Scored.xlsx`](<Raw CSV Files/Ember_Churn_Scored.xlsx>) |
| ML notebook | [`ember mobile ml.ipynb`](<Python Files/ember mobile ml.ipynb>) |
| Sentiment notebook | [`ember mobile customer sentiment ipynb.ipynb`](<Python Files/ember mobile customer sentiment ipynb.ipynb>) |
| SQL warehouse build | [`SQL Queries/`](<SQL Queries>) |

---

## 15. What I'd Do Next

Given more time or a follow-up engagement, three extensions would materially strengthen the stack:

- **Move from batch scoring to a scheduled refresh** — retrain and rescore on a weekly cadence, with model drift monitoring against a rolling holdout.
- **Add a lifetime-value model alongside the churn model** — so retention offers can be sized to the value of the customer, not just the probability of loss.
- **Close the loop with intervention outcomes** — capture which treatments were applied to which customers and feed the results back into the next model iteration, turning the risk score into a self-improving system.

---

## 16. Author

**Joseph Kennedy** — Data Analyst

End-to-end delivery: data engineering, warehousing (MySQL), BI dashboarding (Power BI / DAX), predictive modelling (XGBoost, SHAP), NLP (HuggingFace transformers), and stakeholder communication.

<sub>Underlying dataset is synthetic, seeded from an anonymised public telecom customer source and remodelled to represent the Ember Mobile business.</sub>
