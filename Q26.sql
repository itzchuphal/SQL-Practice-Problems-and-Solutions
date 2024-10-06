
-- Creating Table


drop table if exists sales;
create table sales (
dt date,
sale int
);



-- Inserting Values


insert into sales 
values ('2023-10-03', 10)
,('2023-10-04', 20)
,('2023-10-05', 60)
,('2023-10-06', 50)
,('2023-10-07', 10);


/*
Above table shows the sale for given days. 
Write a query to retrieve the percentage_variance in comparison with the previous day.

Input Table

+-----------+------+
|dt         |sales |
+-----------+------+
|2023-10-03 | 10   |
|2023-10-04 | 20   |
|2023-10-05 | 60   |
|2023-10-06 | 50   |
|2023-10-07 | 10   |
+-----------+------+

Output

+-----------+------+-----------+
|dt         |sales | %variance |
+-----------+------+-----------+
|2023-10-03 | 10   |    0      |
|2023-10-04 | 20   |   100     |
|2023-10-05 | 60   |   200     |
+-----------+------+-----------+

*/


-- Solution


with cte as 
		(select *
		, lag(sale) over(order by dt) as prev_day
		from sales),
	 cte2 as
	 	(select dt, sale, coalesce(round((sale-prev_day)::decimal/prev_day*100,0),0) as variance
		from cte)
select * 
from cte2
where variance >= 0;




