-- In this project, i queried a sales dataset of a store obtained from kaggle to gain key insights on varying aspects of the store's business performance over a duration of four years.

-- To get a first look of the entire dataset
SELECT *
FROM dbo.Orders

-- To get the total number of orders
SELECT COUNT (*) as Total_Orders
FROM dbo.Orders


-- To get distinct number of orders
SELECT COUNT(DISTINCT[Order ID]) as Distinct_orders
FROM dbo.Orders


-- To get distinct number of customers
SELECT COUNT(DISTINCT [Customer ID]) as No_of_customers
FROM dbo.Orders


-- To get the various ship mode and count of orders made on each
SELECT [Ship Mode], COUNT(*) as sum_of_orders
FROM dbo.Orders
GROUP BY [Ship Mode]

-- To get different purchase segments, count of orders made and total sales 
SELECT [Segment],COUNT(*) as sum_of_orders, SUM(Sales) as Total_Sales
FROM dbo.Orders
GROUP BY [Segment]

-- To get different purchase category, count of orders made and total sales 
SELECT [Category],COUNT(*) as sum_of_orders, SUM(Sales) as Total_Sales
FROM dbo.Orders
GROUP BY [Category]

-- To get different purchase segments and total quantity of items purchased 
SELECT [Segment], SUM(Quantity) as Total_Quantity
FROM dbo.Orders
GROUP BY [Segment]

-- To get different purchase category and total sales
SELECT [Category], SUM(Sales) as Total_Sales
FROM dbo.Orders
GROUP BY [Category]

--To get total sum of sales
SELECT SUM(Sales) as Total_Sales
FROM dbo.Orders

--To get total sum of sales per segment
SELECT [Segment], SUM(Profit) as Total_Profit
FROM dbo.Orders
GROUP BY [Segment]

--To get total profit
SELECT SUM(Profit) as Total_Profit
FROM dbo.Orders


--To get total Total profit per category
SELECT [Category], SUM(Profit) as Total_Profit
FROM dbo.Orders
GROUP BY [Category]

--To get total discount per category
SELECT [Category], SUM(Discount) as Total_discount
FROM dbo.Orders
GROUP BY [Category]

--To get total discount per segment
SELECT [Segment], SUM(Discount) as Total_discount
FROM dbo.Orders
GROUP BY [Segment]

-- To gain key customer insights by year
SELECT DATENAME(Year, [Order Date]) as Business_year, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Discount) as Total_Discount, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Year, [Order Date])
ORDER BY DATENAME(Year, [Order Date]), COUNT([Order ID]), SUM([Quantity]), SUM(Sales), SUM(Discount), SUM(Profit) ASC 

-- To group insights by months
SELECT DATENAME(Month, [Order Date]), COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Discount) as Total_Discount, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Month, [Order Date]) 
ORDER BY DATENAME(Month, [Order Date]), COUNT([Order ID]), SUM([Quantity]), SUM(Sales), SUM(Discount), SUM(Profit)

-- To get top customers
SELECT DISTINCT([Customer Name]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Customer Name])
ORDER BY SUM(Sales) DESC

--To show the performance per region
SELECT DISTINCT([Region]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Region])
ORDER BY SUM(Sales) DESC

--To show the performance per state
SELECT DISTINCT([State]), SUM(Sales) as Total_sales, SUM(Quantity) as Total_quantity, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([State])
ORDER BY SUM(Sales) DESC

-- To show sales and profit per sub category
SELECT DISTINCT([Sub-Category]), SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Sub-Category])
ORDER BY SUM(Sales) DESC

-- To show Quantity Discount correlation
SELECT DISTINCT([Quantity]),COUNT([Order ID]) as No_of_orders, AVG(Discount) as Avg_Discount
FROM dbo.Orders
GROUP BY ([Quantity])
ORDER BY ([Quantity]) DESC


-- CREATING VIEWS FOR VISUALIZATION

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

-- View for sale/profit per month
CREATE VIEW Sales_profit_per_month as
SELECT DATENAME(Month, [Order Date]) as month_of_order, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Discount) as Total_Discount, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Month, [Order Date]) 
ORDER BY DATENAME(Month, [Order Date]), COUNT([Order ID]), SUM([Quantity]), SUM(Sales), SUM(Discount), SUM(Profit)

-- View for sales & profit per category
CREATE VIEW sales_profit_per_category as
SELECT DISTINCT([Sub-Category]) as Sub_category, SUM(Sales) as Total_sales, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY ([Sub-Category])
ORDER BY SUM(Sales) DESC

-- View for sum of sales per year 
CREATE VIEW sales_per_year as
SELECT DATENAME(Year, [Order Date]) as Business_year, COUNT([Order ID]) as no_of_orders, SUM([Quantity]) as Total_Quantity_Sold, SUM(Sales) as Total_sales, SUM(Discount) as Total_Discount, SUM(Profit) as Total_profit
FROM dbo.Orders
GROUP BY DATENAME(Year, [Order Date])
ORDER BY DATENAME(Year, [Order Date]), COUNT([Order ID]), SUM([Quantity]), SUM(Sales), SUM(Discount), SUM(Profit) ASC 

