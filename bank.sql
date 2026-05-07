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



select * from branch


