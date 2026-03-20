create database insurance
use insurance

create table person(
    driverid varchar(20) ,
    dname varchar(20),
    address varchar(20),
    primary key(driverid)
)
insert into person VALUES
('111','madvith','fwfwf'),
('112','nigga','fsfsf'),
('113','joginder','eewfwef'),
('114','chomu','fwfwf')


create table car(
    regno varchar(20),
    model varchar(20),
    cyear int , 
    primary key(regno)
)
insert into car values
('KA01AB1234','Honda City',2018),
('KA02CD5678','Hyundai i20',2020),
('KA03EF9012','Toyota Innova',2017),
('KA04GH3456','Maruti Swift',2022),
('KA05IJ7890','Tata Nexon',2021),
('KA06KL1122','Mahindra Thar',2019),
('KA07MN3344','Kia Seltos',2023);
SELECT * FROM car

create table accident(
    reportno int primary key,
    accdate date,
    alocation varchar(20)
);
insert into accident values
(1001,'2018-01-15','Bangalore'),
(1002,'2019-03-22','Mysore'),
(1003,'2020-07-10','Mangalore'),
(1004,'2021-11-05','Hubli'),
(1005,'2022-06-18','Belgaum'),
(1006,'2023-09-27','Tumkur'),
(1007,'2024-12-14','Udupi');
create table owns(
    driverid varchar(20),
    regno varchar(20),
    primary key(driverid , regno),
    foreign key (driverid) references person(driverid) on delete cascade on update cascade,
    foreign key (regno) references car(regno) on delete cascade on update cascade
)
insert into owns values
('111','KA01AB1234'),
('111','KA02CD5678'),
('112','KA03EF9012'),
('113','KA04GH3456'),
('113','KA05IJ7890'),
('114','KA06KL1122'),
('114','KA07MN3344');
create table participated(
    driverid varchar(20),
    regno varchar(20),
    reportno int,
    dmgamt int,
    primary key(driverid , regno , reportno),
    foreign key(driverid) references person(driverid) on delete cascade on update cascade ,
    foreign key(regno) references car(regno) on delete cascade on update cascade ,
    foreign key(reportno) references accident(reportno) on delete cascade on update cascade ,
    foreign key(driverid , regno) references owns(driverid , regno) on delete no action on update no action 
)

insert into participated values
('111','KA01AB1234',1001,5000),
('111','KA02CD5678',1002,3000),
('112','KA03EF9012',1003,7000),
('113','KA04GH3456',1004,2000),
('113','KA05IJ7890',1005,4500),
('114','KA06KL1122',1006,8000),
('114','KA07MN3344',1007,3500);


select count( distinct p.driverid  ) as no_of_people  from 
participated p , accident a where  p.reportno = a.reportno and  a.accdate BETWEEN '2020' and '2025' 

SELECT COUNT(DISTINCT o.driverid) AS total_people
FROM owns o
JOIN participated p 
    ON o.driverid = p.driverid AND o.regno = p.regno
JOIN accident a 
    ON p.reportno = a.reportno
WHERE a.accdate BETWEEN '2020' and '2025'


select count(p.reportno) from 
participated p , person pn where p.driverid = pn.driverid and pn.dname = 'nigga'

select count(p.regno) from participated p , car c where p.regno = c.regno and p.regno = 'KA01AB1234'



select count(distinct p.driverid)  as NO_OF_ACC from participated p , accident a where p.reportno = a.reportno and year(a.accdate) = '2020'

select count(p.driverid)  from person pn , participated p where p.driverid = pn.driverid and pn.dname = 'madvith';
insert into accident VALUES (1008,'2024-12-15','fwefew');
INSERT into participated VALUES ('113','KA04GH3456',1008,2000)
select count(p.regno) from participated p , car c WHERE p.regno = c.regno AND c.model = 'Maruti Swift'

update participated set dmgamt=3000 where regno='KA01AB1234' and reportno='1001';
select * FROM participated