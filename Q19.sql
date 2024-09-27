
-- Creating Table

drop table if exists sales;
create table sales
(month varchar(50),
ytd_sales int,
monthnum int);


-- Inserting Values
insert into sales 
values('jan',15,1),
('feb',22,2),
('mar',35,3),
('apr',45,4),
('may',60,5);



/*
Find the increase in sales for each month with respect to the previous month. 
If there is no previous month, consider it's previous month sale as 0.
*/


-- Solution


with cte as 
		(select *
		, lag(ytd_sales,1,0) over() as prev_month
		from sales)
select month, ytd_sales, ytd_sales - prev_month
from cte;










