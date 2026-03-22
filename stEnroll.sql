create database st_enroll
use st_enroll

create table student(
    regno varchar(20) primary key,
    name varchar(20),
    major varchar(20),
    bdate date
);

INSERT INTO student VALUES
('S1', 'Alice', 'CS', '2003-01-10'),
('S2', 'Bob', 'CS', '2003-03-15'),
('S3', 'Charlie', 'IS', '2002-07-21'),
('S4', 'David', 'EC', '2003-09-12'),
('S5', 'Eva', 'CS', '2002-11-30'),
('S6', 'Frank', 'IS', '2003-05-18');

create table course(
    courseid int primary key,
    cnmame varchar(20),
    dept varchar(20) 
);

INSERT INTO course VALUES
(101, 'DBMS', 'CS'),
(102, 'OS', 'CS'),
(103, 'Networks', 'CS'),
(201, 'Maths', 'IS'),
(202, 'Electronics', 'EC');


CREATE TABLE enroll(
    regno VARCHAR(20),
    courseid int,
    sem int,
    marks int,
    primary key(regno , courseid , sem),
    foreign key(regno)  REFERENCES student(regno) on delete CASCADE on UPDATE CASCADE,
    foreign key(courseid)  REFERENCES course(courseid) on delete CASCADE on UPDATE CASCADE,
);

INSERT INTO enroll VALUES
('S1', 101, 1, 85),
('S2', 101, 1, 78),
('S5', 101, 1, 88),

('S1', 102, 2, 90),
('S2', 102, 2, 76),

('S3', 201, 1, 80),
('S6', 201, 1, 70),

('S4', 202, 1, 65);


CREATE TABLE textbook(
    bookisbn int ,
    title VARCHAR(20),
    publisher VARCHAR(20),
    author VARCHAR(20),
    PRIMARY KEY(bookisbn)
);

INSERT INTO textbook VALUES
(1001, 'DBMS Concepts', 'Pearson', 'Korth'),
(1002, 'SQL Basics', 'Pearson', 'Navathe'),
(1003, 'Advanced DB', 'Pearson', 'Elmasri'),

(1004, 'OS Concepts', 'McGrawHill', 'Silberschatz'),
(1005, 'Unix System', 'McGrawHill', 'Tanenbaum'),

(1006, 'Networks Intro', 'Pearson', 'Forouzan'),
(1007, 'Data Comm', 'Pearson', 'Stallings'),

(1008, 'Engineering Maths', 'Oxford', 'Grewal'),
(1009, 'Circuits', 'Oxford', 'Hayt');


CREATE TABLE bookAdaption(
    courseid int ,
    sem int,
    bookisbn int ,
    PRIMARY KEY(courseid, sem , bookisbn),
    foreign key(courseid)  REFERENCES course(courseid) on delete CASCADE on UPDATE CASCADE,
    foreign key(bookisbn)  REFERENCES textbook(bookisbn) on delete CASCADE on UPDATE CASCADE
);

INSERT INTO bookAdaption VALUES
(101, 1, 1001),
(101, 1, 1002),
(101, 1, 1003);
INSERT INTO bookAdaption VALUES
(102, 2, 1004),
(102, 2, 1005),

(103, 1, 1006),
(103, 1, 1007);
INSERT INTO bookAdaption VALUES
(201, 1, 1006),
(201, 1, 1007);
INSERT INTO bookAdaption VALUES
(202, 1, 1009);

--1. Produce a list of text books (include Course #, Book-ISBN,
--Book-title) in the alphabetical order for courses offered by the
--‘CS’ department that use more than two books.
-- inner query retures courses with 2 or more book adoptions
select courseid from bookAdaption group by courseid having count(*)>=2
--main
select c.courseid , c.cnmame , t.title 
from 
course c, bookAdaption ba , textbook t
 where c.courseid = ba.courseid 
 and t.bookisbn = ba.bookisbn
 and c.dept = 'CS'
 and c.courseid in (
    select courseid from bookAdaption group by courseid having count(*)>=2
 ) order by t.title;

--List any department that has all its adopted books published by a specific publisher

--chatgpt
SELECT c.dept
FROM course c
JOIN bookAdaption ba ON c.courseid = ba.courseid
JOIN textbook t ON ba.bookisbn = t.bookisbn
GROUP BY c.dept
HAVING COUNT(DISTINCT t.publisher) = 1
   AND MAX(t.publisher) = 'Pearson';

--main
select distinct c.dept from course c where not exists(select bookisbn from bookAdaption where courseid in(select courseid from course where dept=c.dept)
and bookisbn not in( select t.bookisbn from textbook t where t.publisher='Pearson'))


select c.dept from course c , bookAdaption b , textbook a 
where c.courseid = b.courseid and b.bookisbn = a.bookisbn group by c.dept having count(distinct b.bookisbn) >= all
(select count(distinct d.bookisbn) from course f, bookAdaption d , textbook e where f.courseid = d.courseid
and d.bookisbn= e.bookisbn group by f.dept)