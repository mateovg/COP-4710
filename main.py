# from geeksforgeeks.org tutorial
from flask import Flask, render_template, request, redirect, url_for, session
import DatabaseHandler

# create the application object
app = Flask(__name__)


class Session:
    def __init__(self):
        self.loggedin = False
        self.username = ''
        self.user_type = ''
        self.account = ''
        self.account_id = ''
        self.db = DatabaseHandler.DatabaseHandler()


session = Session()


@app.route('/')
def index():
    if session.loggedin:
        return redirect(url_for(session.user_type))
    return render_template('index.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    if session.loggedin:
        return redirect(url_for('index'))
    msg = ''
    # correctly provides username and password
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # check if the username and password are correct
        user = request.form['username']
        password = request.form['password']

        # query returns user_type, which is used to determine which page to redirect to
        query = f"""
        SELECT type FROM LOGIN WHERE username = '{user}' AND password = '{password}';
        """
        account = session.db.execute_sql_query(query).fetchone()

        # correct credentials
        if account:
            session.loggedin = True
            session.username = user
            session.user_type = account[0]  # account[0] is the user_type

            # get account info
            query = f"""
            SELECT * FROM {session.user_type} WHERE {session.user_type}_username = '{user}';
            """
            session.account = session.db.execute_sql_query(query).fetchone()
            session.account_id = session.account[0]
            msg = 'Logged in successfully!'
            print(f"{msg} \n {session.account}")
            return redirect(url_for('index'))
        else:
            msg = 'Incorrect username/password!'

    return render_template('login.html', msg=msg)


# add new student to the database
@app.route('/register', methods=['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST':
        fname = request.form['fname']
        lname = request.form['lname']
        username = request.form['username']
        password = request.form['password']
        user_type = request.form['user_type']

        # check if account already exists
        query = f"""
        SELECT * FROM LOGIN WHERE username = '{username}';
        """
        account = session.db.execute_sql_query(query).fetchone()
        if account:
            msg = 'Account already exists!'
            return render_template('register.html', msg=msg)
        # create the new account
        else:
            query = f"""
            INSERT INTO {user_type} ({user_type}_fname, {user_type}_lname, {user_type}_username, {user_type}_password)
            VALUES ('{fname}', '{lname}', '{username}', '{password}');
            """
            session.db.execute_sql_query(query)
            msg = 'Account created successfully! Please login.'
            return render_template('login.html', msg=msg)
    return render_template('register.html', msg=msg)


# page for students to view their grades/available classes
@app.route('/student', methods=['GET', 'POST'])
def student():
    # if not logged in, redirect to login page
    if not session.loggedin:
        return redirect(url_for('login'))

    # show current courses and grades
    grades = session.db.get_grades(session.user_type, session.account_id)
    # show available courses
    courses = session.db.get_courses(session.user_type, session.account_id)

    # student can add or drop courses

    return render_template('student.html')

# page for professors to view the grades of students in their classes


@app.route('/professor', methods=['GET', 'POST'])
def professor():
    # if not logged in, redirect to login page
    if not session.loggedin:
        return redirect(url_for('login'))

    # show current courses and grades
    grades = session.db.get_grades(session.user_type, session.account_id)

    # professor can update grades in courses

    return render_template('professor.html')

# page for admins to view all grades/available classes


@app.route('/admin', methods=['GET', 'POST'])
def admin():
    grades = session.db.admin_view()

    # allow admin to add or drop courses

    # allow admin to add or drop students

    # allow admin to edit grades

    return render_template('admin.html')


if __name__ == '__main__':
    app.run(debug=True)
