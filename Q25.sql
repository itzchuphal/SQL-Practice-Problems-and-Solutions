
-- Creating Table

drop table if exists table1;
create table table1 (
 col1 varchar(50),
 col2 int, col3 int
 );


-- Inserting Values

insert into table1 values 
('a',10,20)
,('b',50,30);



/*
Input table

+-----+------+------+
|col1 | col2 | col3 |
+-----+------+------+
|a    | 10   | 20   |
|b    | 50   | 30   |
+-----+------+------+

From the above table, write a query to find the max value of each record present in col1.

Output Table

+-----+-----------+
|col1 | max_value |
+-----+-----------+
|a    | 20        |
|b    | 50        |
+-----+-----------+

*/


-- Solution

select col1
, case when col2 > col3 then col2 else col3 
  end as max_value
from table1;
