-- Problem Statement

/*A pizza company is taking orders from customers, and each pizza ordered is added to their database as a separate order. Each order has an associated status,
'CREATED' or 'SUBMITTED' or 'DELIVERED'. An order's final status is calculated based on status as follows:

1. When all orders are in DELIVERED status then the final status is COMPLETED
2. When one or more orders for a customer is DELIVERED and one or more orders are CREATED or SUBMITTED then the final status is IN PROGRESS
3. When one or more orders of a customer are SUBMITTED and none are DELIVERED then the final status is AWAITING PROGRESS
4. Otherwise the final status is AWAITING SUBMISSION*/


--Write a query to fetch the customer_name and final_status of each customer's order. Order the results by customer name.


-- Creating Table


create table cust_orders
(
cust_name   varchar(50),
order_id    varchar(10),
status      varchar(50)
);


-- Inserting Values


insert into cust_orders values ('John', 'J1', 'DELIVERED');
insert into cust_orders values ('John', 'J2', 'DELIVERED');
insert into cust_orders values ('David', 'D1', 'SUBMITTED');
insert into cust_orders values ('David', 'D2', 'DELIVERED'); 
insert into cust_orders values ('David', 'D3', 'CREATED');
insert into cust_orders values ('Smith', 'S1', 'SUBMITTED');
insert into cust_orders values ('Krish', 'K1', 'CREATED');


-- Solution


select distinct cust_name, 'COMPLETED' as final_status
from cust_orders a
where a.status = 'DELIVERED'
and
not exists (select *
            from cust_orders b
            where a.cust_name = b.cust_name
			and b.status in ('CREATED', 'SUBMITTED'))
			
union

select distinct cust_name, 'IN PROGRESS' as final_status
from cust_orders a
where a.status = 'DELIVERED'
and 
exists (select * 
        from cust_orders b
		where a.cust_name = b.cust_name
		and b.status in ( 'CREATED', 'SUBMITTED'))

union

select distinct cust_name, 'AWAITING PROGRESS' as final_status
from cust_orders a
where a.status = 'SUBMITTED'
and 
not exists (select * 
  			from cust_orders b 
			where a.cust_name = b.cust_name
		    and b.status in ('DELIVERED'))
			
union

select distinct cust_name, 'AWAITING SUBMISSION' as final_status
from cust_orders a
where a.status = 'CREATED'
and 
not exists (select
			from cust_orders b
			where a.cust_name = b.cust_name
			and b.status in ('DELIVERED', 'SUBMITTED'))
order by cust_name;
