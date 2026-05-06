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