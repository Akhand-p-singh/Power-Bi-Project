-- 1.Revenue Breakdown
-- Find total sales and profit by country and segment. Sort descending by total sales.

select segment, country, Round(sum(sales),2) as total_sales, Round(sum(profit),2) As total_profit
from dodo
group by segment, country
order by sum(sales) desc




-- 2. Write a query to calculate monthly revenue trend for the past 12 months.

select MAX(year(order_date)) as latest_year from dodo

Select  distinct month(order_date) month, Round(sum(sales * quantity),2) as  revenue
from dodo
where year(order_date) = 2023
group by month(order_date)
order by month(order_date)




-- 3.1. Identify the top 5 products by total revenue.

select top 5 product, Round(sum(sales * quantity),2) as total_revenue
from dodo
group by product
order by sum(sales * quantity) desc

-- 3.2 For each product, show total quantity sold and average discount.

select product, sum(quantity) total_quantity, round(avg(discount),2) avg_disc
from dodo
group by product




-- 4. Find which country–segment combination yields the highest profit margin.

SELECT 
    Country,
    Segment,
    Round(SUM(Profit),2) AS TotalProfit,
    Round(SUM(Sales),2) AS TotalSales,
    Round((SUM(Profit) / SUM(Sales)) * 100,2) AS ProfitMargin
FROM dodo
GROUP BY Country, Segment
ORDER BY ProfitMargin DESC;




-- 5. Find each product’s revenue contribution % to the overall total revenue.

SELECT 
    Product,
    Round(SUM(Quantity * Sales),2) AS product_revenue,
    Round((SUM(Quantity * Sales) / SUM(SUM(Quantity * Sales)) OVER ()) * 100,2) AS revenue_contribution_percentage
FROM 
    dodo
GROUP BY Product
ORDER BY revenue_contribution_percentage DESC;



