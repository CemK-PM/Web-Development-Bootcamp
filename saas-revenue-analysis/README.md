# 💰 SaaS Revenue & Marketing ROI Analysis

> **Executive Summary:** A comprehensive marketing analytics study combining SQL, Tableau, and Google Sheets to track unit economics, revenue growth, and campaign efficiency.

---

### 🚀 Business Impact & Key Metrics
| Metric | Achievement / Value |
| :--- | :--- |
| **Financial Growth** | Scaled Monthly Recurring Revenue (MRR) from **$17K to $21K**. |
| **Monetization** | Maintained a stable **Average Revenue Per Paying User (ARPPU) of ~$11**. |
| **Retention** | Identified long-term revenue stability with **12.5% retention by Month 9**. |
| **Ad Efficiency** | Automated **ROAS & ROMI** tracking to optimize marketing budget allocation. |

---

### 🛠 Tech Stack & Tools
* **Data Processing:** SQL (Advanced Window Functions), Google Sheets
* **Business Intelligence:** Tableau Public
* **Frameworks:** Unit Economics, Cohort Analysis, Marketing Funnel Analytics

---

### 📊 Interactive Dashboards (Tableau)
*Data was analyzed across three primary dimensions to uncover growth opportunities:*

1. [**Location-Based Revenue Reports**](https://public.tableau.com/app/profile/cem.kahvecioglu/viz/UnitEconomicsSaaSFinancialMetrics/LocationBasedRevenueReportsandUserMetrics)
   * *Focus:* Geographic performance and regional user monetization.
2. [**Payment-Based Revenue Dynamics**](https://public.tableau.com/app/profile/cem.kahvecioglu/viz/Payment-BasedRevenueReports/PaymentDateReports)
   * *Focus:* Daily revenue streams and payment cycle fluctuations.
3. [**Product & Monthly Performance**](https://public.tableau.com/app/profile/cem.kahvecioglu/viz/RevenueReports_17492974831360/Dashboard1#1)
   * *Focus:* Monthly growth trends and product-level revenue contribution.

---

### 📷 Dashboard Preview
![Revenue Dashboard](./dashboard-preview.png)
*Snapshot: Multi-dimensional view of SaaS unit economics and marketing ROI.*

---

### 🧾 Technical Implementation
**SQL Marketing Performance Query**
This query demonstrates the calculation of efficiency metrics like ROAS and ROMI from raw campaign logs:

```sql
SELECT 
    campaign,
    SUM(spend) AS total_spend,
    SUM(revenue) AS total_revenue,
    -- ROAS: Return on Ad Spend
    SAFE_DIVIDE(SUM(revenue), SUM(spend)) AS roas,
    -- ROMI: Return on Marketing Investment
    SAFE_DIVIDE((SUM(revenue) - SUM(spend)), SUM(spend)) * 100 AS romi_percentage
FROM `marketing_data.campaign_logs`
GROUP BY 1
ORDER BY total_revenue DESC;
