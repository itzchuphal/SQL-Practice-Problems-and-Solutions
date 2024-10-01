
-- Creating Table


drop table if exists brands;
create table brands 
(category varchar(50),
brand_name varchar(50)
);


-- Inserting Values


insert into brands values 
('chocolates', '5-star'),
(NULL, 'kitkat'),
(NULL, 'perk'),
(NULL, 'munch'),
('Biscuits', 'britania'),
(NULL, 'good day'),
(NULL, 'sunfeast');



/*
Input
+----------+---------+-----------+
| category    | brand_name       | 
+-------------+------------------+
| chocolates  | 5-star           |    
| null        | kitkat           |    
| null        | perk             |    
| null        | munch            |    
| biscuits    | britania         |    
| null        | good day         |    
| null        | sunfeast         |    
+-------------+------------------+


Output
+-------------+------------------+
| category    | brand_name       | 
+-------------+------------------+
| chocolates  | 5-star           |    
| chocolates  | dairy milk       |    
| chocolates  | perk             |    
| chocolates  | eclair           |    
| biscuits    | britania         |    
| biscuits    | good day         |    
| biscuits    | boost            |    
+-------------+------------------+
*/


-- Solution


with cte as 
		(select *
		, row_number() over(order by (select null)) as rn
		from brands),
     cte2 as 
	     (select *, count(category) over(order by rn) as countt
	     from cte)
select first_value(category) over(partition by countt) as category, brand_name
from cte2;


