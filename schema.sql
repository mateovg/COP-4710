
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
    student_id INT NOT NULL AUTO_INCREMENT,
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
    professor_id INT NOT NULL AUTO_INCREMENT,
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
(1, 'Peter', 'Anderson', '431 High Blvd', '230-954-3899', 'pande1@hotmail.com', '1997-6-26', 'pand1', 'password'),
(2, 'Paul', 'Brown', '487 High Ln', '301-433-3035', 'pbrow2@outlook.com', '2001-2-23', 'pbro2', 'password'),
(3, 'Amber', 'Wilson', '833 Pine Cir', '401-333-4319', 'awils3@yahoo.com', '2004-10-14', 'awil3', 'password'),
(4, 'Alex', 'Martin', '21 Pine Pl', '609-778-3049', 'amart4@outlook.com', '1997-6-25', 'amar4', 'password'),
(5, 'John', 'Anderson', '31 Main Rd', '485-363-2362', 'jande5@gmail.com', '1999-5-14', 'jand5', 'password'),
(6, 'Alex', 'Wilson', '562 Hill St', '187-130-3097', 'awils6@hotmail.com', '2002-10-21', 'awil6', 'password'),
(7, 'Elizabeth', 'Brown', '265 Elm Way', '497-579-6352', 'ebrow7@outlook.com', '1995-6-15', 'ebro7', 'password'),
(8, 'Mary', 'Smith', '406 Cedar Ave', '351-971-7360', 'msmit8@yahoo.com', '2005-5-28', 'msmi8', 'password'),
(9, 'Mary', 'Williams', '231 Washington Ave', '103-357-2443', 'mwill9@yahoo.com', '2000-2-8', 'mwil9', 'password'),
(10, 'Matthew', 'White', '50 Washington Ln', '942-475-2609', 'mwhit10@yahoo.com', '2000-10-2', 'mwhi10', 'password');

INSERT INTO PROFESSOR VALUES
(1, 'Matthew', 'White', '24 Main Pl', '223-205-2118', 'mwhit1@yahoo.com', 2, 'mwhi1', 'password'),
(2, 'Mary', 'Martin', '332 Washington Ave', '737-655-6457', 'mmart2@gmail.com', 3, 'mmar2', 'password'),
(3, 'Amber', 'Wilson', '76 Cedar Cir', '971-182-5709', 'awils3@yahoo.com', 1, 'awil3', 'password');

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
