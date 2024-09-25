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


with cte as 
		(select *, rank() over(partition by r.constituency_id order by r.votes desc) as rk
		from candidates c
		join results r on c.id = r.candidate_id)
select party, count(1) as seats_won
from cte 
where rk = 1
group by 1;
