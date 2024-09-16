drop table if exists transactions;
CREATE TABLE transactions (
    id INT PRIMARY KEY,
    country VARCHAR(255),
    state VARCHAR,
    amount INT,
    trans_date DATE
);

INSERT INTO Transactions (id, country, state, amount, trans_date) VALUES
(121, 'US', 'approved', 1000, '2018-12-18'),
(122, 'US', 'declined', 2000, '2018-12-19'),
(123, 'US', 'approved', 2000, '2019-01-01'),
(124, 'DE', 'approved', 2000, '2019-01-07');


/*
Write an SQL query to find for each month and country, 
the number of transactions and their total amount, 
the number of approved transactions and their total amount.

Return the result table in in below order.RANGE


Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/



select  to_char(trans_date, 'yyyy-mm') as month, country, count(*) as trans_count
, sum(case when state = 'approved' then 1 else 0 end) as approved_count
, sum(amount) as trans_total_amount
, sum(case when state = 'approved' then amount else 0 end ) as approved_total_amount
from transactions
group by country, to_char(trans_date, 'yyyy-mm') 
order by to_char(trans_date, 'yyyy-mm');

