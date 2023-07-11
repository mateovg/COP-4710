import random

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

# CREATE TABLE STUDENT (
#     student_prof_id INT NOT NULL,
#     student_fname VARCHAR(20) NOT NULL,
#     student_lname VARCHAR(20) NOT NULL,
#     student_address VARCHAR(50) NOT NULL,
#     student_phone VARCHAR(20) NOT NULL,
#     student_email VARCHAR(20) NOT NULL,
#     student_dob DATE NOT NULL,
#     PRIMARY KEY (student_prof_id)
# );

# wrapper to add quotes to strings for sql


def wrapper(func):
    def inner(*args):
        return "'" + func(*args) + "'"
    return inner


@wrapper
def random_name():
    """ Return a random name from the NAMES list """
    return str(random.choice(NAMES))


@wrapper
def random_last_name():
    """ Return a random last name from the LAST_NAMES list """
    return str(random.choice(LAST_NAMES))


@wrapper
def random_address():
    """ Return a random address from the STREET_NAMES and STREET_TYPES list """
    return str(random.randint(1, 999)) + ' ' + random.choice(STREET_NAMES) + ' ' + random.choice(STREET_TYPES)


@wrapper
def random_phone():
    """ Return a random phone number """
    return str(random.randint(100, 999)) + "-" + str(random.randint(100, 999)) + "-" + str(random.randint(1000, 9999))


@wrapper
def random_email(name, last_name, prof_id):
    """ Return a random email address """
    return name.lower()[1] + last_name.lower()[1:5] + \
        str(prof_id) + "@" + random.choice(EMAIL_PROVIDERS)


def random_dob():
    """ Return a random date of birth """
    return str(random.randint(1995, 2005)) + '-' + str(random.randint(1, 12)) + '-' + str(random.randint(1, 28))


def create_students(n: int):
    """ Create a sql script to insert n students into the database """
    # open file
    with open('data.sql', 'w') as f:
        f.write('INSERT INTO STUDENT VALUES\n')
        for i in range(n):
            prof_id = str(i + 1)
            name = random_name()
            last_name = random_last_name()
            email = random_email(name, last_name, prof_id)
            address = random_address()
            phone = random_phone()
            dob = random_dob()
            username = name.lower()[:2] + \
                last_name.lower()[1:4] + str(prof_id) + "'"
            password = "'password'"
            data = '(' + prof_id + ', ' + name + ', ' + last_name + ', ' + address + ', ' + \
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
                last_name.lower()[1:4] + str(prof_id) + "'"
            password = "'password'"
            data = '(' + prof_id + ', ' + name + ', ' + last_name + ', ' + address + ', ' + \
                phone + ', ' + email + ', ' + dept_prof_id + \
                ', ' + username + ', ' + password + '),\n'
            if i == n - 1:
                data = data[:-2] + ';'
            f.write(data)


create_students(10)
create_professor(3)
