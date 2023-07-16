USE abcuniversity;

DROP TABLE IF EXISTS SCHEDULE;
DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS PROFESSOR;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS STUDENT;
DROP VIEW IF EXISTS LOGIN;

CREATE TABLE DEPARTMENT (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE STUDENT (
    student_id INT NOT NULL AUTO_INCREMENT,
    student_fname VARCHAR(20) NOT NULL,
    student_lname VARCHAR(20) NOT NULL,
    student_address VARCHAR(50),
    student_phone VARCHAR(20),
    student_email VARCHAR(50),
    student_dob DATE,
    student_username VARCHAR(20) NOT NULL,
    student_password VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id)
);

CREATE TABLE PROFESSOR (
    professor_id INT NOT NULL AUTO_INCREMENT,
    professor_fname VARCHAR(20) NOT NULL,
    professor_lname VARCHAR(20) NOT NULL,
    professor_address VARCHAR(50),
    professor_phone VARCHAR(20),
    professor_email VARCHAR(50),
    professor_department INT,
    professor_username VARCHAR(20) NOT NULL,
    professor_password VARCHAR(20) NOT NULL,
    PRIMARY KEY (professor_id),
    FOREIGN KEY (professor_department) REFERENCES DEPARTMENT(department_id)
);

CREATE TABLE COURSE (
    course_id INT NOT NULL AUTO_INCREMENT,
    course_name VARCHAR(20) NOT NULL,
    course_instructor_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (course_instructor_id) REFERENCES PROFESSOR(professor_id)
);

CREATE TABLE ENROLLMENT (
    enrollment_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade VARCHAR(2),
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

CREATE TABLE SCHEDULE (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

-- View to get all student and professor login information
-- add column to indicate if student or professor
-- https://stackoverflow.com/questions/3267360/data-from-two-tables-into-one-view
CREATE VIEW LOGIN AS
SELECT student_id AS id, student_username AS username, student_password AS password, 'student' AS type FROM STUDENT
UNION
SELECT professor_id AS id, professor_username AS username, professor_password AS password, 'professor' AS type FROM PROFESSOR;


INSERT INTO DEPARTMENT (department_name) VALUES 
('Computer Science'), ('Mathematics'), ('Physics'), ('Biology'), ('Chemistry');


INSERT INTO STUDENT VALUES
(1, 'Mary', 'Williams', '763 High Dr', '371-429-3752', 'mwill1@outlook.com', '2000-12-21', 'mwil1', 'password'),
(2, 'John', 'Williams', '221 High St', '109-776-1767', 'jwill2@yahoo.com', '2000-2-24', 'jwil2', 'password'),
(3, 'Thomas', 'Brown', '395 Lake Ln', '546-544-8174', 'tbrow3@outlook.com', '1999-6-11', 'tbro3', 'password'),
(4, 'John', 'White', '274 High Rd', '706-797-2708', 'jwhit4@gmail.com', '2001-5-4', 'jwhi4', 'password'),
(5, 'Amber', 'Jones', '61 Elm Cir', '203-341-2728', 'ajone5@outlook.com', '2004-5-12', 'ajon5', 'password'),
(6, 'Alex', 'Wilson', '7 Cedar Ave', '611-930-7581', 'awils6@gmail.com', '2000-2-26', 'awil6', 'password'),
(7, 'Amber', 'Smith', '970 Washington Cir', '432-970-4982', 'asmit7@gmail.com', '2003-9-25', 'asmi7', 'password'),
(8, 'Paul', 'Smith', '190 Cedar Blvd', '545-172-2468', 'psmit8@yahoo.com', '1996-9-9', 'psmi8', 'password'),
(9, 'Matthew', 'Wilson', '923 Cedar Ave', '213-244-5234', 'mwils9@outlook.com', '1996-3-19', 'mwil9', 'password'),
(10, 'Amber', 'Martin', '606 Main Rd', '654-938-6638', 'amart10@hotmail.com', '2003-10-5', 'amar10', 'password'),
(11, 'Mary', 'Taylor', '109 Oak Dr', '460-277-2944', 'mtayl11@hotmail.com', '2003-3-7', 'mtay11', 'password'),
(12, 'Paul', 'Jones', '727 Pine Way', '766-708-8229', 'pjone12@hotmail.com', '1997-12-16', 'pjon12', 'password'),
(13, 'Matthew', 'Wilson', '893 Pine Ln', '106-670-7909', 'mwils13@gmail.com', '2001-12-24', 'mwil13', 'password'),
(14, 'Thomas', 'Wilson', '366 Cedar Way', '782-185-8564', 'twils14@gmail.com', '2004-9-16', 'twil14', 'password'),
(15, 'Mary', 'Martin', '616 Oak St', '643-423-1440', 'mmart15@gmail.com', '1995-3-22', 'mmar15', 'password'),
(16, 'Elizabeth', 'Williams', '855 High Rd', '987-305-7610', 'ewill16@hotmail.com', '1997-2-26', 'ewil16', 'password'),
(17, 'Amber', 'Wilson', '525 Elm Rd', '731-729-2962', 'awils17@yahoo.com', '2001-12-24', 'awil17', 'password'),
(18, 'Thomas', 'Williams', '602 High Dr', '808-245-5074', 'twill18@hotmail.com', '1999-3-16', 'twil18', 'password'),
(19, 'Matthew', 'Jones', '847 Cedar Way', '555-123-9074', 'mjone19@gmail.com', '2003-12-20', 'mjon19', 'password'),
(20, 'Amber', 'Taylor', '342 Cedar Pl', '982-716-9052', 'atayl20@outlook.com', '1997-4-19', 'atay20', 'password');

INSERT INTO PROFESSOR VALUES
(1, 'Alex', 'Wilson', '284 High Pl', '704-558-2491', 'awils1@gmail.com', 1, 'awilson1', 'password'),
(2, 'Peter', 'Williams', '364 Main Ln', '585-813-8511', 'pwill2@outlook.com', 3, 'pwilliams2', 'password'),
(3, 'Paul', 'Taylor', '243 High Ln', '764-323-6219', 'ptayl3@outlook.com', 2, 'ptaylor3', 'password'),
(4, 'Alex', 'Williams', '458 Pine St', '822-317-4166', 'awill4@hotmail.com', 3, 'awilliams4', 'password'),
(5, 'Thomas', 'Jones', '391 Hill Ln', '700-321-3782', 'tjone5@yahoo.com', 1, 'tjones5', 'password');

INSERT INTO COURSE (course_name, course_instructor_id, start_time, end_time, room_number) VALUES
('Physics', 1, '11:48:00', '16:54:00', 974),
('Chemistry', 5, '16:16:00', '16:46:00', 382),
('Computer Science', 1, '10:53:00', '18:45:00', 497),
('Mathematics', 1, '14:37:00', '18:00:00', 912),
('Chemistry', 5, '10:14:00', '15:01:00', 565),
('Computer Science', 2, '09:09:00', '15:36:00', 598),
('Chemistry', 4, '12:43:00', '12:18:00', 371),
('Computer Science', 4, '14:26:00', '15:06:00', 429),
('Physics', 5, '11:19:00', '11:31:00', 352),
('Mathematics', 3, '12:38:00', '12:12:00', 866);

INSERT INTO ENROLLMENT (student_id, course_id, grade) VALUES
(1, 7, 'A'),
(1, 9, 'A'),
(1, 8, 'A'),
(1, 3, 'F'),
(1, 4, 'C'),
(2, 8, 'C'),
(2, 6, 'B'),
(2, 4, 'D'),
(2, 7, 'F'),
(2, 5, 'F'),
(3, 2, 'F'),
(3, 5, 'D'),
(3, 9, 'F'),
(3, 3, 'F'),
(3, 1, 'B'),
(4, 6, 'D'),
(4, 3, 'F'),
(4, 9, 'C'),
(4, 4, 'A'),
(4, 2, 'F'),
(5, 9, 'A'),
(5, 5, 'C'),
(5, 3, 'C'),
(5, 6, 'F'),
(5, 4, 'B'),
(6, 5, 'A'),
(6, 9, 'A'),
(6, 2, 'A'),
(6, 3, 'A'),
(6, 6, 'D'),
(7, 9, 'D'),
(7, 1, 'F'),
(7, 6, 'B'),
(7, 4, 'B'),
(7, 5, 'D'),
(8, 4, 'A'),
(8, 5, 'D'),
(8, 9, 'D'),
(8, 6, 'A'),
(8, 7, 'F'),
(9, 8, 'F'),
(9, 4, 'A'),
(9, 5, 'A'),
(9, 2, 'B'),
(9, 1, 'D'),
(10, 3, 'F'),
(10, 5, 'A'),
(10, 7, 'D'),
(10, 8, 'C'),
(10, 6, 'A'),
(11, 7, 'A'),
(11, 6, 'B'),
(11, 8, 'D'),
(11, 3, 'D'),
(11, 5, 'F'),
(12, 4, 'C'),
(12, 2, 'A'),
(12, 5, 'C'),
(12, 8, 'F'),
(12, 9, 'B'),
(13, 4, 'A'),
(13, 6, 'D'),
(13, 5, 'B'),
(13, 9, 'A'),
(13, 2, 'A'),
(14, 1, 'B'),
(14, 8, 'D'),
(14, 5, 'C'),
(14, 6, 'D'),
(14, 2, 'B'),
(15, 8, 'D'),
(15, 7, 'F'),
(15, 6, 'F'),
(15, 2, 'C'),
(15, 9, 'D'),
(16, 8, 'F'),
(16, 2, 'B'),
(16, 1, 'A'),
(16, 3, 'F'),
(16, 6, 'C'),
(17, 4, 'C'),
(17, 1, 'C'),
(17, 9, 'D'),
(17, 2, 'C'),
(17, 7, 'A'),
(18, 5, 'D'),
(18, 7, 'D'),
(18, 4, 'B'),
(18, 8, 'B'),
(18, 3, 'A'),
(19, 8, 'C'),
(19, 1, 'B'),
(19, 9, 'F'),
(19, 3, 'D'),
(19, 6, 'A'),
(20, 5, 'A'),
(20, 3, 'D'),
(20, 2, 'D'),
(20, 7, 'F'),
(20, 4, 'B');

-- insert values into schedule table
-- from enrollment table and course table
INSERT INTO SCHEDULE (student_id, course_id, start_time, end_time, room_number)
SELECT E.student_id, C.course_id, C.start_time, C.end_time, C.room_number
FROM ENROLLMENT as E
INNER JOIN COURSE as C
ON E.course_id = C.course_id;