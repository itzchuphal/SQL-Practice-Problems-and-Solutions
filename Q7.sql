
-- You are working with a table called orders that tracks customer orders with their order dates and amounts. 

-- Write a query to find each customer’s latest order amount
-- along with the amount of the second latest order. 

-- Your output should be like 
-- customer_id, latest_order_amount, second_latest_order_amount    


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 101, '2024-01-10', 150.00),
(2, 101, '2024-02-15', 200.00),
(3, 101, '2024-03-20', 180.00),
(4, 102, '2024-01-12', 200.00),
(5, 102, '2024-02-25', 250.00),
(6, 102, '2024-03-10', 320.00),
(7, 103, '2024-01-25', 400.00),
(8, 103, '2024-02-15', 420.00);


-- Solution 


with cte as 
		(select *
		, rank() over(partition by customer_id order by order_date desc) as rnk
		from orders)
select customer_id
, max(case when rnk = 1 then order_amount end) as latest_order_amount
, max(case when rnk = 2 then order_amount end) as second_latest_order_amount
from cte
where rnk < 3
group by customer_id;


