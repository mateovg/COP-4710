def view_grades(id, db):
    """
    Returns grades for a student given their id.
    Format is (course_name, grade)
    """
    query = f"""
    SELECT course_name, grade 
    FROM ENROLLMENT, COURSE 
    WHERE student_id = {id} AND ENROLLMENT.course_id = COURSE.course_id;
    """
    cursor = db.execute_sql_query(query)
    grades = cursor.fetchall()

    return grades


def get_classes(self):
    # return classes student is enrolled in
    if self.user_type == 'student':
        #
        query = f"""
        SELECT c.course_name, c.course_id, e.grade, c.start_time, c.end_time, c.room_number
        FROM COURSE as c, ENROLLMENT as e
        WHERE e.student_id = {self.account[0]} AND c.course_id = e.course_id;
        """
    # return classes taught by professor, with students enrolled and grades
    elif self.user_type == 'professor':
        query = f"""
        SELECT c.course_name, c.course_id, e.student_id, s.student_fname, s.student_lname, e.grade
        FROM COURSE as c, ENROLLMENT as e, STUDENT as s
        WHERE c.course_instructor_id = {self.account[0]} AND c.course_id = e.course_id AND e.student_id = s.student_id;
        """
    cursor = self.db.execute_sql_query(query)
    courses = cursor.fetchall()
    return courses


def add_class(self):
    """
    show available classes and add a class
    """
    # classes the student is not in
    query = f"""
    SELECT c.course_id, c.course_name, c.start_time, c.end_time, c.room_number
    FROM COURSE as c
    WHERE c.course_id NOT IN 
    (SELECT e.course_id FROM ENROLLMENT as e WHERE e.student_id = {self.account[0]});
    """

    cursor = self.db.execute_sql_query(query)
    courses = cursor.fetchall()

    # print available classes
    print('Available classes:')
    format = '%-10s %-15s %-10s %-10s %-10s'
    print(format %
          ('Course ID', 'Course Name', 'Start Time', 'End Time', 'Room'))
    for course in courses:
        course_id, course_name = course[0], course[1]
        course_start, course_end = course[2], course[3]
        course_room = course[4]

        print(format %
              (course_id, course_name, course_start, course_end, course_room))

    # get user input
    course_id = input('Enter course id: ')

    # add class
    query = f"""
    INSERT INTO ENROLLMENT (student_id, course_id) VALUES ({self.account[0]}, {course_id});
    """
    self.db.execute_sql_query(query)
    self.dashboard()


def remove_class(self):
    """
    show classes student is enrolled in and remove a class
    """
    courses = self.get_classes()

    # print enrolled classes
    print('Enrolled classes:')
    format = '%-10s %-15s %-10s %-10s %-10s %-10s'
    print(format %
          ('Course ID', 'Course Name', 'Grade', 'Start Time', 'End Time', 'Room'))
    for course in courses:
        course_id, course_name = course[1], course[0]
        grade = course[2]
        course_start, course_end = course[3], course[4]
        course_room = course[5]

        print(format %
              (course_id, course_name, grade, course_start, course_end, course_room))

    # get user input
    course_id = input('Enter course id: ')

    # remove class
    query = f"""
    DELETE FROM ENROLLMENT WHERE student_id = {self.account[0]} AND course_id = {course_id};
    """
    self.db.execute_sql_query(query)
    self.dashboard()


def view_classes(self):
    """
    show students and grades for a class the professor teaches
    """
    courses = self.get_classes()
    print('%-10s %-10s %-10s %-10s %-10s' % ('Course Name',
                                             'Course ID', 'Student ID', 'Student Name', 'Grade'))
    for course in courses:
        course_name, course_id = course[0], course[1]
        student_id, student_name = course[2], course[3] + ' ' + course[4]
        grade = course[5]
        print('%-10s %-10s %-10s %-10s %-10s' %
              (course_name, course_id, student_id, student_name, grade))
    self.dashboard()


def update_grade(self):
    """
    update a student's grade for a class
    """

    self.view_classes()
    course_id = input('Enter course id: ')
    student_id = input('Enter student id: ')
    grade = input('Enter grade: ')

    query = f"""
    UPDATE ENROLLMENT SET grade = {grade} WHERE student_id = {student_id} AND course_id = {course_id};
    """

    self.db.execute_sql_query(query)
    self.dashboard()
