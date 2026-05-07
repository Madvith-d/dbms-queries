create database bank_128
use bank_128

create table branch(
	bname varchar(20),
	bcity varchar(20),
	assets real,
	primary key(bname)
)

create table account(
	accno int ,
	bname varchar(20),
	balance real,
	primary key(accno),
	foreign key(bname) references branch(bname) on delete cascade on update cascade
);

create table customer(
	cname varchar(20),
	cstreet varchar(20),
	ccity varchar(20),
	primary key(cname)
);

create table depositor(
	cname varchar(20),
	accno int,
	primary key(cname , accno),
	foreign key(cname) references customer(cname) on delete cascade on update cascade,
	foreign key(accno) references account(accno) on delete cascade on update cascade,
);

create table loan(
	lnumber int ,
	bname varchar(20),
	amount real,
	primary key(lnumber),
	foreign key(bname) references branch(bname) on delete cascade on update cascade
);

create table borrower(
	cname varchar(20),
	lnumber int,
	primary key(cname , lnumber),
	foreign key(cname) references customer(cname) on delete cascade on update cascade,
	foreign key(lnumber) references loan(lnumber) on delete cascade on update cascade,	
	
);

insert into branch values
('b1','bangalore',90000000),
('b2','bangalore',90000000),
('b3','bangalore',90000000),
('mb1','mumbai',90000000),
('mb2','mumbai',90000000),
('ch1','chennai',90000000);



insert into account VALUES
(101,'b1',200000),
(102,'b2',200000),
(103,'b3',200000),
(104,'mb1',200000),
(105,'mb2',200000),
(106,'ch1',200000),
(107,'b1',200000),
(108,'b2',200000),
(109,'mb1',200000),
(110,'ch1',200000);

INSERT into account VALUES
(111,'mb1',200000),
(112,'mb2',200000);


SELECT * from account

INSERT into customer VALUES
('Alice','fsvv','fsdvs'),
('Bob','fsvv','fsdvs'),
('Charlie','fsvv','fsdvs'),
('David','fsvv','fsdvs'),
('Emma','fsvv','fsdvs');

insert into depositor VALUES
('Alice',101),
('Alice',102),
('Alice',104),
('Bob',104),
('Bob',105),
('David',107),
('David',108),
('David',103),
('Emma',110);
insert into depositor VALUES
('Bob',111),
('Bob',112);
insert into depositor VALUES
('Emma',101),
('Emma',104),
('Emma',106);

SELECT * FROM depositor

insert  into loan VALUES
(
1,'b1',50000),
(2,'b2',50000),
(3,'b3',50000),
(4,'mb1',50000),
(5,'mb2',50000),
(6,'ch1',50000);

INSERT into borrower VALUES
('Alice',1),
('Bob',2),
('Charlie',3),
('David',4),
('Emma',5);

--Find all the customers who have at least 2 accounts at all the branches located in a specific city.

SELECT C.cname from customer C where not exists(
	SELECT B.bname from branch B WHERE B.bcity = 'mumbai' and B.bname not in(
		select distinct(A.bname) from account A , depositor D
		 where A.bname = B.bname and A.accno = D.accno and D.cname = C.cname 
		 group by A.bname having count(*) >= 2
	)
)

--Customers who have accounts in at least 1 branch located in all cities
SELECT C.cname from customer C 
where not exists(
	select distinct(B.bcity) from branch B WHERE
	not exists(
		select A.bname from account A , depositor D
		where D.accno = A.accno
		and D.cname = C.cname and A.bname in (
			select bname from branch where bcity = B.bcity
		)
	)
)

--Find all the customers who have accounts in atleast 2 branches located in a specific city

select C.cname from customer C where exists (
	select distinct(B.bcity) from branch B , account A , depositor D
	WHERE D.accno = A.accno AND
	A.bname = B.bname AND
	D.cname = C.cname AND
	B.bcity = 'bangalore' GROUP BY B.bcity HAVING COUNT(*)>=2
);