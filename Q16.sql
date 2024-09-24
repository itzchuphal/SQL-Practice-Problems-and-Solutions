-- Creating Table


drop table if exists employees;
create table employees (id int);


-- Inserting Table

insert into employees 
values (2)
,(5)
,(6)
,(6)
,(7)
,(8)
,(8);


/*
Find the max of id which does not have an duplicate record.
*/


-- Solution


select max(id) from employees
where id in(
			select id
			from employees
			group by id
			having count(1) < 2);
