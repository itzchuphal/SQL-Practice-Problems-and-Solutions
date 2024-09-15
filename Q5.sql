
/* Find the popularity percentage for each user on Meta/Facebook.
The popularity percentage is defined as the total number of friends the user has divided by the
total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
*/


-- Creating Table


create table facebook_friends
    (
        user1       int,
        user2       int
    );


-- Inserting Values


insert into facebook_friends values (2,1);
insert into facebook_friends values (1,3);
insert into facebook_friends values (4,1);
insert into facebook_friends values (1,5);
insert into facebook_friends values (1,6);
insert into facebook_friends values (2,6);
insert into facebook_friends values (7,2);
insert into facebook_friends values (8,3);
insert into facebook_friends values (3,9);



-- Solution


with cte as 
		(select user1
		from facebook_friends
		union all
		select user2
		from facebook_friends),
	 total_users as
		(select count(distinct user1) as total_user
		from cte),
	 total_friends as 
		(select user1, count(1) as total_friends
		from cte
		group by user1
		order by user1 asc)
select *
, round((tf.total_friends::decimal/tu.total_user::decimal)*100,2) as popularity_percentage
from total_friends tf  
cross join total_users tu;
