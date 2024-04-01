create database pizza;
use pizza;

-- KPI
# Total Revenue
select sum(total_price) as Total_revenue from pizza_sales;

# Average Order value
select (sum(total_price)/count(distinct order_id)) as Avg_order_value from pizza_sales;

# Total Pizza Sold
select sum(quantity) as Total_sold from pizza_sales;

# Total Orders
select count(distinct order_id) from pizza_sales;

# Average pizzas per order
select CAST(CAST(SUM(quantity) as decimal(10,2)) / 
CAST(COUNT(distinct order_id) as decimal(10,2)) as decimal(10,2)) as Avg_Pizzas_per_order
from pizza_sales;

-- Daily Trend for total orders
select str_to_date(order_date,'%d-%m-%Y') from pizza_sales;
select dayname(str_to_date(order_date,'%d-%m-%Y')) as order_day, COUNT(distinct order_id) as total_orders 
from pizza_sales group by 1 order by total_orders desc;

-- Hourly trend of orders
SELECT str_to_date(order_time, '%H:%i:%s') from pizza_sales;
SELECT date_format(str_to_date(order_time, '%H:%i:%s'),'%H') as order_hours, COUNT(DISTINCT order_id) as total_orders
from pizza_sales group by order_hours order by order_hours;

-- Monthly trend of orders
select str_to_date(order_date,'%d-%m-%Y') from pizza_sales;
select monthname(str_to_date(order_date,'%d-%m-%Y')) as order_day, COUNT(distinct order_id) as total_orders 
from pizza_sales group by 1 order by total_orders desc;

-- % sales by pizza category
select pizza_category, CAST(SUM(total_price) as decimal(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales) as decimal(10,2)) as Per_sales_cat
from pizza_sales group by pizza_category order by per_sales_cat desc;

-- % sales by pizza size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as total_revenue,
cast(sum(total_price)*100/(select sum(total_price) from pizza_sales) as decimal(10,2)) as per_sales_size
from pizza_sales group by pizza_size order by per_sales_size desc;

-- Total pizza sold by pizza category
select pizza_category, sum(quantity) as total_sold from pizza_sales group by pizza_category;

-- Top 5 best sellers by total pizza sold
select pizza_name, sum(quantity) as total_sold from pizza_sales group by pizza_name order by total_sold desc limit 5;

-- Least 5 sellers by total pizza sold
select pizza_name, sum(quantity) as total_sold from pizza_sales group by pizza_name order by total_sold limit 5;

  




