import DatabaseHandler


class App:

    def __init__(self):
        self.username = ''
        self.user_type = ''
        self.loggedin = False
        self.account = ''
        self.db = DatabaseHandler.DatabaseHandler()

    def welcome(self):
        print('Welcome to ABC University!')
        print('1. Login')
        print('2. Register as student')
        print('3. Register as professor')
        print('4. Exit')
        choice = input('Enter your choice: ')

        if choice == '1':
            self.login()
        elif choice == '2':
            user_type = 'student'
            self.register('student')
        elif choice == '3':
            user_type = 'professor'
            self.register('professor')
        elif choice == '4':
            exit()

    def login(self):
        print('Login')
        user = input('Enter username: ')
        password = input('Enter password: ')

        # check if credentials are correct
        # if correct, set self.loggedin to True
        # then find user type

        query = f"""
        SELECT type FROM LOGIN WHERE username = '{user}' AND password = '{password}';
        """
        cursor = self.db.execute_sql_query(query)
        account = cursor.fetchone()

        # correct credentials
        if account:
            self.loggedin = True
            self.username = user
            self.user_type = account[0]

            # get account info
            query = f"""
            SELECT * FROM {self.user_type} WHERE {self.user_type}_username = '{user}';
            """
            cursor = self.db.execute_sql_query(query)
            self.account = cursor.fetchone()

            print(self.account)

            self.dashboard()
        else:
            print('Incorrect username/password!')
            self.welcome()

    def logout(self):
        self.loggedin = False
        self.username = ''
        self.user_type = ''
        self.account = ''
        self.welcome()

    def register(self, user_type):
        print('Register')

        fname = input('Enter first name: ')
        lname = input('Enter last name: ')
        username = input('Enter username: ')
        password = input('Enter password: ')

        query = f"""
        INSERT INTO {user_type} ({user_type}_fname, {user_type}_lname, {user_type}_username, {user_type}_password)
        VALUES ('{fname}', '{lname}', '{username}', '{password}');
        """

        self.db.execute_sql_query(query)

        print('Account created successfully! Please login.')
        self.login()

    def dashboard(self):
        print('Dashboard')
        if self.user_type == 'student':
            self.student_dashboard()
        elif self.user_type == 'professor':
            self.professor_dashboard()

    def student_dashboard(self):
        print('1. View grades')
        print('2. Add class')
        print('3. Remove class')
        print('4. Logout')
        choice = input('Enter your choice: ')

        if choice == '1':
            self.view_grades()
        elif choice == '2':
            self.add_class()
        elif choice == '3':
            self.remove_class()
        elif choice == '4':
            self.logout()

    def professor_dashboard(self):
        print('1. View classes')
        print('2. Update grade')
        print('3. Logout')
        choice = input('Enter your choice: ')

        if choice == '1':
            self.view_classes()
        elif choice == '2':
            self.update_grade()
        elif choice == '3':
            self.logout()

    def view_grades(self):
        """
        View grades for a student
        """
        id = self.account[0]  # student id
        query = f"""
        SELECT course_name, grade 
        FROM ENROLLMENT, COURSE 
        WHERE student_id = {id} AND ENROLLMENT.course_id = COURSE.course_id;
        """
        cursor = self.db.execute_sql_query(query)
        grades = cursor.fetchall()

        for grade in grades:
            # translate course id to course name
            course_name, stu_grade = grade[0], grade[1]
            print(f'{course_name}: {stu_grade}')
        self.dashboard()

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
