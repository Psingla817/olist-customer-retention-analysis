# PM Insights — Olist Customer Retention Analysis

## 1. Business Problem

How can an e-commerce platform increase repeat purchases after a customer's first order?

The analysis focuses on understanding customer retention after the first purchase and identifying product and experience factors associated with repeat purchasing behavior.

---

## 2. Baseline

- Unique customers: 96,096
- Total orders: 99,441
- Repeat customers: 2,997
- Repeat purchase rate: 3.12%
- Average time to second purchase: 80.35 days

The baseline indicates that only a small proportion of customers return for another purchase.

---

## 3. Key Insights

### Insight 1 — Extremely Weak Early Retention

**Finding:** Customer retention drops sharply after the first purchase.

**Evidence:**
- Month 0 retention: 100%
- Month 1 retention: 0.48%
- Month 3 retention: 0.22%
- Month 6 retention: 0.19%
- Month 12 retention: 0.13%

**Product implication:**

The largest retention opportunity is immediately after the first purchase. A post-purchase retention journey should therefore begin shortly after the first order rather than waiting for customers to become inactive.

---

### Insight 2 — First-Purchase Category Is Associated With Retention

**Finding:** Repeat purchase rates vary substantially depending on the customer's first-purchase category.

**Evidence:**

Highest-performing categories included:

- Home appliances: 9.14%
- Fashion bags & accessories: 5.95%
- Furniture decor: 4.56%
- Bed/bath/table: 4.50%
- Sports/leisure: 3.92%

Lower-performing categories included:

- Electronics: 1.76%
- Consoles/games: 1.73%
- Musical instruments: 1.80%

**Product implication:**

A single generic retention strategy may not work equally well across categories. Post-purchase recommendations and re-engagement campaigns should be tailored to the customer's first-purchase category.

---

### Insight 3 — Delivery Experience Is Associated With Repeat Purchase

**Finding:** Customers whose first order was delivered late had a lower repeat purchase rate than customers whose first order was delivered on time.

**Evidence:**

- On time: 3.13%
- Late: 2.56%
- Not delivered: 4.22%

The difference between on-time and late delivery is 0.57 percentage points.

**Product implication:**

Delivery experience may be an important retention lever. Customers experiencing a late first delivery could receive proactive communication, recovery offers, or targeted post-delivery engagement.

**Data-quality note:**

The "Not delivered" group has a higher repeat rate than the on-time group. This should not be interpreted as evidence that non-delivery improves retention. The category likely contains unusual order states and requires further investigation before drawing a causal conclusion.

---

### Insight 4 — Higher First-Order Value Does Not Mean Higher Retention

**Finding:** Higher-value first orders are not associated with higher repeat purchase rates.

**Evidence:**

| Customer Segment | Avg First-Order Value | Repeat Purchase Rate |
|---|---:|---:|
| Low Value | 49.68 | 3.27% |
| Medium Value | 108.71 | 3.12% |
| High Value | 330.94 | 2.90% |

Repeat purchase rate decreases from 3.27% for low-value customers to 2.90% for high-value customers.

**Product implication:**

Customer value alone should not be used as the primary retention targeting variable. High-value first-time customers may require a different retention strategy rather than simply receiving more generic promotional messaging.

---

## 4. Recommendations

### Recommendation 1 — Build a First-30-Day Retention Journey

Create a structured post-purchase journey beginning immediately after the first order.

Potential touchpoints:

1. Order delivered confirmation
2. Product education / usage content
3. Personalized complementary-product recommendations
4. Reminder or incentive before the customer becomes inactive

The goal is to encourage the second purchase within the early customer lifecycle.

---

### Recommendation 2 — Personalize Recommendations by First-Purchase Category

Use the customer's first purchased category to determine recommended products and follow-up messaging.

For example:

- Bed/bath/table → home decor and housewares
- Furniture decor → housewares and garden tools
- Sports/leisure → watches/gifts and health/beauty

The category-transition analysis indicates that customers frequently move between related categories.

---

### Recommendation 3 — Create a Delivery-Recovery Journey

Customers experiencing a late first delivery should enter a targeted recovery journey.

Potential actions:

- Proactive delay notification
- Clear revised delivery expectations
- Post-delivery apology/recovery communication
- Small incentive toward the next purchase
- Personalized recommendations after successful delivery

The objective is to prevent a poor first-order experience from becoming customer churn.

---

## 5. Experiment Plan

### Experiment 1 — Personalized Second-Purchase Recommendations

**Hypothesis:**

Customers receiving recommendations based on their first-purchase category will have a higher second-purchase rate than customers receiving generic recommendations.

**Control:**

Generic post-purchase communication.

**Treatment:**

Category-personalized product recommendations.

**Primary KPI:**

30-day repeat purchase rate.

**Secondary KPIs:**

- Click-through rate
- Conversion rate
- Average second-order value
- Time to second purchase

---

### Experiment 2 — Delivery Recovery Intervention

**Hypothesis:**

A targeted recovery experience after a late first delivery will improve repeat purchasing.

**Control:**

Standard post-delivery communication.

**Treatment:**

Proactive recovery communication + targeted incentive/recommendations.

**Primary KPI:**

30-day repeat purchase rate among customers with late first deliveries.

**Secondary KPIs:**

- Second-order conversion
- Time to second purchase
- Customer engagement
- Incentive redemption rate

---

## 6. Success Metrics

### Primary KPI

**Repeat Purchase Rate**

Customers making 2 or more purchases / Total unique customers.

### Supporting KPIs

- 30-day repeat purchase rate
- 60-day repeat purchase rate
- Time to second purchase
- Second-order conversion rate
- Average second-order value
- Category-level repeat purchase rate

---

## 7. Limitations

- This is observational analysis and does not establish causation.
- Category and delivery experience are associated with retention but may be influenced by other factors.
- The "Not delivered" delivery group contains unusual order states and should be investigated separately.
- Some product categories have relatively small customer populations, so their repeat rates may be less statistically stable.
- The dataset represents historical e-commerce behavior and may not directly reflect current customer behavior.