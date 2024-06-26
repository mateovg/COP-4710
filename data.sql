INSERT INTO STUDENT VALUES
(1, 'Matthew', 'Anderson', '260 Oak Dr', '928-441-5374', 'mande1@yahoo.com', '1998-8-1', 'mand1', 'password'),
(2, 'Mary', 'Martin', '42 Elm Blvd', '333-593-4180', 'mmart2@hotmail.com', '2005-1-15', 'mmar2', 'password'),
(3, 'Peter', 'Wilson', '575 Washington Way', '549-315-8751', 'pwils3@yahoo.com', '1999-8-10', 'pwil3', 'password'),
(4, 'Paul', 'Brown', '999 Main Blvd', '787-961-3829', 'pbrow4@gmail.com', '2001-11-5', 'pbro4', 'password'),
(5, 'Mary', 'Taylor', '536 Lake Rd', '850-874-4002', 'mtayl5@outlook.com', '1997-4-8', 'mtay5', 'password'),
(6, 'Thomas', 'Jones', '120 Oak Ln', '634-859-8772', 'tjone6@yahoo.com', '2005-10-16', 'tjon6', 'password'),
(7, 'Paul', 'Williams', '433 Main Pl', '738-467-6984', 'pwill7@gmail.com', '2002-11-17', 'pwil7', 'password'),
(8, 'Mary', 'White', '514 Washington Ln', '519-670-3576', 'mwhit8@yahoo.com', '1999-10-27', 'mwhi8', 'password'),
(9, 'Peter', 'Jones', '745 Lake Ln', '231-482-4579', 'pjone9@gmail.com', '2002-4-6', 'pjon9', 'password'),
(10, 'Paul', 'Smith', '40 Oak St', '174-495-6590', 'psmit10@outlook.com', '2000-11-15', 'psmi10', 'password'),
(11, 'Mary', 'Taylor', '228 High Ave', '208-600-1973', 'mtayl11@hotmail.com', '2002-3-15', 'mtay11', 'password'),
(12, 'Matthew', 'Brown', '327 Washington Ln', '252-855-6668', 'mbrow12@yahoo.com', '1998-5-2', 'mbro12', 'password'),
(13, 'Matthew', 'White', '732 Oak Ave', '174-457-5597', 'mwhit13@hotmail.com', '1996-8-12', 'mwhi13', 'password'),
(14, 'Thomas', 'Martin', '3 Oak Blvd', '617-404-7676', 'tmart14@yahoo.com', '2000-1-25', 'tmar14', 'password'),
(15, 'Alex', 'Williams', '608 Washington Way', '821-444-5916', 'awill15@hotmail.com', '1999-3-9', 'awil15', 'password'),
(16, 'Mary', 'Smith', '184 Main Way', '624-421-4441', 'msmit16@hotmail.com', '1996-5-28', 'msmi16', 'password'),
(17, 'Thomas', 'Brown', '348 Hill Ln', '844-368-1350', 'tbrow17@yahoo.com', '1999-2-28', 'tbro17', 'password'),
(18, 'John', 'White', '158 Hill Pl', '317-940-8139', 'jwhit18@outlook.com', '1995-3-28', 'jwhi18', 'password'),
(19, 'Thomas', 'Jones', '741 Lake Ave', '541-666-4598', 'tjone19@hotmail.com', '2001-3-18', 'tjon19', 'password'),
(20, 'Matthew', 'Jones', '142 Main Way', '835-711-8605', 'mjone20@outlook.com', '2000-3-2', 'mjon20', 'password');
INSERT INTO PROFESSOR VALUES
(1, 'Peter', 'Brown', '991 Cedar Blvd', '475-833-5709', 'pbrow1@gmail.com', 2, 'pbrown1', 'password'),
(2, 'Matthew', 'White', '605 High Cir', '293-937-6358', 'mwhit2@hotmail.com', 3, 'mwhite2', 'password'),
(3, 'Mary', 'Anderson', '982 Elm St', '660-496-6400', 'mande3@yahoo.com', 3, 'manderson3', 'password'),
(4, 'Paul', 'Williams', '846 Hill St', '646-204-3272', 'pwill4@yahoo.com', 1, 'pwilliams4', 'password'),
(5, 'Peter', 'Smith', '702 Main Cir', '389-122-2643', 'psmit5@yahoo.com', 2, 'psmith5', 'password');
INSERT INTO COURSE (course_name, course_instructor_id, start_time, end_time, room_number) VALUES
('Chemistry', 3, '17:02:00', '17:50:00', 597),
('Computer Science', 2, '14:35:00', '17:25:00', 581),
('Computer Science', 5, '08:05:00', '11:40:00', 675),
('Mathematics', 5, '17:47:00', '17:13:00', 272),
('English', 2, '14:03:00', '14:45:00', 715),
('Physics', 1, '08:21:00', '09:44:00', 577),
('Chemistry', 5, '17:46:00', '17:19:00', 458),
('Mathematics', 5, '10:50:00', '13:37:00', 140),
('English', 1, '16:34:00', '18:33:00', 700),
('English', 3, '11:58:00', '16:47:00', 731);
INSERT INTO ENROLLMENT (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 3, 'C'),
(1, 3, 'C'),
(1, 9, 'A'),
(1, 6, 'F'),
(2, 4, 'F'),
(2, 2, 'A'),
(2, 1, 'F'),
(2, 7, 'D'),
(2, 5, 'C'),
(3, 9, 'F'),
(3, 1, 'F'),
(3, 6, 'A'),
(3, 9, 'F'),
(3, 1, 'A'),
(4, 3, 'F'),
(4, 3, 'D'),
(4, 7, 'B'),
(4, 1, 'D'),
(4, 5, 'A'),
(5, 8, 'A'),
(5, 1, 'F'),
(5, 7, 'B'),
(5, 5, 'F'),
(5, 5, 'D'),
(6, 6, 'C'),
(6, 5, 'D'),
(6, 6, 'D'),
(6, 3, 'A'),
(6, 9, 'B'),
(7, 3, 'F'),
(7, 1, 'D'),
(7, 7, 'F'),
(7, 3, 'D'),
(7, 2, 'F'),
(8, 5, 'C'),
(8, 5, 'F'),
(8, 1, 'C'),
(8, 6, 'D'),
(8, 7, 'B'),
(9, 9, 'D'),
(9, 6, 'A'),
(9, 1, 'F'),
(9, 2, 'D'),
(9, 5, 'D'),
(10, 5, 'C'),
(10, 1, 'B'),
(10, 4, 'B'),
(10, 5, 'A'),
(10, 5, 'B'),
(11, 8, 'B'),
(11, 7, 'C'),
(11, 5, 'F'),
(11, 2, 'F'),
(11, 2, 'F'),
(12, 5, 'A'),
(12, 2, 'D'),
(12, 2, 'F'),
(12, 4, 'D'),
(12, 4, 'C'),
(13, 1, 'C'),
(13, 6, 'C'),
(13, 2, 'F'),
(13, 9, 'B'),
(13, 7, 'B'),
(14, 7, 'D'),
(14, 8, 'B'),
(14, 9, 'B'),
(14, 1, 'D'),
(14, 5, 'C'),
(15, 5, 'B'),
(15, 2, 'F'),
(15, 3, 'B'),
(15, 6, 'D'),
(15, 2, 'C'),
(16, 2, 'F'),
(16, 7, 'B'),
(16, 7, 'A'),
(16, 2, 'C'),
(16, 8, 'D'),
(17, 9, 'D'),
(17, 4, 'C'),
(17, 2, 'C'),
(17, 9, 'C'),
(17, 9, 'F'),
(18, 6, 'F'),
(18, 8, 'F'),
(18, 9, 'A'),
(18, 9, 'C'),
(18, 4, 'A'),
(19, 3, 'D'),
(19, 9, 'A'),
(19, 9, 'F'),
(19, 2, 'A'),
(19, 2, 'B'),
(20, 3, 'C'),
(20, 3, 'C'),
(20, 6, 'A'),
(20, 3, 'C'),
(20, 6, 'D');