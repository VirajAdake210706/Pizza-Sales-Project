CREATE TABLE pizza_sales (
    pizza_id          SERIAL PRIMARY KEY,
    order_id          INTEGER,
    pizza_name_id     VARCHAR(50),
    quantity          INTEGER,
    order_date        DATE,
    order_time        TIME,
    unit_price        NUMERIC(6,2),
    total_price       NUMERIC(6,2),
    pizza_size        VARCHAR(5),
    pizza_category    VARCHAR(30),
    pizza_ingredients TEXT,
    pizza_name        VARCHAR(100)
);
DROP table pizza_sales;
SELECT *FROM pizza_sales;

--KPI's query.
--Q1.Total revenue generated.
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

--Q2.Average order value.
SELECT SUM(total_price)/COUNT (DISTINCT(order_id)) AS Avg_order_Value
FROM pizza_sales;

--Q3.Total pizzas sold.
SELECT SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales;

--Q4.Total Orders placed.
SELECT COUNT(DISTINCT order_id) AS total_orders_placed
FROM pizza_sales;

--Q5.Average pizzas per order.
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order
FROM pizza_sales;

--CHARTS query.
--Q1.Total sales according to days of week.
SELECT TO_CHAR(order_date,'Day') AS order_day,COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date,'Day');

--Q2.Monthly trends for total orders.
SELECT TO_CHAR(order_date,'Month') AS Month_Name,COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date,'Month')
ORDER BY Total_Orders DESC;

--Q3. % of sales by pizza category.
SELECT pizza_category,SUM(total_price) AS total_sales, SUM(total_price) *100 / (Select SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category
ORDER BY PCT DESC;

SELECT 
    pizza_category, 
    SUM(total_price) AS Total_Sales, SUM(total_price) *100 / (Select SUM(total_price) FROM pizza_sales WHERE EXTRACT(MONTH FROM order_date) = 7) AS PCT
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 7
GROUP BY pizza_category
ORDER BY total_sales DESC;

--Q4.Percentage of sales by pizza size.
SELECT pizza_size,SUM(total_price) AS total_sales, CAST((SUM(total_price) * 100) / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

SELECT pizza_size,SUM(total_price) AS total_sales, CAST(SUM(total_price) *100 / (Select SUM(total_price) FROM pizza_sales WHERE EXTRACT(QUARTER FROM order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE EXTRACT(QUARTER FROM order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC;

--Q5.TOP 5 / Bottom 5 sellers by revenue.
SELECT pizza_name,SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC LIMIT 5;

SELECT pizza_name,SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC LIMIT 5;

--Q6.TOP 5 / Bottom 5 sellers by quantities sold.
SELECT pizza_name,SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC LIMIT 5;

SELECT pizza_name,SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC LIMIT 5;

--Q6.TOP 5 / Bottom 5 sellers by Orders.
SELECT pizza_name,COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC LIMIT 5;

SELECT pizza_name,COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC LIMIT 5;



