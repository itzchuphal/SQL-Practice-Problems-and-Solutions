
-- Leetcode problem LeetCode SQL Premium Problem 2853: 'Highest Salary Difference'


-- DDL for Salaries table
CREATE TABLE Salaries (
emp_name VARCHAR(50),
department VARCHAR(50),
salary INT,
PRIMARY KEY (emp_name, department)
);

-- DML for Salaries table
INSERT INTO 
Salaries (emp_name, department, salary) 
VALUES
          ('Kathy', 'Engineering', 50000),
          ('Roy', 'Marketing', 30000),
          ('Charles', 'Engineering', 45000),
          ('Jack', 'Engineering', 85000),
          ('Benjamin', 'Marketing', 34000),
          ('Anthony', 'Marketing', 42000),
          ('Edward', 'Engineering', 102000),
          ('Terry', 'Engineering', 44000),
          ('Evelyn', 'Marketing', 53000),
          ('Arthur', 'Engineering', 32000);



/*
Write an SQL query to calculate the difference 
between the highest salaries 
in the marketing and engineering department. 
Output the absolute difference in salaries.
*/

-- Solution 

with cte as
		(select *
		, rank() over(partition by department order by salary desc) as rnk
		from salaries),
     cte_2 as
		(select * 
		from cte
		where rnk = 1)
select abs(max(salary) - min(salary)) as difference
from cte_2;
