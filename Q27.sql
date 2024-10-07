
-- Creating Table


drop table if exists employee;
create table employee (
emp_id int,
dept varchar(50),
scores float
);


-- Inserting Values


insert into employee 
values (1, 'D1', 1.0)
,(2, 'D1', 5.28)
,(3, 'D1', 4.0)
,(4,'D2', 8.0)
,(5, 'D1', 2.5)
,(6, 'D2', 7.0)
,(7, 'D3', 9.0)
,(8, 'D4', 10.2);



/*
The table is having employee id's, their department id's and repsective scores.

Input 

+-------+-------+--------+
|emp_id |dept   |scores  |
+-------+-------+--------+
|1      |D1     |1       |
|2      |D1     |5.28    |
|3      |D1     |4       |
|4      |D2     |8       |
|5      |D1     |2.5     |
|6      |D2     |7       |
|7      |D3     |9       |
|8      |D4     |10.2    |
+-------+-------+--------+


Write a query to update the score of each employee with the highest score of their respective department.

Output

+-------+-------+------------+
|emp_id |dept   |max_scores  |
+-------+-------+------------+
|1      |D1     |5.28        |
|2      |D1     |5.28        |
|3      |D1     |5.28        |
|4      |D2     |8           |
|5      |D1     |5.28        |
|6      |D2     |8           |
|7      |D3     |9           |
|8      |D4     |10.2        |
+-------+-------+------------+

*/


-- Solution


with cte as 
		(select *
		, row_number() over(order by emp_id) as rn
		from employee)
select emp_id, dept, max(scores) over(partition by dept) as max_score
from cte
order by rn;












