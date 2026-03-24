create database ST_enroll
use ST_enroll;
create table STUDENT (
			regno varchar(10),
			fname char(15),
			major char (20),
			bdate date,
			primary key(regno)
		    );

create table COURSE (
			course_id int,
			cname varchar(15),
			dept  char (20),
			primary key(course_id)
			)

create table TEXTBOOK (
			bookISBN int,
			title varchar(50),
			publisher  varchar(20),
			author  char(20),
			primary key (bookISBN)
		     )

Create table BOOK_ADAPTION (
			course_id int,
			sem int,
			bookISBN int,
			primary key(course_id, sem,bookISBN), --even BookIsbn is a primary key
			foreign key(course_id) references COURSE(course_id) on delete cascade on update cascade,
			foreign key(bookISBN) references TEXTBOOK (bookISBN) on delete cascade on update cascade,
		    )

create table ENROLL (
			regno varchar(10),
			course_id  int,
			sem int ,
			marks int,
			primary key(regno,course_id,sem),
			foreign key(regno) references STUDENT(regno)on delete cascade on update cascade,
			foreign key(course_id) references COURSE(course_id)on delete cascade on update cascade
		    )
insert into STUDENT values ('111','ravi','academic','1989-11-09')
insert into STUDENT values ('112','sudha','academic','1979-07-04')
insert into STUDENT values ('113','kumar','academic','1979-01-06')
insert into STUDENT values ('114','raju','admission','1999-10-02')
insert into STUDENT values ('115','hemanth','account','1988-11-04')

insert into COURSE values (100,'DBMS','CS')
insert into COURSE values (200,'COMPILER','CS')
insert into COURSE values (300,'JAVA','CS')
insert into COURSE values (400,'SIG PROCESSING','ENC')
insert into COURSE values (500,'DIGTAL CIRCUITS','ENC')
insert into COURSE values (600,'MACHINE DESIGN','MECH')
insert into COURSE values (700,'THEMODYNAICS','MECH')
insert into COURSE values (800,'AUTOCAD','MECH')

insert into TEXTBOOK  values (201,'Fundamentals of DBMS','McGraw','NAVATHE')
insert into TEXTBOOK  values (202,'Database Design','McGraw','RaghuRama')
insert into TEXTBOOK  values (203,'Compiler design','Pearson','Ulman')
insert into TEXTBOOK  values (204,'JAVA complete Reference','McGraw','BALAGURU')
insert into TEXTBOOK  values (205,'Singals and Fundumentals','McGraw','NITHIN')
insert into TEXTBOOK  values (206,'Machine Theory','McGraw','Ragavan')
insert into TEXTBOOK  values (208,'Circuit design','McGraw','Rajkamal')
insert into TEXTBOOK  values (207,'Thermodynamics','McGraw','Alfred')
insert into TEXTBOOK  values (209,'Electronic Circuits','McGraw','Giridhar')
insert into TEXTBOOK  values (210,'Circuits Theory','McGraw','Alfred')

 
insert into BOOK_ADAPTION  values (100,5,201)
insert into BOOK_ADAPTION  values (100,7,202)
insert into BOOK_ADAPTION  values (200,5,203)
insert into BOOK_ADAPTION  values (200,6,203)
insert into BOOK_ADAPTION  values (300,7,204)
insert into BOOK_ADAPTION  values (400,3,205)
insert into BOOK_ADAPTION  values (400,5,209)
insert into BOOK_ADAPTION  values (500,5,205)
insert into BOOK_ADAPTION  values (500,6,208)
insert into BOOK_ADAPTION  values (500,2,210)
insert into BOOK_ADAPTION  values (600,7,206)
insert into BOOK_ADAPTION  values (700,3,207)
insert into BOOK_ADAPTION  values (700,3,206)
insert into BOOK_ADAPTION  values (800,3,207)

insert into ENROLL  values (111,100,5,59)
insert into ENROLL  values (111,200,5,70)
insert into ENROLL  values (111,300,5,75)
insert into ENROLL  values (112,100,5,49)
insert into ENROLL  values (113,200,5,80)
insert into ENROLL  values (114,300,7,79)
insert into ENROLL  values (115,400,3,79)

--1. Produce a list of text books (include Course #, Book-ISBN,Book-title) in the
--alphabetical order for courses offered by th ‘CS’ department that use more than two
--books.

select A.bookISBN, A.title,B.course_id,B.cname  
from TEXTBOOK A,COURSE B,BOOK_ADAPTION C 
where  A.bookISBN = C.bookISBN and B.course_id=C.course_id
and B.dept='CS' and B.course_id in 
	(select course_id
	from BOOK_ADAPTION 
	group by course_id having count(*)>=2)
order by A.title;

--2. List any department that has all its adopted books published by a specific publisher

select distinct(C.dept) 
from course C
where not exists (select bookISBN 
                  from  BOOK_ADAPTION 
                  where  course_id in
				  (select course_id from  course 
					where dept = C.dept) 
					and bookISBN not in                                                                     
							(select bookISBN
							 from TEXTBOOK where publisher='McGraw'))


--3. List the bookISBNs and book titles of the department that has maximum number of
--students

SELECT T.bookISBN, T.TITLE
FROM TEXTBOOK T, COURSE C, BOOK_ADAPTION B
where B.course_id=C.course_id and T.bookISBN=B.bookISBN
and C.dept  in(	
select C.dept
from COURSE C,ENROLL E
where C.course_id=E.course_id
group by C.dept
having COUNT(distinct E.regno)>=ALL (           
                                      select COUNT( distinct E.regno) as coun_reg                 
                                      from ENROLL E,COURSE C
                                      where E.course_id=C.course_id
                                      group by C.dept));
