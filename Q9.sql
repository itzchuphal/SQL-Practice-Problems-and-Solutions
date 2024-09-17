
-- Creating Table


drop table if exists purchases;
CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    user_id INT,
    date_of_purchase TIMESTAMP,
    product_id INT,
    amount_spent DECIMAL(10, 2)
);


-- Inserting Values


INSERT INTO purchases (purchase_id, user_id, date_of_purchase, product_id, amount_spent) VALUES
(2171, 145, '2024-02-22 00:00:00', 43001, 1000),
(3022, 578, '2024-02-24 00:00:00', 25852, 4000),
(4933, 145, '2024-02-28 00:00:00', 43001, 7000),
(6322, 248, '2024-02-19 00:00:00', 25852, 2000),
(4717, 578, '2024-02-12 00:00:00', 25852, 7000),
(2172, 145, '2024-01-15 00:00:00', 43001, 8000),
(3023, 578, '2024-01-18 00:00:00', 25852, 3000),
(4934, 145, '2024-01-28 00:00:00', 43001, 9000),
(6323, 248, '2024-02-20 00:00:00', 25852, 1500),
(4718, 578, '2024-02-25 00:00:00', 25852, 6000);



/*
Identify users who have made purchases totaling more than $10,000 in the last month from the purchases table. 
The table contains information about purchases, including the user ID, date of purchase, product ID, and amount spent.
*/


-- Solution


with cte as 
		(select purchase_id, user_id
		, extract(month from date_of_purchase) as mon, product_id, amount_spent
		from purchases
		where extract(month from date_of_purchase) = 2)
select user_id, sum(amount_spent) as total_purchase
from cte
group by user_id
having sum(amount_spent) > 10000;







