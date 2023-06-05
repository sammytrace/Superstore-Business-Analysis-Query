-- CASE STUDY: SUPERSTORE BUSINESS ANALYSIS PROJECT

-- TABLE OF CONTENT

-- Introduction
-- Exploratory Analysis
-- Conclusion

/* INTRODUCTION

In this project i will be carry out an exploratory analysis of a 4-year customer transaction dataset of a superstore to discover insights regarding customer spending patterns,
sales and profitability of the superstore.*/

/* ABOUT THE DATASET
This dataset features twelve four years of customer transaction data from 2016 to 2019 all stored in an excel sheet. The dataset has 21 columns showing different attributes
of customer data. This dataset was retrieved from the popular website kaggle.*/

-- OBJECTIVES
/* The primary objectives of this data analysis project are to retrieve the following KPIs:
1) Total sum of sales, total number of distinct customers, total number of distinct orders made and total profit.
2) Total sales and profit made per region.
3) Total sales and profit made per year.
4) The most patronized shipping mode.
5) Total sales and profit per product sub-category.
6) Total sales and profit per state */

-- METHODOLOGY
/* 
WITH SQL
1) Investigate trends on data to gain insights on the objectives of this project.

WITH TABLEAU
2) Create effective data visualization to present the findings.
*/

-- EXPLORATORY ANALYSIS
--This dataset has already been cleaned, so we won't be carrying out any data cleaning exercise.

-- To get a first look of the entire dataset
SELECT *
FROM dbo.Orders


-- To get the total number of items ordered
SELECT COUNT (*) as Total_Orders
FROM dbo.Orders
--RESULT: A total of 9,994 items were ordered were made during the duration of the collection of this data.


-- To get distinct number of orders
SELECT COUNT(DISTINCT[Order ID]) as Distinct_orders
FROM dbo.Orders
-- RESULT: A total number of 5,009 different orders were made during the duration of the collection of this data.


-- To get distinct number of customers that have patronized the store
SELECT COUNT(DISTINCT [Customer ID]) as No_of_customers
FROM dbo.Orders
-- RESULT: A total of 793 different customers have purchased items from the superstore.


--To get total sum of sales made from the superstore
SELECT SUM(Sales) as Total_Sales
FROM dbo.Orders
-- RESULT: $2,297,201 was made from sales in the superstore.


--To get total profit
SELECT SUM(Profit) as Total_Profit
FROM dbo.Orders;
-- RESULT: $286,397 was made as profit from the superstore.


-- To get the most patronized shipping mode
SELECT [Ship Mode], COUNT(*) as sum_of_orders
FROM dbo.Orders
GROUP BY [Ship Mode]
-- RESULT: The standard class was most patronized with, 5,968 orders. Second class, first class and same-day ship modes followed with 1,945, 1,538 and 543 0rsers respectively.


-- To get different product segments, count of orders made in each, total sales and total profit 
SELECT [Segment],COUNT(*) as sum_of_orders, SUM(Sales) as Total_Sales, SUM(profit) as Total_profit
FROM dbo.Orders
GROUP BY [Segment]
-- RESULT: Consumer products had the most orders, sales and profit, followed by corporate and home office products respectively.


-- To get different product category, count of orders made on each, total sales and total profit. 
SELECT [Category],COUNT(*) as sum_of_orders, SUM(Sales) as Total_Sales, SUM(profit) as Total_profit
FROM dbo.Orders
GROUP BY [Category]
-- RESULT: Office supplies had the most orders, technology profucts made the most sales and profit.


-- To compare business performance by year
SELECT DATENAME(Year, [Order Date]) as Business_year, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Year, [Order Date])
ORDER BY SUM(Sales) DESC 
-- RESULT: Superstore made more revenue in sales and profits in 2019 than in any other year.


-- To compare the business performance by months
SELECT DATENAME(Month, [Order Date]), COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Month, [Order Date]) 
ORDER BY SUM(Sales) DESC
-- RESULT: The most sales are made in the fourth quarter with, with november having the most revenue in sales.


-- To get top customers
SELECT DISTINCT([Customer Name]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity
FROM dbo.Orders
GROUP BY ([Customer Name])
ORDER BY SUM(Sales) DESC
-- RESULT: Sean Miller was the superstore's top customer, having made over $25,000 in purchases.


--To show the performance of the different regions in the United States
SELECT DISTINCT([Region]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Region])
ORDER BY SUM(Sales) DESC
-- RESULT: The western region of the United States made the most revenue through sales, sold the most quantity of items and made the most profit.


--To show the performance per state
SELECT DISTINCT([State]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([State])
ORDER BY SUM(Sales) DESC
-- RESULT: US state of california made the most revenue in sales and profit.


-- To show sales and profit per sub category
SELECT DISTINCT([Sub-Category]), SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Sub-Category])
ORDER BY SUM(Sales) DESC
-- RESULT: Phones made the most revenue in sales but copiers made the most profit.


-- CREATING VIEWS TO BE USED FOR VISUALIZATION

--View for total orders
CREATE VIEW Total_Orders as
SELECT COUNT (*) as Total_Orders
FROM dbo.Orders


-- View for No of Customers
CREATE VIEW No_of_Customers as
SELECT COUNT(DISTINCT [Customer ID]) as No_of_customers
FROM dbo.Orders


-- View for Sum of Sales
CREATE VIEW Sum_of_Sales as
SELECT SUM(Sales) as Total_Sales
FROM dbo.Orders


-- View for Sum of Profit
CREATE VIEW Sum_of_Profit as
SELECT SUM(Profit) as Total_Profit
FROM dbo.Orders


-- View for sales per region
CREATE VIEW Sales_per_region as
SELECT DISTINCT([Region]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Region])
ORDER BY SUM(Sales) DESC


-- View for sales/profit per state
CREATE VIEW Sales_profit_per_state as
SELECT DISTINCT([State]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([State])
ORDER BY SUM(Sales) DESC


-- View for sales/profit per month
CREATE VIEW Sales_profit_per_month as
SELECT DATENAME(Month, [Order Date]) as month_of_order, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Discount) as Total_Discount, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Month, [Order Date]) 
ORDER BY SUM(Sales)


-- View for sales & profit per category
CREATE VIEW sales_profit_per_category as
SELECT DISTINCT([Sub-Category]) as Sub_category, SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Sub-Category])
ORDER BY SUM(Sales) DESC


-- View for sum of sales per year 
CREATE VIEW sales_per_year as
SELECT DATENAME(Year, [Order Date]) as Business_year, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Year, [Order Date])
ORDER BY SUM(Sales) DESC

-- CONCLUSION
/* A visualization showing these key performance indices will made using Tableau. */