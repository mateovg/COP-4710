
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


INSERT INTO DEPARTMENT VALUES(1, 'Computer Science');
INSERT INTO DEPARTMENT VALUES(2, 'Mathematics');
INSERT INTO DEPARTMENT VALUES(3, 'Physics');

INSERT INTO STUDENT VALUES (1, "Alex", "Brown", "abrown1@gmail.com", "714 Hill Pl", "981-602-1942", "2005-2-25");
INSERT INTO STUDENT VALUES (2, "Peter", "Anderson", "panderson2@gmail.com", "215 Pine Rd", "585-439-5893", "1995-9-28");
INSERT INTO STUDENT VALUES (3, "Paul", "Taylor", "ptaylor3@yahoo.com", "645 Pine Ln", "146-323-6596", "1995-1-13");
INSERT INTO STUDENT VALUES (4, "Peter", "Williams", "pwilliams4@outlook.com", "370 Oak Rd", "207-787-6410", "1995-12-27");
INSERT INTO STUDENT VALUES (5, "Amber", "Smith", "asmith5@outlook.com", "355 Elm Dr", "227-450-1630", "1997-12-1");
INSERT INTO STUDENT VALUES (6, "Paul", "Brown", "pbrown6@yahoo.com", "991 High Ln", "379-147-2074", "1995-8-23");
INSERT INTO STUDENT VALUES (7, "Peter", "Williams", "pwilliams7@hotmail.com", "338 Main Pl", "986-109-2485", "2000-2-6");
INSERT INTO STUDENT VALUES (8, "John", "Brown", "jbrown8@outlook.com", "258 High Way", "915-879-2397", "2002-10-7");
INSERT INTO STUDENT VALUES (9, "Mary", "Williams", "mwilliams9@outlook.com", "89 Main Way", "357-131-5194", "2004-1-12");
INSERT INTO STUDENT VALUES (10, "Alex", "Wilson", "awilson10@gmail.com", "678 Cedar Pl", "694-145-2719", "2003-6-2");

INSERT INTO PROFESSOR VALUES (1, "Alex", "Jones", "ajones1@hotmail.com", "722 Hill Dr", "250-760-5182", 3);
INSERT INTO PROFESSOR VALUES (2, "Thomas", "Martin", "tmartin2@yahoo.com", "6 Washington Pl", "391-482-4643", 1);
INSERT INTO PROFESSOR VALUES (3, "Matthew", "Brown", "mbrown3@gmail.com", "62 Lake Blvd", "485-716-8023", 1);

INSERT INTO COURSE VALUES (1, "Calculus I", 2, "9:00:00", "10:00:00", 101);
INSERT INTO COURSE VALUES (2, "Modern Physics", 3, "10:00:00", "11:00:00", 102);
INSERT INTO COURSE VALUES (3, "Java I", 1, "11:00:00", "12:00:00", 103);
INSERT INTO COURSE VALUES (4, "Calculus II", 2, "11:00:00", "12:00:00", 101);
INSERT INTO COURSE VALUES (5, "Modern Physics", 3, "12:00:00", "13:00:00", 102);

INSERT INTO ENROLLMENT VALUES (1, 1, 1, "A");
INSERT INTO ENROLLMENT VALUES (2, 2, 1, "B");
INSERT INTO ENROLLMENT VALUES (3, 3, 5, "C");
INSERT INTO ENROLLMENT VALUES (4, 4, 1, "D");
INSERT INTO ENROLLMENT VALUES (5, 5, 1, "F");
INSERT INTO ENROLLMENT VALUES (6, 6, 5, "A");
INSERT INTO ENROLLMENT VALUES (7, 7, 1, "B");
INSERT INTO ENROLLMENT VALUES (8, 8, 1, "C");
INSERT INTO ENROLLMENT VALUES (9, 9, 1, "D");
INSERT INTO ENROLLMENT VALUES (10, 10, 1, "F");
INSERT INTO ENROLLMENT VALUES (11, 1, 3, "A");
INSERT INTO ENROLLMENT VALUES (12, 2, 2, "B");
INSERT INTO ENROLLMENT VALUES (13, 3, 2, "C");
INSERT INTO ENROLLMENT VALUES (14, 4, 3, "D");
INSERT INTO ENROLLMENT VALUES (15, 5, 3, "F");
INSERT INTO ENROLLMENT VALUES (16, 6, 2, "A");
INSERT INTO ENROLLMENT VALUES (17, 7, 3, "B");
INSERT INTO ENROLLMENT VALUES (18, 8, 2, "C");
INSERT INTO ENROLLMENT VALUES (19, 9, 2, "D");
INSERT INTO ENROLLMENT VALUES (20, 10, 5, "F");

-- SCHEDULE TABLE from students.sql and enrollment.sql
INSERT INTO SCHEDULE (student_id, course_id) 
SELECT DISTINCT student_id, course_id FROM ENROLLMENT;
