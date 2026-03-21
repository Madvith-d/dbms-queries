CREATE database orderdb
use orderdb

create table customer(
    cid int not null,
    cname varchar(20),
    city varchar(20),
    primary key(cid)
)
insert into customer VALUES
(111,'Madvith','Karkala'),
(112,'John','Manipal'),
(113,'Alice','Mangalore');
create table orders(
    orderid int not null ,
    odate DATE not null,
    cid int not null,
    oamt int ,
    primary key(orderid),
    foreign key( cid) references customer(cid) on delete cascade on update cascade
)
INSERT INTO orders VALUES
(100, '2025-01-10', 111, 5000),
(101, '2025-01-12', 112, 3000),
(102, '2025-01-15', 113, 7000),
(103, '2025-01-18', 111, 4500),
(104, '2025-01-20', 112, 6000);
INSERT INTO orders VALUES
(105, '2025-01-22', 113, 8000),
(106, '2025-01-25', 111, 2000),
(107, '2025-01-28', 112, 9000),
(108, '2025-02-01', 113, 3500),
(109, '2025-02-03', 111, 6700);
create table item(
    itemid int not null,
    price int ,
    primary key(itemid)
)

insert into item values
(1,2000),
(2,5000),
(3,6546),
(4,1232),
(5,4234);
create table orderItem(
    orderid int not null,
    itemid int not null,
    qty int ,
    
    foreign key(orderid) references orders(orderid) on delete cascade on update cascade,
    foreign key(itemid) references item(itemid) on delete cascade on update cascade,
)
insert into orderItem values
(100,1,2),
(101,2,1),
(102,3,4),
(103,4,2),
(104,5,3);
INSERT INTO orderItem VALUES
-- Existing pattern extended
(105, 1, 3),
(105, 2, 2),
(106, 3, 4),
(107, 4, 1),
(108, 5, 6),

-- Ensure item repetition across many orders
(106, 1, 2),
(107, 1, 1),
(108, 2, 3),
(109, 3, 2),
(109, 4, 5),

-- VERY IMPORTANT: customer 111 orders ALL items
(100, 1, 2),
(103, 2, 1),
(106, 3, 4),
(109, 4, 2),
(100, 5, 1);
create table warehouse(
    warehouseid int not null,
    city varchar(20),
    primary key(warehouseid),
)
INSERT INTO warehouse VALUES
(1, 'Bangalore'),
(2, 'Mangalore');
INSERT INTO warehouse VALUES
(3, 'Udupi'),
(4, 'Mumbai');
create table shipment(
    orderid int not null,
    warehouseid int not null,
    shipdate date ,
    foreign key(orderid) references orders(orderid) on delete cascade on update cascade,
    foreign key(warehouseid) references warehouse(warehouseid) on delete cascade on update cascade,
)
INSERT INTO shipment VALUES
(100, 1, '2025-01-11'),
(101, 2, '2025-01-13'),
(102, 1, '2025-01-16');
INSERT INTO shipment VALUES
(103, 2, '2025-01-19'),
(104, 1, '2025-01-21'),
(105, 3, '2025-01-23'),
(106, 2, '2025-01-26'),
(107, 4, '2025-01-29'),
(108, 1, '2025-02-02'),
(109, 3, '2025-02-04');
--Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle
--column is the total numbers of orders by the customer and the last column is the
--average order amount for that customer.
select c.cname as CUSTNAME , count(o.orderid) as NO_OF_ORDERS , avg(o.oamt) from customer c ,orders o where c.cid = o.cid  group by c.cname

-- For each item that has more than two orders , list the item, number of orders that are
--shipped from atleast two warehouses and total quantity of items shipped

select oi.itemid , count(distinct oi.orderid) , sum(oi.qty) from orderItem oi where oi.orderid in (
    select orderid from shipment group by orderid having count(distinct(warehouseid) ) >= 2 
) group by oi.itemid HAVING COUNT(distinct (oi.orderId) ) >2


SELECT 
    oi.itemid,
    COUNT(DISTINCT oi.orderid) AS num_orders,
    SUM(oi.qty) AS total_qty
FROM orderItem oi
WHERE oi.orderid IN (
    SELECT orderid
    FROM shipment
    GROUP BY orderid
    HAVING COUNT(DISTINCT warehouseid) >= 2
)
GROUP BY oi.itemid
HAVING COUNT(DISTINCT oi.orderid) > 2;

--List the customers who have ordered for every item that the company produces
select c.cname from customer c where c.cid in (
    select o.cid 
    from
    orders o , orderItem oi 
    where o.orderId = oi.orderId
    group by o.cid 
    having count(distinct oi.itemid) = (select count(*) from item)
)