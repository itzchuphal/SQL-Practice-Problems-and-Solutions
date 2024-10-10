
-- Creating Table 


drop table if exists exchange_rates;
create table exchange_rates (
currency_code varchar(3),
date date,
currency_exchange_rate decimal(10, 2)
);



-- Inserting Values



insert into exchange_rates 
values ('USD', '2024-06-01', 1.20),
('USD', '2024-06-02', 1.21),
('USD', '2024-06-03', 1.22),
('USD', '2024-06-04', 1.23),
('USD', '2024-07-01', 1.25),
('USD', '2024-07-02', 1.26),
('USD', '2024-07-03', 1.27),
('EUR', '2024-06-01', 1.40),
('EUR', '2024-06-02', 1.41),
('EUR', '2024-06-03', 1.42),
('EUR', '2024-06-04', 1.43),
('EUR', '2024-07-01', 1.45),
('EUR', '2024-07-02', 1.46),
('EUR', '2024-07-03', 1.47);



/*
The given table contains currency exchange rate on different dates.
From the given table, write a query to fetch the currency exchange rate 
on the beginning and end of all the months.

Input 

+--------------+--------------+------------------------+
|currency_code | date         | currency_exchange_rate |
+--------------+--------------+------------------------+
|USD           | 2024-06-01   | 1.20                   |
|USD           | 2024-06-02   | 1.21                   |
|USD           | 2024-06-03   | 1.22                   |
|USD           | 2024-06-04   | 1.23                   |
|USD           | 2024-07-01   | 1.25                   |
|USD           | 2024-07-02   | 1.26                   |
|USD           | 2024-07-03   | 1.27                   |
|EUR           | 2024-06-01   | 1.40                   |
|EUR           | 2024-06-02   | 1.41                   |
|EUR           | 2024-06-03   | 1.42                   |
|EUR           | 2024-06-04   | 1.43                   |
|EUR           | 2024-07-01   | 1.45                   |
|EUR           | 2024-07-02   | 1.46                   |
|EUR           | 2024-07-03   | 1.47                   |
+--------------+--------------+------------------------+


Output

+--------------+---------------------------------------+----------------------------------+
|currency_code |currency_exchage_rate_beginningofmonth |currency_exchage_rate_end_of_month|
+--------------+---------------------------------------+----------------------------------+
|EUR_2024_06   |1.40                                   |1.43                              |
|EUR_2024_07   |1.45                                   |1.47                              |
|USD_2024_06   |1.20                                   |1.23                              |
|USD_2024_06   |1.25                                   |1.27                              |
+--------------+---------------------------------------+----------------------------------+

*/


-- Solution


with cte as 
		(select *, to_char(date, 'yyyy_mm') as dt
		, rank() over(partition by currency_code, extract (month from date)  order by date ) as rk
		, rank() over(partition by currency_code, extract (month from date)  order by date desc ) as rnk  
		from exchange_rates)
select currency_code||'_'||dt as currency_code
, max(case when rk = 1 then currency_exchange_rate end) as currency_exchage_rate_beginningofmonth
, max(case when rnk = 1 then currency_exchange_rate end) as currency_exchage_rate_end_of_month
from cte
where rk = 1
or rnk = 1
group by 1;
 









