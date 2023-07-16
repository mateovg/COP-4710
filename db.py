import pymysql.cursors

# Connect to the database
connection = pymysql.connect(host='localhost',
                             user='root',
                             password='root',
                             db='abcuniversity',
                             cursorclass=pymysql.cursors.DictCursor)

cursor = connection.cursor()


def execute_query(query):
    print("executing query: " + query)
    cursor.execute(query)
    connection.commit()
    return cursor


def attempt_login(username, password):
    query = f"""
    SELECT type FROM LOGIN WHERE username = '{username}' AND password = '{password}';
    """
    account = execute_query(query).fetchone()
    if account:
        return account['type']
    else:
        return 'Invalid'


def get_account(user_type, username):
    query = f"""
    SELECT * FROM {user_type} WHERE {user_type}_username = '{username}';
    """
    account = execute_query(query).fetchone()
    return account


def account_exists(username):
    query = f"""
    SELECT * FROM LOGIN WHERE username = '{username}';
    """
    account = execute_query(query).fetchone()
    if account is not None:
        return True
    else:
        return False


def register_account(fname, lname, username, password, user_type):
    query = f"""
    INSERT INTO {user_type} ({user_type}_fname, {user_type}_lname, {user_type}_username, {user_type}_password)
    VALUES ('{fname}', '{lname}', '{username}', '{password}');
    """
    execute_query(query)


def get_grades(user_type, user_id):
    if user_type == 'student':
        # grades for courses the student in enrolled in
        query = f"""
        SELECT c.course_name, c.course_id, e.grade, c.start_time, c.end_time, c.room_number
        FROM COURSE as c, ENROLLMENT as e
        WHERE e.student_id = {user_id} AND c.course_id = e.course_id;
        """
    elif user_type == 'professor':
        # grades for courses the professor teaches, grouped by course
        query = f"""
        SELECT c.course_name, c.course_id, e.student_id, s.student_fname, s.student_lname, e.grade
        FROM COURSE as c, ENROLLMENT as e, STUDENT as s
        WHERE c.course_instructor_id = {user_id} AND c.course_id = e.course_id AND e.student_id = s.student_id;
        """
    cursor = execute_query(query)
    grades = cursor.fetchall()

    return grades


def get_courses(user_type, user_id):
    # return classes student is not enrolled in
    if user_type == 'student':
        query = f"""
        SELECT c.course_id, c.course_name, p.professor_lname, c.start_time, c.end_time, c.room_number
        FROM COURSE as c, PROFESSOR as p
        WHERE c.course_id NOT IN
        ( SELECT e.course_id FROM ENROLLMENT as e WHERE e.student_id = {user_id} )
        AND c.course_instructor_id = p.professor_id; 
        """
    # return classes taught by professor, with students enrolled and grades
    elif user_type == 'professor' or user_type == 'admin':
        query = f"""
        SELECT c.course_name, c.course_id, e.student_id, s.student_fname, s.student_lname, e.grade
        FROM COURSE as c, ENROLLMENT as e, STUDENT as s
        WHERE c.course_instructor_id = {user_id} AND c.course_id = e.course_id AND e.student_id = s.student_id;
        """
    cursor = execute_query(query)
    courses = cursor.fetchall()
    return courses


def add_course(account_id, course_id):
    # only for students, check if course exists and student is not already enrolled
    # this was a pain to get working, but it works now
    query = f"""
    INSERT INTO ENROLLMENT (student_id, course_id)
    SELECT {account_id}, {course_id}
    FROM COURSE WHERE course_id = {course_id}
    AND NOT EXISTS ( SELECT * FROM ENROLLMENT WHERE student_id = {account_id} AND course_id = {course_id} );
    """
    execute_query(query)


def drop_course(account_id, course_id):
    # only for students
    query = f"""
    DELETE FROM ENROLLMENT
    WHERE student_id = {account_id} AND course_id = {course_id};
    """
    execute_query(query)


def update_grade(student_id, course_id, new_grade):
    # only for professors
    query = f"""
    UPDATE ENROLLMENT
    SET grade = '{new_grade}'
    WHERE student_id = {student_id} AND course_id = {course_id};
    """
    execute_query(query)


def admin_view():
    # only for admins
    # shows grades for all students, grouped by student
    students = select_all('STUDENT')
    professors = select_all('PROFESSOR')
    courses = select_all('COURSE')

    return students, professors, courses


def select_all(table):
    query = f"""
    SELECT * FROM {table};
    """
    cursor = execute_query(query)
    return cursor.fetchall()
