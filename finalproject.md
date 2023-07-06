# Final Project

## Requirements

A register and login page for a university database system to keep traack of student records.

User-friendly system for students to register their details.

## Tasks

1. Create a Conceptual E-R Model for the database.
2. Create a Relational Model for the Database is MySQL.
3. Use SQL for **registrations** and **login of a student**.
   1. Select, insert, update, and delete.
   2. At least six SQL queries to retrieve information from student table based on specific criteria. ex, name of all students in the table
   3. One SQL statement to insert data into the student table.
   4. One SQL query to update data in the student table base don student's ID
   5. One SQL query to delete a student based on their ID.
4. Create a simple GUI for an Application.
   1. Using any programming language.
   2. PyMySQL
5. Perform Select, Insert, Update, and Delete statements through GUI.

## Deliverables.

1. All entity names and their columns and other information.
2. Perform task 1, capture an image of the LucidChartt's conceptual ER model.
3. Perform task 2, add a dtabase diagram for your tables and their relationships in MySQL. Add all the SQL code related to creating the relational model for the db in mysql.
4. Perform task 3, write all SQL queries for SELECT, INSERT, UPDATE, and DELETE statements of the sytem's register and login pages.
5. Perform task 4 and write what language you used. What Connectivity API did you use. What is your connection string. Why did you use this langauge. Capture the screen of hte register and login page of the app you designed.
6. Include all the source codes related to performing SELECT, INSERT, UPDATE, and DELETE statements for the rsiger and login page. Show SQL commands in MySQL and the commandsiin python.
7. Write any limitations and bugs your system includes. Add a capture screen of your issues in the following section.
8. Obstables, issues, problems, difficulties, encoutnered during design development, implementaiton, and demonstration.
9. Make a video screen of your working system in which you demonstrate your dateabase design, diagrams, tables, relationships, and sfotware appication for register and login functions.
   1. Add your name, surname, and other requrired information to the MySQL database through your register.
   2. Perform SELECT, INSERT, UPDATE, and DELETE statements via the GUI.
   3. Go to the MySQL database and show that your command has been successfully operated.
   4. Add your source code, all documents and related files in a ZIP file and upload three files to canvas
      1. Video demonstration
      2. ZIP file
      3. filled in version of this word document.

## Schema

At least six entities.

- `STUDENT( Student ID, First Name, Last Name, Address, Phone NUmber, Email, Date of Birth)`
- `COURSE( Course ID, Course Name, Instructor Name, Start Time, End Time, Room Number) `
- `ENROLLMENT( Enrollment ID, Student ID, Course ID, Grade)`
- `SCHEDULE( Student ID, Course ID, Start Time, End Time, Room Number) `
- `DEPARTMENT( Department ID, Department Name)`
- `Professor( Professor ID, First Name, Last Name, Address, Phone Number, Email)`
