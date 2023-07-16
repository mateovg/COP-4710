USE abcuniversity;

-- 1. Retrieve all students from the student table.
SELECT student_fname, student_lname FROM STUDENT;
-- 2. Retrieve all students from the student table whose last name is Smith.
SELECT * FROM STUDENT WHERE student_lname = 'Smith';
-- 3. Retrieve all students from the student table who are older than 20 years old at the start of the year.
SELECT * FROM STUDENT WHERE student_dob < '2003-01-01';
-- 4. Retrieve all students from the student table who live on a street that starts with the letter “M”.
SELECT * FROM STUDENT WHERE student_address LIKE '% M%';
-- 5. Retrieve all students from the student table who have a phone number that starts with “555”.
SELECT * FROM STUDENT WHERE student_phone LIKE '555%';
-- 6. Retrieve all students from the student table who have an email address that ends with “@gmail.com”.
SELECT * FROM STUDENT WHERE student_email LIKE '%@gmail.com';
--  one SQL query to insert a new student into the student table
INSERT INTO STUDENT VALUES (50, "Mateo", "Velasquez", "mvelas02@abc.com", "1029 Main Way", "305-131-5194", "1994-6-23", 'mateo', 'pw');
SELECT student_fname, student_lname FROM STUDENT;
--  one SQL query to update a student record based on the student’s id
UPDATE STUDENT SET student_lname = 'Velazquez' WHERE student_id = 50;
SELECT student_fname, student_lname FROM STUDENT;
--  one SQL query to delete a student record based on the student’s id
DELETE FROM STUDENT WHERE student_id = 50;
SELECT student_fname, student_lname FROM STUDENT;
