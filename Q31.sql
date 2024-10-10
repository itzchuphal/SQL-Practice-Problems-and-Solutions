
-- Creating Table


drop table if exists employees;
create table employees(
id int,
emp_name varchar(50),
gender varchar(10)
);


-- Inserting Values


insert into employees 
values (1, 'John Doe', 'Male'),
(2, 'Jane Smith', 'Female'),
(3, 'Michael Johnson', 'Male'),
(4, 'Emily Davis', 'Female'),
(5, 'Robert Brown', 'Male'),
(6, 'Sophia Wilson', 'Female'),
(7, 'David Lee', 'Male'),
(8, 'Emma White', 'Female'),
(9, 'James Taylor', 'Male'),
(10, 'William Clark', 'Male');


/*
The employee details are given showing the male and female employees.
What is the percentage distribution of employees based on the gender?
*/


-- Solution


with cte as 
		(select count(1) as total_emp from employees)
select 
round((sum(case when e.gender = 'Male' then 1 end))::decimal/total_emp::decimal*100,0) as male
, round((sum(case when e.gender = 'Female' then 1 end))::decimal/total_emp::decimal*100,0) as female
from employees e
cross join cte 
group by cte.total_emp;



















