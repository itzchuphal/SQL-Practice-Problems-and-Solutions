
-- Creating Table 

drop table if exists employees;
create table employees(
emp_id int,
emp_name varchar(50),
salary int,
manager_id int);



-- Inserting Values


insert into employees 
values (1, 'John', 50000, null),
(2, 'Alice', 40000, 1),
(3, 'Bob', 70000, 1),
(4, 'Emily', 55000, null),
(5, 'Charlie', 65000, 4),
(6, 'David', 50000, 4);



/*
From the given employees table, provide the names of all the employees whose salary is greater than their manager's salary.
*/


-- Solution


select e.emp_name--, e.salary, m.emp_name as mngr_name, m.salary
from employees e
left join employees m on e.manager_id = m.emp_id
where e.salary > m.salary;












