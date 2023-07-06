CREATE SCHEMA IF NOT EXISTS abcuniversity;

USE abcuniversity;

DROP TABLE IF EXISTS ENROLLMENT;
DROP TABLE IF EXISTS SCHEDULE;
DROP TABLE IF EXISTS COURSE;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS PROFESSOR;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE STUDENT (
    student_id INT NOT NULL,
    student_fname VARCHAR(20) NOT NULL,
    student_lname VARCHAR(20) NOT NULL,
    student_address VARCHAR(50) NOT NULL,
    student_phone VARCHAR(20) NOT NULL,
    student_email VARCHAR(20) NOT NULL,
    student_dob DATE NOT NULL,
    PRIMARY KEY (student_id)
);

CREATE TABLE PROFESSOR(
    professor_id INT NOT NULL,
    professor_fname VARCHAR(20) NOT NULL,
    professor_lname VARCHAR(20) NOT NULL,
    professor_address VARCHAR(50) NOT NULL,
    professor_phone VARCHAR(20) NOT NULL,
    professor_email VARCHAR(20) NOT NULL,
    professor_department VARCHAR(20) NOT NULL,
    PRIMARY KEY (professor_id),
    FOREIGN KEY (professor_department) REFERENCES DEPARTMENT(department_id)
);

CREATE TABLE ENROLLMENT(
    enrollment_id INT NOT NULL,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade VARCHAR(2) NOT NULL,
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id)
);

CREATE TABLE DEPARTMENT(
    department_id INT NOT NULL,
    department_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (department_id)
); 

CREATE TABLE SCHEDULE(
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (course_id) REFERENCES COURSE(course_id),
    FOREIGN KEY (start_time) REFERENCES COURSE(start_time),
    FOREIGN KEY (end_time) REFERENCES COURSE(end_time),
    FOREIGN KEY (room_number) REFERENCES COURSE(room_number)
);

CREATE TABLE COURSE (
    course_id INT NOT NULL,
    course_name VARCHAR(20) NOT NULL,
    course_instructor VARCHAR(20) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (course_id),
    FOREIGN KEY (course_instructor) REFERENCES PROFESSOR(professor_id)
);

INSERT INTO STUDENT VALUES
(1, 'John', 'Smith', '123 Main St', '123-456-7890', 'jsmith@gmail.com', '1990-01-01'),


