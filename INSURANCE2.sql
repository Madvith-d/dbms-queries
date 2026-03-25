create Database Insurance123

use Insurance123


CREATE TABLE PERSON (
			driverid varchar(10),
			pname char(15) not null,
			address varchar(30),
			primary key (driverid)  
			)

			
CREATE TABLE CAR (
			regno varchar(10),
			model varchar(10)not null,
			cyear int,
			primary key(regno) 
		)
	select * from CAR
	
	CREATE TABLE ACCIDENT  (
			reportno int ,
			accdate datetime,
			location varchar(20),
			primary key(reportno)  --only repotno
			)

CREATE TABLE OWNS    (
			driverid varchar(10) ,
			regno varchar(10)
			primary key(driverid,regno) 
			foreign key(driverid) references PERSON(driverid)on delete cascade on update cascade,
			foreign key(regno) references CAR(regno)on delete cascade on update cascade,
		    )
CREATE TABLE PARTCIPATED (
			   driverid varchar(10) ,
			   regno varchar(10),
			   reportno  int,
			   dmgamt int,
			   primary key(driverid,regno,reportno) ,
			   foreign key(driverid) references PERSON(driverid)on delete cascade on update cascade,
			   foreign key(regno) references CAR(regno)on delete cascade on update cascade,
			   foreign key(reportno) references ACCIDENT(reportno)  on delete cascade on update cascade,
			  
			 )

	select * from PERSON
	select * from CAR
	select * from ACCIDENT
	select  * from PARTCIPATED
	insert into  PERSON values ('111','John Smith' , 'SP Road, Bangalore-12')
insert into  PERSON values ('112','Ramesh Babu' , 'KP Nagar, Udupi -13')
insert into  PERSON values ('113','Raju SK' , 'KS Circle, Mangalore-12')
insert into  PERSON values ('114','Ramesh Babu' , 'AS Road, Bangalore-14')
insert into  PERSON values ('115','Alica wallace' , 'SS Road, Karkala-16')

insert into  CAR values ('KA-12','FORD' ,1980)
insert into  CAR values ('KA-13','SWIFT' ,1990)
insert into  CAR values ('MH-11','INDIGO' ,1998)
insert into  CAR values ('AP-10','SWIFT' ,1988)
insert into  CAR values ('TN-11','FORD' ,2001)
insert into  CAR values ('TN-12','TOYATA' ,2001)
insert into  CAR values ('MH-14','SWIFT' ,2001)
insert into  CAR values ('KL-15','TOYATA' ,2001)

insert into  ACCIDENT values (1,'1998-07-22' ,'Nitte')
insert into  ACCIDENT values (2,'1998-07-22','Karkala')
insert into  ACCIDENT values (12,'1998-07-22' ,'Mangalore')
insert into  ACCIDENT values (3,'1998-07-23','Mangalore')
insert into  ACCIDENT values (4,'1990-09-09','Bhatkal')
insert into  ACCIDENT values (5,'2001-02-22' ,'Udupi')
insert into  ACCIDENT values (6,'1990-09-09','Udupi')
insert into  ACCIDENT values (15,'1981-07-22' ,'Udupi')
insert into  ACCIDENT values (16,'1989-07-22' ,'Udupi')

insert into  OWNS values ('111','KA-13')
insert into  OWNS values ('111','KA-12')
insert into  OWNS values ('111','MH-11')

insert into  OWNS values ('112','AP-10')
insert into  OWNS values ('112','TN-11')

insert into  OWNS values ('113','TN-12')
insert into  OWNS values ('113','KL-15')

insert into  OWNS values ('114','AP-05')
insert into  OWNS values ('114','KL-4')

insert into  OWNS values ('115','MH-14')

insert into  PARTCIPATED values ('111','KA-12',1,20000)
insert into  PARTCIPATED values ('111','KA-13',2,10000)
insert into  PARTCIPATED values ('111','KA-12',3,60000)
insert into  PARTCIPATED values ('111','KA-12',4,60000)
insert into  PARTCIPATED values ('111','KA-12',5,60000)
insert into  PARTCIPATED values ('111','KA-12',15,40000)
insert into  PARTCIPATED values ('111','KA-13',6,10000)
insert into  PARTCIPATED values ('111','MH-11',12,20000)
 
insert into  PARTCIPATED values ('112','AP-10',7,30000)
insert into  PARTCIPATED values ('112','TN-11',8,40000)
insert into  PARTCIPATED values ('112','AP-10',13,20000)
insert into  PARTCIPATED values ('112','TN-11',14,10000)
insert into  PARTCIPATED values ('112','TN-11',16,10000)

--1. Find the total number of people who owned cars that were involved in accidents in
--1989.
 select count (distinct P.driverid) as total_no_count
from accident A, partcipated P
where A.reportno = P.reportno 
and year(A.accdate) = '1989' 

 	

select  count (P.reportno) as NO_OF_ACC
from   partcipated P,  person PN
where P.driverid =  PN.driverid 
and   PN.pname = 'John Smith'   


update PARTCIPATED  set dmgamt = 3000 
where reportno = 1 and reg_no ='KA-12'

