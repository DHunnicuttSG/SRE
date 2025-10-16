drop database if exists StudentProjects;

create database studentProjects;

use studentProjects;

create table student(
	studentId int auto_increment primary key,
	studentName varchar(100),
	email varchar(250)
);

create table project(
	projectId int auto_increment primary key,
    projectName varchar(250)
);

create table student_Project(
	studentId int,
    projectId int,
	foreign key (studentId) references student(studentId),
    foreign key (projectId) references project(projectId)
);


insert into student(studentName, email) values 
("Layana Muhdi Al Tounsi","layana.muhdialtounsi@mthree.com"),
("Ricky Jr Mungcal","rickyjr.mungcal@mthree.com"),
("Brandon McFarlane","brandon.mcfarlane@mthree.com"),
("Ian Mancuso","ian.mancuso@mthree.com"),
("Andreas Koudounis","andreas.koudounis@mthree.com"),
("Arseny Kokotov","arseny.kokotov@mthree.com"),
("Noah Tonnesen","noah.tonnesen@mthree.com"),
("Seida Ahmed","seida.ahmed@mthree.com"),
("Joshua Manascu","joshua.manascu@mthree.com"),
("Zeyangguang Li","zeyangguang.li@mthree.com"),
("Tanzila Tabassum","tanzila.tabassum@mthree.com"),
("Zachary Ceolin","zachary.ceolin@mthree.com"),
("Kailey Van","kailey.van@mthree.com"),
("Weilun Zhang","weilun.zhang@mthree.com"),
("Krupesh Patel","krupesh.patel@mthree.com");

insert into project(projectName) values ("Scheduler App"),
("Database design"),
("Stock Trader App"),
("New Game App"),
("Incident Management App"),
("Pokemon Trading App"),
("Encryption App"),
("Front end design with React"),
("Python design with Django");