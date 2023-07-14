import mysql.connector

"""
Handles the connection to the database and executes queries
"""


class DatabaseHandler:
    def __init__(self):
        self.config = {
            'user': 'root',
            'password': 'root',
            'host': '127.0.0.1',
            'database': 'abcuniversity'
        }
        try:
            self.cnx = mysql.connector.connect(**self.config)
        except mysql.connector.Error as err:
            print(err)

        self.cursor = self.cnx.cursor(buffered=True)

    def execute_sql_query(self, query):
        self.cursor.execute(query)
        self.cnx.commit()
        return self.cursor

    def close(self):
        self.cursor.close()
        self.cnx.close()

    def get_grades(self, user_type, account_id):
        """
        Returns grades for a student given their id.
        Format is (course_name, grade)
        """
        if user_type == 'student':
            # grades for courses the student in enrolled in
            query = f"""
            SELECT c.course_name, c.course_id, e.grade, c.start_time, c.end_time, c.room_number
            FROM COURSE as c, ENROLLMENT as e
            WHERE e.student_id = {account_id} AND c.course_id = e.course_id;
            """
        elif user_type == 'professor':
            # grades for courses the professor teaches, grouped by course
            query = f"""
            SELECT c.course_name, c.course_id, e.student_id, s.student_fname, s.student_lname, e.grade
            FROM COURSE as c, ENROLLMENT as e, STUDENT as s
            WHERE c.course_instructor_id = {account_id} AND c.course_id = e.course_id AND e.student_id = s.student_id;
            """
        cursor = self.execute_sql_query(query)
        grades = cursor.fetchall()

        return grades

    def get_courses(self, user_type, account_id):
        # return classes student is not enrolled in
        if user_type == 'student':
            #
            query = f"""
            SELECT c.course_id, c.course_name, c.start_time, c.end_time, c.room_number
            FROM COURSE as c
            WHERE c.course_id NOT IN
            (SELECT e.course_id FROM ENROLLMENT as e WHERE e.student_id = {account_id});) 
            """
        # return classes taught by professor, with students enrolled and grades
        elif user_type == 'professor' or user_type == 'admin':
            query = f"""
            SELECT c.course_name, c.course_id, e.student_id, s.student_fname, s.student_lname, e.grade
            FROM COURSE as c, ENROLLMENT as e, STUDENT as s
            WHERE c.course_instructor_id = {account_id} AND c.course_id = e.course_id AND e.student_id = s.student_id;
            """
        cursor = self.execute_sql_query(query)
        courses = cursor.fetchall()
        return courses

    def add_course(self, account_id, course_id):
        # only for students
        query = f"""
        INSERT INTO ENROLLMENT (student_id, course_id)
        VALUES ({account_id}, {course_id});
        """
        self.execute_sql_query(query)

    def drop_course(self, account_id, course_id):
        # only for students
        query = f"""
        DELETE FROM ENROLLMENT
        WHERE student_id = {account_id} AND course_id = {course_id};
        """
        self.execute_sql_query(query)

    def update_grade(self, student_id, course_id, new_grade):
        # only for professors
        query = f"""
        UPDATE ENROLLMENT
        SET grade = {new_grade}
        WHERE student_id = {student_id} AND course_id = {course_id};
        """
        self.execute_sql_query(query)

    def admin_view(self):
        # only for admins
        # shows grades for all students, grouped by student
        query = f"""
        SELECT s.student_lname, s.student_fname, s.student_id, c.course_name, c.course_id, p.professor_lname, e.grade
        FROM student as s, enrollment as e, course as c, professor as p
        WHERE s.student_id = e.student_id AND c.course_id = e.course_id AND c.course_instructor_id = p.professor_id and e.grade IS NOT NULL
        ORDER BY s.student_id;
        """
        cursor = self.execute_sql_query(query)
        grades = cursor.fetchall()
        return grades
