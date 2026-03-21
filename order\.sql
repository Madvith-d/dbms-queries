CREATE database orderdb
use orderdb

create table customer(
    cid int not null,
    cname varchar(20),
    city varchar(20),
    primary key(cid)
)

create table orders(
    orderid int not null ,
    odate DATE not null,
    cid int not null,
    oamt int ,
    primary key(orderid),
    foreign key( cid) references customer(cid) on delete cascade on update cascade
)

create table item(
    itemid int not null,
    price int ,
    primary key(itemid)
)
create table orderItem(
    orderid int not null,
    itemid int not null,
    qty int ,
    primary key(orderid , itemid) ,
    foreign key(orderid) references orders(orderid) on delete cascade on update cascade,
    foreign key(itemid) references item(itemid) on delete cascade on update cascade,
)

