
-- Creating Tables


drop table if exists tablea;
create table tablea 
(empid int,
empname varchar(50),
salary int);


drop table if exists tableb;
create table tableb 
(empid int,
empname varchar(50),
salary int);


-- Inserting Values


insert into tablea 
values(1,'AA',1000),
(2,'BB',300);


insert into tableb 
values(2,'BB',400),
(3,'CC',100);



/*
Create a table with the details of all the employees. If an employee is having more than 2 records, find the record with the lowest salary.
*/


-- Solution


select coalesce(a.empid, b.empid)
, coalesce(a.empname, b.empname)
, coalesce(a.salary, b.salary)
from tablea a
full outer join tableb b on a.empid = b.empid
and a.salary < b.salary;


