# About this project

## 1.1 Overview
This project analyzes two datasets from a SaaS payments platform:-

* A sales dataset containing transaction-level details across countries, segments, customers, and products.
* A user funnel dataset tracking visit → signup → onboarding → activation → conversion events.
* Using SQL, Excel, and Power BI, I built an end-to-end analytical workflow to uncover revenue trends, identify profitable markets, evaluate product-level performance, and diagnose user funnel drop-offs.

## 1.2 Objectives
* Analyze sales, revenue, discount impact, and profitability.
* Identify top products and market profitability.
* Build a user funnel.
* Build an interactive Power BI dashboard.
* Deliver actionable recommendations

## 1.3 Tools & Skills Used
* Tools: Excel, SQL, Power BI

* Skills: Data cleaning, EDA, funnel analysis, profitability modeling, dashboard design, KPI development, insight generation

## 1.4 Data Cleaning & Preparation
* Standardized date formats.
* Managed extreme discounts.
* Created aggregated SQL views.

## 1.5 SQL Ad-hoc Reports:
1. Find total sales and profit by country and segment. • Sort descending by total sales.

```sql
SELECT
segment,
country,
ROUND(SUM(sales), 2) AS total_sales,
ROUND(SUM(profit), 2) AS total_profit
FROM dodo
GROUP BY segment, country
ORDER BY SUM(sales) DESC;
```


2. Write a query to calculate monthly revenue trend for the past 12 months.

```sql
SELECT MAX(YEAR(order_date)) AS latest_year
FROM dodo;

SELECT DISTINCT
MONTH(order_date) AS month,
ROUND(SUM(sales * quantity), 2) AS revenue
FROM dodo
WHERE YEAR(order_date) = 2023
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date);
```

3. Find which country–segment combination yields the highest profit margin.

```sql
SELECT TOP 5
product,
ROUND(SUM(sales * quantity), 2) AS total_revenue
FROM dodo
GROUP BY product
ORDER BY SUM(sales * quantity) DESC;
```

```sql
-- For each product, show total quantity sold and average discount
SELECT
product,
SUM(quantity) AS total_quantity,
ROUND(AVG(discount), 2) AS avg_discount
FROM dodo
GROUP BY product;
```

4. Identify the top 5 products by total revenue. • For each product, show total quantity sold and average discount.

```sql
SELECT
Country,
Segment,
ROUND(SUM(Profit), 2) AS TotalProfit,
ROUND(SUM(Sales), 2) AS TotalSales,
ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS ProfitMargin
FROM dodo
GROUP BY Country, Segment
ORDER BY ProfitMargin DESC;
```

5. Find each product’s revenue contribution % to the overall total revenue.

```sql
SELECT
Product,
ROUND(SUM(Quantity * Sales), 2) AS product_revenue,
ROUND(
(SUM(Quantity * Sales)
/ SUM(SUM(Quantity * Sales)) OVER ()) * 100,
2
) AS revenue_contribution_percentage
FROM dodo
GROUP BY Product
ORDER BY revenue_contribution_percentage DESC;
```

## 1.6 Dashboard Creation:
So Dashboard is in 5 parts, which I am going to explain below one by one:

1. Welcome page: This is a personalized page for the user who is viewing this report.

2. User Page: This page is dedicated to the user for the SAAS product. This page explains deeply about the user. eg: From where the user is, location-wise, industry-wise, and year-wise.

3. Sales Page: Now this page explains about sales coming from the SaaS Fintech Product. Like: Sales by segment, industries, and sales trends all over the years.

4. Revenue Page: This page show revenue by countries, product, and revenue trends by years.

5. User Funnel Analysis Page: This Page is dedicated to the user onboarding process. How and when the user first interacted with the website, they signed up and became a paid customer, and I will also analyze why the conversion is so low later.

## 1.7 Customer Funnel Analysis – Key Findings & Potential Causes
The funnel shows the progression from initial visit (1,276 users) to final conversion (119 users), resulting in an overall conversion rate of 9.3%. Below are the main observations and likely causes behind the drop-offs at each stage.

### 1. Visit → Signup Start (1276 → 1061 | 83.2%)
#### Observation
A relatively healthy transition rate ~83% of visitors start the signup process.

### Potential Reasons
* The landing page messaging and value proposition are compelling.
* Clear call-to-action (CTA) and straightforward signup entry point.
* Traffic quality is generally good.

### Possible Issues (minor)
   Some visitors may bounce because:
* They were exploring without strong intent.
* Page load speed or UI friction.
* Lack of clarity about pricing or trial terms.

### 2. Signup Start → Signup Complete (1061 → 857 | 67.2%)

• Observation
~33% drop during signup completion. This is higher than typical SaaS benchmarks (10–25%).

• Potential Reasons
##### Signup form friction:
* Too many fields
* Required phone numbers or payment details too early
Technical issues:
* Form errors, validation problems, slow loading
Unclear privacy or data concerns
* Interpretation
Users are initially interested but experience blockers during the form stage.

### 3. Signup Complete → Onboarding (857 → 477 | 37.4%)

• Observation
Large drop: over 60% of users who complete signup never engage in onboarding.

• Potential Reasons
* Poor post-signup handoff:
  * No clear “next step” after signup
  * Confusing or hidden onboarding entry point

* Email confirmation friction:
  * Verification emails going to spam
  * Required verification before access

* Expectation mismatch:
  * Product doesn’t match what the user thought they were signing up for
* Lack of immediate value on first login

* Interpretation

    * This is the largest opportunity area users are signing up but not activating.

4. Onboarding → Activation (477 → 223 | 17.5%)
• Observation
Low activation rate only ~18% fully activate.

* Potential Reasons
   * Onboarding experience is too long, confusing, or asks for too much info.
Users need guidance but aren’t receiving it:
   * No tutorials, tooltips, walk-throughs
   * Limited in-app clarity on how to reach "Aha!" moment
   * Technical or UX hurdles in early product use
   * Lack of perceived value in the initial experience
• Interpretation
-> Users who attempt onboarding aren’t seeing value quickly enough.

5. Activation → Conversion (223 → 119 | 9.3%)
• Observation
About half of activated users convert — this is not terrible, but has room to improve.

* Potential Reasons
  * Pricing friction or lack of perceived ROI
  * Trial doesn’t demonstrate full value before asking for payment
  * Poor follow-up nurturing or lack of in-app prompts for upgrade
  * Competitors offering more attractive alternatives
• Interpretation
Once users activate, many still need stronger incentives to convert.

## 1.8 Summary of Most Likely Key Issues
* High friction in signup completion → Form complexity or technical issues

* Significant drop between signup and onboarding → Poor guidance, email verification hurdles

* Low activation rate → Onboarding not driving users to the product’s.

* Moderate conversion challenges → Pricing, value perception, or weak upgrade prompts

## 1.9 Recommended Actions (High Impact)
1. Streamline the Signup Process
--> Reduce required fields
--> Eliminate unnecessary verification steps
--> Test form performance and error logs
2. Improve Post-Signup Guidance
--> Auto-login immediately after signup (if possible)
--> Provide a clear onboarding CTA
--> Improve email deliverability & confirmation flow
3. Redesign Onboarding to Show Value Faster
--> Add guided tours, tooltips, checklists
--> Trigger personalized onboarding depending on user profile
--> Highlight quick wins early
4. Strengthen Conversion Drivers
--> Offer time-limited incentives or feature previews
--> Highlight success metrics, case studies, ROI
--> Trigger targeted in-app messages before trial expiration

## 2.0 Dodo Payments Insights Reports
* Date Format: The Date column is in General data type and follows two different patterns: MM-DD-YYYY and DD/MM/YYYY. It should be standardized into one single format for better understanding and consistency.

* Discount Impact: Try to limit the Discount to the customer because company is losing every single time when itʼs gives a discount to the customer or else think of the price increase of the product but thatʼs debatable. Based on competitor and market trends else this will impact more badly to the company.

#### Example: A transaction with 50%, 60%, 70%, and 80% discounts has resulted in a loss.

Note: The Higher the discount higher the loss.

* Product Profitability: Product Alchemy, under the SMB Segment, is the only product that is profitable in Mexico and France. Try to upsell this product in other countries, too.

* Customer Feedback: Frequently take feedback based on the industry, sector, and country. This will help the company to make product modifications when required.

* Additional Data Insights: If I had more data to analyze, then I would track: Monthly Active Users( MAU) per product to measure adoption and retention rates Churn rate User activity Feature usage Repeat purchase rates Customer engagement with the product Most frequent support ticket After-sales feedback