📊 Customer & Marketing Analytics Dashboard
> An end-to-end interactive analytics dashboard analyzing 10,000+ customer records across demographics, purchase behavior, and campaign performance — built with Power BI, SQL, and Excel.
---
🚀 Live Demo
🔗 [View Live Dashboard ](https://github.com/siddeequlafthad-max/Customer-Analytics_Dashboard) 
(Replace with your GitHub Pages URL after deploying)
---
📸 Preview
![Dashboard Preview]<img width="553" height="401" alt="preview png" src="<img width="665" height="347" alt="Screenshot 2026-06-11 161522" src="https://github.com/user-attachments/assets/0944ec13-569c-40a4-a5e8-857c6b198b39" />
" />

---
📌 Project Overview
This project simulates a real-world Business Intelligence dashboard built for a marketing team to track customer health, campaign effectiveness, and revenue segmentation. The dashboard was designed to support data-driven budget reallocation decisions using RFM segmentation.
---
🎯 Key Features
Feature	Details
📋 KPI Tracking	CAC, CLV, Churn Rate, Campaign ROI via DAX measures
👥 Customer Analytics	Demographics, age distribution, regional revenue, purchase behavior
📣 Campaign Performance	Multi-channel ROI analysis across 6 channels
🎯 RFM Segmentation	SQL-based scoring — Champions, Loyal, Promising, At Risk, Lost
🔗 Data Integration	CRM + Sales + Marketing merged via Power Query
📊 Interactive Charts	Bar, Line, Donut, Radar, Heatmap — fully clickable
---
🔍 Key Findings
10,000+ customer records analyzed across demographics, behavior, and campaign data
Champions + Loyal segments (65% of customers) drive the majority of revenue — supporting targeted budget reallocation
Email delivers the highest ROI at 3.2×, followed by Referral at 2.9×
CLV grew 18% YTD while CAC dropped 12% — improving overall unit economics
Churn rate reduced from 8.5% → 6.4% through win-back campaigns targeting At-Risk segment
---
🛠️ Tech Stack
Tool	Purpose
Power BI	Dashboard design, visualization, interactive reporting
DAX	Custom KPI measures — CAC, CLV, Churn Rate, Campaign ROI
SQL	RFM segmentation logic — Recency, Frequency, Monetary scoring
Excel	Data cleaning, exploratory analysis
Power Query	ETL pipeline — integrating CRM, Sales & Marketing sources
---
📂 Project Structure
```
customer-analytics-dashboard/
│
├── customer-analytics-dashboard.html   # Interactive dashboard (open in browser)
├── README.md                           # Project documentation
└── preview.png                         # Dashboard screenshot
```
---
📊 Dashboard Pages
Page	Description
🏠 Overview	KPI cards, revenue trend, segment donut, campaign ROI bars
👥 Customers	Age distribution, regional breakdown, purchase frequency, recency
📣 Campaigns	Channel performance, multi-month trend, detailed campaign table
🎯 RFM Segments	SQL output, RFM heatmap, segment revenue table with actions
🔗 Data Sources	Power Query pipeline steps, DAX measure definitions
---
⚙️ How to Run
Clone the repository
```bash
   git clone https://github.com/yourusername/customer-analytics-dashboard.git
   ```
Open the dashboard
```bash
   cd customer-analytics-dashboard
   open customer-analytics-dashboard.html
   ```
Or simply double-click the `.html` file to open it in your browser.
No installation required — runs entirely in the browser!
---
🧠 DAX Measures Used
```dax
-- Customer Acquisition Cost
-- Customer Acquisition Cost
CAC = DIVIDE([Total Marketing Spend], [New Customers Acquired])
-- Customer Lifetime Value
CLV = [Avg Order Value] * [Purchase Frequency] * [Avg Customer Lifespan]
-- Churn Rate
Churn Rate = DIVIDE([Lost Customers], [Customers at Start of Period]) * 100
-- Campaign ROI
Campaign ROI = DIVIDE([Campaign Revenue] - [Campaign Cost], [Campaign Cost])
```

   \---

   ## 🗄️ SQL — RFM Segmentation Logic

   ```sql
-- RFM Scoring
WITH rfm AS (
  SELECT
    customer\_id,
    DATEDIFF(DAY, MAX(order\_date), GETDATE())    AS recency,
    COUNT(order\_id)                               AS frequency,
    SUM(order\_value)                              AS monetary
  FROM sales
  GROUP BY customer\_id
),
rfm\_scores AS (
  SELECT \*,
    NTILE(5) OVER (ORDER BY recency DESC)    AS r\_score,
    NTILE(5) OVER (ORDER BY frequency)       AS f\_score,
    NTILE(5) OVER (ORDER BY monetary)        AS m\_score
  FROM rfm
)
SELECT \*,
  CASE
    WHEN r\_score >= 4 AND f\_score >= 4 THEN 'Champion'
    WHEN r\_score >= 3 AND f\_score >= 3 THEN 'Loyal'
    WHEN r\_score >= 3 AND f\_score >= 1 THEN 'Promising'
    WHEN r\_score <= 2 AND f\_score >= 2 THEN 'At Risk'
    ELSE 'Lost'
  END AS segment
FROM rfm\_scores;
```
---
📈 Business Impact
Identified top-value customer segments driving 65% of total revenue
Recommended budget reallocation from Display (1.4× ROI) → Email (3.2× ROI)
Modeled win-back strategy for 1,230 At-Risk customers ($320 avg CLV)
Delivered insights to support quarterly marketing planning decisions
---
👤 Author
Siddiqul Afdad  
📧 [siddeequlafthad@gmail.com]  
🔗 https://www.linkedin.com/in/siddiqulafthad
🐙 GitHub
---
📄 License
This project is open source and available under the MIT License.
