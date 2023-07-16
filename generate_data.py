import random
from datetime import time

# random list of first names
NAMES = ['John', 'Matthew', 'Thomas', 'Paul',
         'Peter', 'Mary', 'Elizabeth', 'Amber', 'Alex']
# random list of last names
LAST_NAMES = ['Smith', 'Jones', 'Williams', 'Brown',
              'Wilson', 'Taylor', 'White', 'Martin', 'Anderson']
# random list of street names
STREET_NAMES = ['Main', 'High', 'Oak', 'Pine',
                'Cedar', 'Elm', 'Washington', 'Lake', 'Hill']
# random list of street types
STREET_TYPES = ['St', 'Ave', 'Blvd', 'Rd', 'Dr', 'Cir', 'Pl', 'Ln', 'Way']
# random list of email provprof_iders
EMAIL_PROVIDERS = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com']

COURSES = ["Mathematics", "Physics",
           "Chemistry", "Computer Science", "English"]

# wrapper to add quotes to strings for sql


def sql_format(func):
    def inner(*args):
        return "'" + func(*args) + "'"
    return inner


@sql_format
def random_name():
    """ Return a random name from the NAMES list """
    return str(random.choice(NAMES))


@sql_format
def random_last_name():
    """ Return a random last name from the LAST_NAMES list """
    return str(random.choice(LAST_NAMES))


@sql_format
def random_address():
    """ Return a random address from the STREET_NAMES and STREET_TYPES list """
    return str(random.randint(1, 999)) + ' ' + random.choice(STREET_NAMES) + ' ' + random.choice(STREET_TYPES)


@sql_format
def random_phone():
    """ Return a random phone number """
    return str(random.randint(100, 999)) + "-" + str(random.randint(100, 999)) + "-" + str(random.randint(1000, 9999))


@sql_format
def random_email(name, last_name, prof_id):
    """ Return a random email address """
    return name.lower()[1] + last_name.lower()[1:5] + \
        str(prof_id) + "@" + random.choice(EMAIL_PROVIDERS)


@sql_format
def random_dob():
    """ Return a random date of birth """
    return str(random.randint(1995, 2005)) + '-' + str(random.randint(1, 12)) + '-' + str(random.randint(1, 28))


def create_students(n: int):
    """ Create a sql script to insert n students into the database """
    # open file
    with open('data.sql', 'w') as f:
        f.write('INSERT INTO STUDENT VALUES\n')
        for i in range(n):
            stu_id = str(i + 1)
            name = random_name()
            last_name = random_last_name()
            email = random_email(name, last_name, stu_id)
            address = random_address()
            phone = random_phone()
            dob = random_dob()
            username = name.lower()[:2] + \
                last_name.lower()[1:4] + str(stu_id) + "'"
            password = "'password'"
            data = '(' + stu_id + ', ' + name + ', ' + last_name + ', ' + address + ', ' + \
                phone + ', ' + email + ', ' + dob + ', ' + username + ', ' + password + '),\n'
            if i == n - 1:
                data = data[:-2] + ';'
            f.write(data)


def create_professor(n: int):
    with open('data.sql', 'a') as f:
        f.write('\nINSERT INTO PROFESSOR VALUES\n')
        for i in range(n):
            prof_id = str(i + 1)
            name = random_name()
            last_name = random_last_name()
            email = random_email(name, last_name, prof_id)
            address = random_address()
            phone = random_phone()
            dept_prof_id = str(random.randint(1, 3))
            username = name.lower()[:2] + \
                last_name.lower()[1:-1] + str(prof_id) + "'"
            password = "'password'"
            data = '(' + prof_id + ', ' + name + ', ' + last_name + ', ' + address + ', ' + \
                phone + ', ' + email + ', ' + dept_prof_id + \
                ', ' + username + ', ' + password + '),\n'
            if i == n - 1:
                data = data[:-2] + ';'
            f.write(data)


def create_enrollment(n: int):
    courses = [str(i) for i in range(1, 10)]
    students = [str(i) for i in range(1, n+1)]
    grades = ['A', 'B', 'C', 'D', 'F']
    # randomly assign each student to 5 courses with a random grade
    with open('data.sql', 'a') as f:
        f.write('\nINSERT INTO ENROLLMENT (student_id, course_id, grade) VALUES\n')
        for student in students:
            # choose 5 with no replacement
            student_courses = random.sample(courses, 5)
            for i in range(5):
                grade = random.choice(grades)
                data = '(' + student + ', ' + student_courses[i] + \
                    ', \'' + grade + '\'),\n'
                if student == students[-1] and i == 4:
                    data = data[:-2] + ';'
                f.write(data)


def create_courses(n: int):
    with open('data.sql', 'a') as f:
        f.write('\nINSERT INTO COURSE (course_name, course_instructor_id, start_time, end_time, room_number) VALUES\n')
        for i in range(n):
            course_name = random.choice(COURSES)
            course_instructor_id = str(random.randint(1, 5))
            # Random hour and minute from 8:00 to 17:59
            start_time = time(random.randint(8, 17), random.randint(0, 59))
            # Random hour and minute from start_time to 18:59
            end_time = time(random.randint(
                start_time.hour, 18), random.randint(0, 59))
            room_number = str(random.randint(101, 999))
            data = "('" + course_name + "', " + course_instructor_id + ", '" + \
                str(start_time) + "', '" + str(end_time) + \
                "', " + room_number + "),\n"
            if i == n - 1:
                data = data[:-2] + ';'
            f.write(data)


create_students(20)
create_professor(5)
create_courses(10)
create_enrollment(20)
