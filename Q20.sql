
-- Creating Table


drop table if exists cinema;
create table cinema
(seat_id int,
vacant int);


-- Inserting Values


insert into cinema 
values (1,1),
(2,0),
(3,1),
(4,0),
(5,1),
(6,1),
(7,1),
(8,0),
(9,1),
(10,1);



/*
Given is a table showing seat_id of a movie theatre and if they are vacant or not.
A seat is considered available, when either it's immediate previous seat or immediate next is also vacant with it.
Find out the available number of seats in the theatre.
*/


-- Solution

with cte as 
		(select *
		, lag(vacant, 1, 0) over() as prev
		, lead(vacant, 1, 0) over() as nxt
		from cinema)
select seat_id
from cte 
where vacant = 1
and (prev = 1
     or 
	 nxt = 1);








