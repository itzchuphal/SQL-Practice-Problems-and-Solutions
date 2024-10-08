
-- Creating Tables


drop table if exists employees;
create table employees(
id int,
name varchar(50),
salary int,
dept_id int
);



drop table if exists department;
create table department (
id int,
name varchar(50)
);



-- Inserting Values


insert into employees 
values (1,'Nikitha',45000,206),
(2,'Ashish',42000,207),
(3,'David',40000,206),
(4,'Ram',50000,207),
(5,'John',35000,208),
(6,'Mark',50000,207),
(7,'Aravind',39000,208);



insert into department 
values (206,'HR'),
(207,'IT'),
(208,'Finance');


/*
Given are 2 tables employees and department. 
Write a query which shows the employee with the highest salary in each department.
*/


-- Solution


with cte as 
		(select e.name as emp_name, d.name as dept_name
		, rank() over(partition by d.name order by e.salary desc) as rk
		from employees e
		join department d on e.dept_id = d.id)
select dept_name, string_agg(emp_name, ', ')
from cte 
where rk = 1
group by dept_name;
















