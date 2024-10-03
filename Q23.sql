
-- Creating Table


drop table if exists candidates_tab;
create table candidates_tab
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);



drop table if exists results_tab;
create table results_tab
(
    candidate_id    int,
    state           varchar(50)
);



-- Inserting Values


insert into candidates_tab values(1, 'Davide', 'Kentish');
insert into candidates_tab values(2, 'Thorstein', 'Bridge');



insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'Alabama');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(1, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'New York');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');
insert into results_tab values(2, 'Texas');

insert into results_tab values(1, 'New York');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(1, 'Texas');
insert into results_tab values(2, 'California');
insert into results_tab values(2, 'Alabama');


/*
+------------------+---------------------------+-----------------+-----------+
|candidate_name    |1st place                  |2nd place        |3rd place  |
+------------------+---------------------------+-----------------+-----------+
|Davide Kentish    |California(5)              |Texas(3)         |Alabama(2) |
|Thorstein Bridge  |California(3), Texas(3)    |New York(2)      |Alabama(1) |
+------------------+---------------------------+-----------------+-----------+


Concatenate the candidate's first_name and last_name with a space between them.
1st place, 2nd place, 3rd place are comma_separated US state names and numbers of votes in a format New York(23)
*/



-- Solution



with cte as 
		(select c.first_name||' '||last_name as candidate_name, r.state, count(1) as cnt
		, dense_rank() over(partition by c.first_name||' '||last_name order by count(1) desc ) as rk
		from candidates_tab c
		join results_tab r on c.id = r.candidate_id
		group by 1,2
		order by 2)
select candidate_name
, string_agg(case when rk = 1 then state||'('||cnt||')' end, ',' ) as "1st_place"
, string_agg(case when rk = 2 then state||'('||cnt||')' end, ',' ) as "2nd_place"
, string_agg(case when rk = 3 then state||'('||cnt||')' end, ',' ) as "3rd_place"
from cte
where rk < 4
group by 1;






