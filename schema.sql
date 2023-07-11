
DROP TABLE IF EXISTS SCHEDULE;
DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS PROFESSOR;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS STUDENT;

CREATE TABLE DEPARTMENT (
    department_id INT NOT NULL,
    department_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE STUDENT (
    student_id INT NOT NULL,
    student_fname VARCHAR(20) NOT NULL,
    student_lname VARCHAR(20) NOT NULL,
    student_email VARCHAR(50) NOT NULL,
    student_address VARCHAR(50) NOT NULL,
    student_phone VARCHAR(20) NOT NULL,
    student_dob DATE NOT NULL,
    student_username VARCHAR(20) NOT NULL,
    student_password VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id)
);

CREATE TABLE PROFESSOR (
    professor_id INT NOT NULL,
    professor_fname VARCHAR(20) NOT NULL,
    professor_lname VARCHAR(20) NOT NULL,
    professor_address VARCHAR(50) NOT NULL,
    professor_phone VARCHAR(20) NOT NULL,
    professor_email VARCHAR(20) NOT NULL,
    professor_department INT NOT NULL,
    professor_username VARCHAR(20) NOT NULL,
    professor_password VARCHAR(20) NOT NULL,
    PRIMARY KEY (professor_id),
    FOREIGN KEY (professor_department) REFERENCES DEPARTMENT(department_id)
);

CREATE TABLE COURSE (
    course_id INT NOT NULL,
    course_name VARCHAR(20) NOT NULL,
    course_instructor_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (course_instructor_id) REFERENCES PROFESSOR(professor_id)
);

CREATE TABLE ENROLLMENT (
    enrollment_id INT NOT NULL,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade VARCHAR(2) NOT NULL,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

CREATE TABLE SCHEDULE (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);


INSERT INTO DEPARTMENT VALUES
(1, 'Computer Science'), (2, 'Mathematics'), (3, 'Physics');

INSERT INTO STUDENT VALUES
(1, 'Mary', 'Taylor', '37 Oak Pl', '520-185-9383', 'mtayl1@gmail.com', 1995-4-5, 'mtay1', 'password'),
(2, 'Thomas', 'Smith', '969 Elm Way', '932-543-8953', 'tsmit2@outlook.com', 1999-11-20, 'tsmi2', 'password'),
(3, 'Thomas', 'Wilson', '472 Pine Ave', '804-953-5239', 'twils3@yahoo.com', 2005-8-8, 'twil3', 'password'),
(4, 'John', 'Jones', '653 Cedar Pl', '284-826-4042', 'jjone4@gmail.com', 2001-9-17, 'jjon4', 'password'),
(5, 'Mary', 'Brown', '29 Cedar Pl', '577-245-1588', 'mbrow5@hotmail.com', 2002-4-26, 'mbro5', 'password'),
(6, 'Amber', 'Smith', '717 High Ln', '753-208-7368', 'asmit6@gmail.com', 2003-4-15, 'asmi6', 'password'),
(7, 'Peter', 'Williams', '205 Hill Rd', '371-146-3599', 'pwill7@yahoo.com', 1997-10-11, 'pwil7', 'password'),
(8, 'Matthew', 'Williams', '998 Main Dr', '856-914-4328', 'mwill8@outlook.com', 1999-6-1, 'mwil8', 'password'),
(9, 'John', 'White', '890 Hill Ln', '772-571-1631', 'jwhit9@gmail.com', 2002-9-12, 'jwhi9', 'password'),
(10, 'Peter', 'Martin', '799 Main Pl', '190-862-4045', 'pmart10@outlook.com', 1996-9-28, 'pmar10', 'password');

INSERT INTO PROFESSOR VALUES
(1, 'Elizabeth', 'Smith', '387 Cedar Rd', '206-176-9309', 'esmit1@hotmail.com', 3, 'esmi1', 'password'),
(2, 'Matthew', 'Brown', '249 Elm St', '426-545-6796', 'mbrow2@hotmail.com', 1, 'mbro2', 'password'),
(3, 'John', 'Taylor', '939 Oak Way', '440-629-3825', 'jtayl3@yahoo.com', 1, 'jtay3', 'password');

INSERT INTO COURSE VALUES 
(1, "Calculus I", 2, "9:00:00", "10:00:00", 101),
(2, "Modern Physics", 3, "10:00:00", "11:00:00", 102),
(3, "Java I", 1, "11:00:00", "12:00:00", 103),
(4, "Calculus II", 2, "11:00:00", "12:00:00", 101),
(5, "Modern Physics", 3, "12:00:00", "13:00:00", 102);

INSERT INTO ENROLLMENT VALUES 
(1, 1, 1, "A"),
(2, 2, 1, "B"),
(3, 3, 5, "C"),
(4, 4, 1, "D"),
(5, 5, 1, "F"),
(6, 6, 5, "A"),
(7, 7, 1, "B"),
(8, 8, 1, "C"),
(9, 9, 1, "D"),
(10, 10, 1, "F"),
(11, 1, 3, "A"),
(12, 2, 2, "B"),
(13, 3, 2, "C"),
(14, 4, 3, "D"),
(15, 5, 3, "F"),
(16, 6, 2, "A"),
(17, 7, 3, "B"),
(18, 8, 2, "C"),
(19, 9, 2, "D"),
(20, 10, 5, "F");

-- SCHEDULE TABLE from students.sql and enrollment.sql
INSERT INTO SCHEDULE (student_id, course_id) 
SELECT DISTINCT student_id, course_id FROM ENROLLMENT;
