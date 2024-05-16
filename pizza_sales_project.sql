use pizza_sales;
select * from pizza_sales;

-- total revenue
select sum(total_price) as total_revenue from pizza_sales;

-- average order values
select sum(total_price) /count(distinct order_id) as average_order_value from pizza_sales;

-- total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

-- total order
select count(distinct order_id) as total_orders from pizza_sales;

-- average pizza sold
select cast(cast(sum(quantity)as decimal (10,2)) / cast(count(distinct order_id) as decimal (10,2)) as decimal(10,2)) 
as average_pizza_sold from pizza_sales;


-- hourly trend for total pizza sold
select hour(order_time) as order_hour , sum(quantity)as total_pizza_sold
from pizza_sales
group by hour(order_time)
order by hour(order_time);

-- weekly trend for total pizza sold
SELECT WEEK(order_date, 3) AS WeekNumber,
YEAR(order_date) AS Year,
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY WEEK(order_date, 3),YEAR(order_date)
ORDER BY Year, WeekNumber;

-- percent of sales by pizza category
select pizza_category ,cast(sum(total_price) as decimal(10,2)) as total_revenue, cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales)as decimal (10,2)) as percent_of_total 
from pizza_Sales
group by pizza_category;

-- percent of sales by pizza size
select pizza_size ,cast(sum(total_price)as decimal (10,2)) as total_sales, cast( sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal (10,2)) as percent_of_total
from pizza_Sales
group by pizza_size
order by percent_of_total desc;

-- Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold 
FROM pizza_sales 
GROUP BY pizza_category 
ORDER BY Total_Quantity_Sold DESC;

-- 	top 5 pizzas by revenue
select pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue desc
limit 5;

-- bottom 5 pizzas by revenue
select pizza_name , sum(total_price) as total_revenue from pizza_sales
group by pizza_name
order by total_revenue asc
limit 5;

-- top 5 pizza by quantity
select pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity desc
limit 5;

-- bottom 5 pizzas by quantity
select pizza_name , sum(quantity) as total_quantity from pizza_sales
group by pizza_name
order by total_quantity asc
limit 5;

-- top 5 pizza by orders
select pizza_name , count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order desc
limit 5;

-- bottom 5 pizzas by orders
select pizza_name , count(distinct order_id) as total_order from pizza_sales
group by pizza_name
order by total_order asc
limit 5;
