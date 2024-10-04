
-- Creating Table


drop table if exists emp;
create table emp (id timestamp, empid int);


-- Inserting Values


insert into emp values 
('2024-01-13 09:25:00', 10)
,('2024-01-13 19:35:00', 10)
,('2024-01-16 09:10:00', 10)
,('2024-01-16 18:10:00', 10)
,('2024-02-11 09:07:00', 10)
,('2024-02-11 19:20:00', 10)
,('2024-02-17 08:40:00', 17)
,('2024-02-17 18:04:00', 17)
,('2024-03-23 09:20:00', 10)
,('2024-03-23 18:30:00', 10);



/*
Find out the number of hours each employees has worked on weekends.
Output
+-------+-------------+
|empid  |working_hours|
+-------+-------------+
|10     |29:33        |
|17     |09:24        |
+-------+-------------+
*/


-- Solution


with cte as 
		(select a.empid, date(a.id), to_char(b.id, 'HH24:MI')::time - to_char(a.id, 'HH24:MI')::time as working_hours
		from emp a
		join emp b on a.empid = b.empid
		and
		date(a.id) = date(b.id)
		and a.id < b.id
		where extract(dow from a.id) = 0 or extract(dow from a.id) = 6)
select empid, sum(working_hours)
from cte 
group by empid;

