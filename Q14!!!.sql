-- Creating Table


drop table if exists candidates;
create table candidates
(
    id      int,
    gender  varchar(1),
    age     int,
    party   varchar(20)
);


drop table if exists results;
create table results
(
    constituency_id     int,
    candidate_id        int,
    votes               int
);


-- Inserting Values


insert into candidates values(1,'M',55,'Democratic');
insert into candidates values(2,'M',51,'Democratic');
insert into candidates values(3,'F',62,'Democratic');
insert into candidates values(4,'M',60,'Republic');
insert into candidates values(5,'F',61,'Republic');
insert into candidates values(6,'F',58,'Republic');



insert into results values(1,1,847529);
insert into results values(1,4,283409);
insert into results values(2,2,293841);
insert into results values(2,5,394385);
insert into results values(3,3,429084);
insert into results values(3,6,303890);



/*
Given a database of the results of an election, find the number of seats won by each party. There are some rules to going about this:
-There are many constituencies in a state and many candidates who are contesting the election from each constituency.
-Each candidate belongs to a party.
-The candidates with the maximum number of votes in a given constituency wins for that constituency.
The output should consist of 2 columns:- party, seats_won
The ordering should be in the order of seats won in descending order.
*/


select * from candidates;
select * from results;


-- In the final result, we want party and the number of seats won. In order to come to that, first we need to get a table 
-- having the votes of each party in each constituency. We can join the 2 tables and fetch 'party', 'constituency_id', 'votes'
-- from the resultset of the join.


select c.party, r.constituency_id, r.votes
from candidates c
join results r on c.id = r.candidate_id;


-- As we have got the required resultset, I would like to make it as a new table to keep the query easy to understand.


create table t1 as 
select c.party, r.constituency_id, r.votes
from candidates c
join results r on c.id = r.candidate_id;


-- New table t1 created with the required resultset

select * from t1;


-- Now, we have arrived at the final stage. We have to compare the votes of each party in each constituency, so we need the constituency in column and the distinct 
-- parties in different columns and their votes in the respective rows. This will help us to easily compare the votes received by the two parties.
-- In order to get the table in above mentioned format, we will have to use the CROSSTAB(as I am using PostgreSQL). CROSSTAB is part of a PostgreSQL 
-- extension called "tablefunc". To call the crosstab function, you must first enable the tablefunc extension by executing the following SQL command


create extension tablefunc;


--Base Query for CROSSTAB

select constituency_id, party, max(votes) as votes
from t1
group by 1,2
order by 1,2



-- Columns to be fetched in the result

select distinct party from t1;



-- Using CROSSTAB


select * 
		from crosstab('select constituency_id, party, max(votes)
						from t1
						group by 1,2
						order by 1,2', 'select distinct party from t1')
		as (constituency_id int, Democratic  varchar, Republic varchar)



-- As we have got the format that we wanted, now we can use it to get to our final output
			   

with cte as 
		(select * 
		from crosstab('select constituency_id, party, max(votes)
						from t1
						group by 1,2
						order by 1,2', 'select distinct party from t1')
		as (constituency_id int, Democratic  varchar, Republic varchar)
		),
	 final_tab as 
	    (select *
		, case when democratic::int > republic::int then 'Democratic' else 'Republic' end as party
		from cte)
select party, count(1) as seats_won
from final_tab
group by party;



