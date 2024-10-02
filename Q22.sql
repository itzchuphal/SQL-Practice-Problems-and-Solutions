
-- Creating Table


drop table if exists customers;
create table customers
(
    id          int,
    first_name  varchar(50),
    last_name   varchar(50)
);



drop table if exists campaigns;
create table campaigns
(
    id          int,
    customer_id int,
    name        varchar(50)
);



drop table if exists events;
create table events
(
    campaign_id int,
    status      varchar(50)
);



-- Inserting Values


insert into customers values(1, 'Carolyn', 'O''Lunny');
insert into customers values(2, 'Matteo', 'Husthwaite');
insert into customers values(3, 'Melessa', 'Rowesby');



insert into campaigns values(2, 1, 'Overcoming Challenges');
insert into campaigns values(4, 1, 'Business Rules');
insert into campaigns values(3, 2, 'YUI');
insert into campaigns values(1, 3, 'Quantitative Finance');
insert into campaigns values(5, 3, 'MMC');



insert into events values(1, 'success');
insert into events values(1, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(2, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(3, 'success');
insert into events values(4, 'success');
insert into events values(4, 'success');
insert into events values(4, 'failure');
insert into events values(4, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');
insert into events values(5, 'failure');

insert into events values(4, 'success');
insert into events values(5, 'success');
insert into events values(5, 'success');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(1, 'failure');
insert into events values(2, 'failure');
insert into events values(3, 'failure');

select * from customers;
select * from campaigns;
select * from events;



/*
There should be exactly two rows that contain type, customer, campaign, total
- type contains success in the first row and failure in the second. These relate to events.status
- customer is the customer.first_name and customer.last_name separated by a single space
- campaign is a comma-separated list  of campaigns.name that are associated with the customer,ordered ascending
- total is the number of associated events.


+--------------+-------------------+---------------------------------------+-----------+
|event_type    |customer           |campaign                               |total      |
+--------------+-------------------+---------------------------------------+-----------+
|success       |Carolyn O'Lunny    |Business Rules, Overcoming Challenges  |8          |
|failure       |Melessa Rowesby    |MMC, Quantitative Finance              |9          |
+--------------+-------------------+---------------------------------------+-----------+
*/


-- Solution


with cte as 
		(select e.status, c.first_name||' '||last_name as customer_name, array_agg(distinct ca.name) as campaign_name, count(1) total
		, rank() over(partition by e.status order by count(1) desc) as rk
		from customers c
		join campaigns ca on c.id = ca.customer_id
		join events e on ca.id = e.campaign_id
		group by e.status, c.first_name||' '||last_name)
select status, customer_name, array_to_string(campaign_name, ',') as campaign_name, total
from cte 
where rk = 1
order by 1 desc;






