drop database if exists college;

create database college;

use college;

create table student(
	studentId int auto_increment primary key,
    studentName varchar(255)
);

create table Instructor(
	instructorId int auto_increment primary key,
    instructorName varchar(255),
    instructorOffice varchar(10),
    department varchar(25)
);

create table course(
	courseId char(4) primary key,
    courseName varchar(100),
    instructorId int,
    foreign key (instructorId) references instructor(instructorId)
);

create table student_course(
    studentId int,
    courseId char(4),
    semester varchar(20),
    grade char(1),
    foreign key (studentId) references student(studentId),
    foreign key (courseId) references course(courseId)
);

insert into student(studentName) values ("Alice Smith"), ("Bob Jones"), ("Carol White");
insert into student(studentId, studentName) values (5, "Emma Thompson"), (6, "Frank Rivera"), 
(7, "Grace Kim"), (8, "Henry Lopez");

insert into instructor(instructorName, instructorOffice, department) values 
("Dr. Brown", "Rm101", "Math"), ("Prof. Lee", "Rm202", "History"),
("Dr. Aman", "Rm307", "CompSci"), ("Dr. Tan", "Rm421", "Physics"), 
("Dr. Green", "Rm222", "CompSci");

insert into course(courseId, courseName, instructorId) values 
("C101", "Math", 1), ("C202", "History", 2),
("C226", "Java", 3), ("C227", "Python", 4),
("C128", "Python", 4), ("C129", "C#", 5);

insert into student_course(studentId, courseId, semester, grade) values
(1, "C101", "Fall 2025", "A"), (1, "C202", "Fall 2025", "B"),
(2, "C101", "Fall 2025", "B"), (3, "C202", "Fall 2025", "A"),
(5, "C226", "Fall 2025", "B"), (6, "C227", "Fall 2025", "A"),
(7, "C128", "Fall 2025", "A"), (8, "C129", "Fall 2025", "B");

-- recreate the first table
select s.studentId, s.studentName, sc.courseId, c.courseName, i.instructorName, 
i.instructorOffice, sc.semester, sc.grade, i.department
from student s 
join student_course sc on s.studentId = sc.studentId
join course c on sc.courseId = c.courseId
join instructor i on c.instructorId = i.instructorId
order by s.studentId;
