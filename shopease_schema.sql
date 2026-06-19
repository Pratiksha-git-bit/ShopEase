-- ShopEase E-commerce Database
-- Author : Pratiksha
-- Description : Schema and sample data for ShopEase checkout optimization project

Create Database Shopease;
use shopease;
create table customer(customer_id INT primary key , name varchar (100), email varchar (100) , phone varchar (10) , city varchar (50), created_at date);
create table product (product_id INT primary key , category varchar(20) ,name varchar(50) ,  price decimal(10,2) , stock INT);
create table orders(order_ID INT primary key, customer_ID INT , total decimal (10,2) , order_date Date); 
select * from customer;
select * from product;
select * from orders;
Insert into customer values(1 , 'Rahul', 'rahul001@gmail.com', '9000599846' , 'Ahemdabad' , '2026-05-16') ; 
Insert into customer values(2 , 'Priya' , 'priya11@gmail.com' , '7599438290' , 'Hyderabad' , '2026-05-17') , (3 , 'Aman' , 'amansingh@gmail.com' , '9988773218' , 'Bangalore' , '2026-05-18') , (4 , 'Sneha' , 'sneha@gmail.com' , '6334578906' , 'Pune' , '2026-05-19');
insert into product values(101 , 'electronics' , 'IPhone 17 pro' , 110000.00, 5) , (102 , 'electronics' , 'bluetooth headphones', 899 , 50), (103 , 'furniture' , 'office chair' , 2999 , 10);
insert into product values(104 , 'home decor' , 'bed cover' , 1999.00 , 55) , (105 , 'furniture' , 'office chair' , 2999 , 9) , (106 , 'footwear' , 'women heel' , 899 , 25);
update product
 set category= 'furniture' ,
 name = 'office chair'
 where product_id = 103;
 update product
 set name = 'watch'
 where product_id = 105;
 update product
 set category = 'apparel'
 where product_id = 105;

 insert into orders values (1001, 1 , 110000.00 , '2026-05-16') , (1002 , 1 , 899.00 , '2026-05-17') , (1003 , 1 , 2999.00 , '2026-05-18');
 insert into orders values (1004 , 2 , 1999.00 , '2026-05-19') , (1005 , 3 , 2999.00 , '2026-05-20') , (1006 , 4 , 899.00 , '2026-05-21');
create table orders_item(orders_item_ID INT primary key , order_ID INT , Product_ID INT ,quantity INT);
insert into orders_item values (10001 , 1001 , 101 , 1) , (10002 , 1002 , 102 , 2) , (10003 , 1003 , 103 , 1);
insert into orders_item values (10004 , 1004 , 104 , 1) , (10005 , 1005 , 105 , 2) , (10006 , 1006 , 106 , 1);
select * from orders_item;
create table payment(payment_ID INT primary key , order_id INT , payment_method varchar(50) , transaction_status varchar(30), payment_date Date);
insert into payment values (0001 , 1001 , 'UPI' , 'Successful' , '2026-05-16') , (0002 , 1002 , 'credit card' , 'successful' , '2026-05-17') , (0003 , 1003 , 'netbanking' , 'pending' , '2026-05-18');
insert into payment values (0004 , 1004 , 'netbanking' , 'pending' , '2026-05-19') , (0005 , 1005 , 'credit card' , 'failed' , '2026-05-20') , (0006 , 1006 , 'UPI' , 'Successful' , '2026-05-21');
set sql_safe_updates = 0;
update payment
set transaction_status = 'Successful'
where transaction_status = 'successful';
set sql_safe_updates = 1;
select * from payment;
select transaction_status,
count(*) as total_transactions
from payment
group by (transaction_status);
select payment_method,
count(*) as failed_transactions
from payment
where transaction_status = 'failed'
group by payment_method;
create table cart(cart_ID INT primary key , customer_id INT , product_ID INT , quantity INT);
insert into cart values (11 , 1 , 101 , 1) , (12 , 1 , 102 , 2) , (13 , 1 , 103 , 1);
insert into cart values (14 , 2 , 104 , 1) , (15 , 3 , 105 , 2) , (16 , 4 , 106 , 1);
SELECT * FROM CART;
create table review(review_ID INT , customer_ID INT , product_id INT , review_rating decimal (2,1) , feedback varchar (100));
insert into review values (110 , 1 , 101 , 5 , 'very good camera') , (111 , 1 , 102 , 4.5 , 'value for money') , (111 , 1 , 103 , 4.7 , 'very comfortable');
insert into review (review_ID , customer_ID , product_id , review_rating , feedback)
values
(113 , 2 , 103 , null , null),
(114 , 3 , 104 , null , null),
(115 , 4 , 105 , 4.7 , 'very stylish');
desc review;
alter table review
modify review_rating decimal(2,1);
set sql_safe_updates = 0;
update review
set review_rating = 4.5
where review_id = 111;
set sql_safe_updates = 1;
create table review_backup as
select * from review;
alter table review add column row_id int auto_increment primary key;
set sql_safe_updates = 0 ;
delete r1
from review r1
inner join review r2
on r1.review_id = r2.review_id
and r1.customer_id = r2.customer_id
and r1.product_id = r2.product_id
and r1.row_id > r2.row_id;
set sql_safe_updates = 1;
set sql_safe_updates = 0;
delete from review
where row_id = 6;
set sql_safe_updates = 1;
set sql_safe_updates = 0;
update review
set feedback= 'average product quality'
where review_id = 112;
set sql_safe_updates = 1;
select c.name ,
o.order_id,
o.order_date
from customer c
join orders o
on c.customer_id = o.customer_id;
select c.name,
p.name,
oi.quantity,
o.order_date
from customer c
join orders o
on c.customer_id = o.customer_id
join orders_item oi
on o.order_id = oi.order_id
join product p
on oi.product_id =  p.product_id;
select c.name,
o.order_id
from customer c
left join orders o
on c.customer_id = o.customer_id;
select c.name,
o.order_id,
o.order_date,
o.total
from customer c
join orders o
on c.customer_id = o.customer_id;
select name,
category,
price
from product;
select
sum(oi.quantity * p.price ) AS total_revenue
from orders_item oi
join product p
on oi.product_id = p.product_id;
select p.name,
sum(oi.quantity) as total_sold
from orders_item oi
join product p
on oi.product_id = p.product_id
group by p.name
order by total_sold desc;
