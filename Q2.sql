-- Highest Cost Orders
/*
Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01.
If customer had more than one order on a certain day, sum the order costs on daily basis.
Output their first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique
*/


-- Creating Table 

create table customers
    (
        id              int,
        first_name      varchar(50),
        last_name       varchar(50),
        city            varchar(50),
        address         varchar(200),
        phone_number    varchar(50)
    );

create table orders
    (
        id                  int,
        cust_id             int,
        order_date          date,
        order_details       varchar(50),
        total_order_cost    int
    );


-- Inserting Values


insert into customers values (8,'John','Joseph','San Francisco' ,NULL,'928-386-8164');
insert into customers values (7,'Jill','Michael','Austin' ,NULL,'813-297-0692');
insert into customers values (4,'William','Daniel','Denver' ,NULL,'813-368-1200');
insert into customers values (5,'Henry','Jackson','Miami' ,NULL,'808-601-7513');
insert into customers values (13,'Emma','Isaac','Miami' ,NULL,'808-690-5201');
insert into customers values (14,'Liam','Samuel','Miami' ,NULL,'808-555-5201');
insert into customers values (15,'Mia','Owen','Miami' ,NULL,'808-640-5201');
insert into customers values (1,'Mark','Thomas','Arizona','4476 Parkway Drive','602-993-5916');
insert into customers values (12,'Eva','Lucas','Arizona','4379 Skips Lane','301-509-8805');
insert into customers values (6,'Jack','Aiden','Arizona','4833 Coplin Avenue','480-303-1527');
insert into customers values (2,'Mona','Adrian','Los Angeles','1958 Peck Court','714-409-9432');
insert into customers values (10,'Lili','Oliver','Los Angeles','3832 Euclid Avenue','530-695-1180');
insert into customers values (3,'Farida','Joseph','San Francisco','3153 Rhapsody Street','813-368-1200');
insert into customers values (9,'Justin','Alexander','Denver','4470 McKinley Avenue','970-433-7589');
insert into customers values (11,'Frank','Jacob','Miami','1299 Randall Drive','808-590-5201');


insert into orders values (1,3,'2019-03-04','Coat',100);
insert into orders values (2,3,'2019-03-01','Shoes',80);
insert into orders values (3,3,'2019-03-07','Skirt',30);
insert into orders values (4,7,'2019-02-01','Coat',25);
insert into orders values (5,7,'2019-03-10','Shoes',80);
insert into orders values (6,15,'2019-02-01','Boats',100);
insert into orders values (7,15,'2019-01-11','Shirts',60);
insert into orders values (8,15,'2019-03-11','Slipper',20);
insert into orders values (9,15,'2019-03-01','Jeans',80);
insert into orders values (10,15,'2019-03-09','Shirts',50);
insert into orders values (11,5,'2019-02-01','Shoes',80);
insert into orders values (12,12,'2019-01-11','Shirts',60);
insert into orders values (13,12,'2019-03-11','Slipper',20);
insert into orders values (14,4,'2019-02-01','Shoes',80);
insert into orders values (15,4,'2019-01-11','Shirts',60);
insert into orders values (16,3,'2019-04-19','Shirts',50);
insert into orders values (17,7,'2019-04-19','Suit',150);
insert into orders values (18,15,'2019-04-19','Skirt',30);
insert into orders values (19,15,'2019-04-20','Dresses',200);
insert into orders values (20,12,'2019-01-11','Coat',125);
insert into orders values (21,7,'2019-04-01','Suit',50);
insert into orders values (22,7,'2019-04-02','Skirt',30);
insert into orders values (23,7,'2019-04-03','Dresses',50);
insert into orders values (24,7,'2019-04-04','Coat',25);
insert into orders values (25,7,'2019-04-19','Coat',125);


-- Solution


with cte as 
		(select c.id, c.first_name, o.order_date, sum(total_order_cost) as total_cost
		, rank() over(order by sum(total_order_cost) desc) as rnk
		from customers c
		join orders o on c.id = o.cust_id
		where order_date between '2019-02-01' and '2019-05-01'
		group by c.id, o.order_date, c.first_name)
select first_name, order_date, total_cost
from cte
where rnk = 1;
