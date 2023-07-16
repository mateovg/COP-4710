# from geeksforgeeks.org tutorial
from flask import Flask, render_template, request, redirect, url_for, session
import db

# create the application object
app = Flask(__name__)
app.secret_key = 'super secret key'


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/login', methods=['GET', 'POST'])
def login():
    msg = ''
    if request.method == 'POST':
        print(request.form)
        # check if the username and password are correct
        user = request.form['username']
        password = request.form['password']
        user_type = db.attempt_login(user, password)

        if user_type == 'Invalid':
            msg = 'Incorrect username/password!'
            return render_template('login.html', msg=msg)

        else:
            # if the username and password are correct, log the user in
            session['account'] = db.get_account(user_type, user)
            session['username'] = user
            session['user_type'] = user_type
            session['name'] = session['account'][f'{user_type}_fname'] + \
                " " + session['account'][f'{user_type}_lname']
            session['account_id'] = session['account'][f'{user_type}_id']

            return redirect(url_for('dashboard'))

    return render_template('login.html', msg=msg)


@app.route('/logout')
def logout():
    session.pop('username', None)  # removes username from session dict
    return redirect(url_for('index'))


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

        if db.account_exists(username):
            msg = 'Account already exists!'
            return render_template('register.html', msg=msg)
        # create the new account
        else:
            db.register_account(fname, lname, username, password, user_type)
            msg = 'Account created successfully! Please login.'
            return redirect(url_for('login'))
    return render_template('register.html', msg=msg)


# page for students to view their grades/available classes
@app.route('/student', methods=['GET'])
def student():
    if 'username' not in session:  # if not logged in, redirect to login page
        return redirect(url_for('login'))
    # show current courses and grades
    grades = db.get_grades(session['user_type'], session['account_id'])
    # show available courses
    courses = db.get_courses(session['user_type'], session['account_id'])

    return render_template('student.html', grades=grades, courses=courses, name=session['name'])

# page for professors to view the grades of students in their classes


@app.route('/professor', methods=['GET', 'POST'])
def professor():
    if 'username' not in session:  # if not logged in, redirect to login page
        return redirect(url_for('login'))
    # show current courses and grades
    grades = db.get_grades(session['user_type'], session['account_id'])

    return render_template('professor.html', grades=grades, name=session['name'])

# page for admins to view all grades/available classes


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if 'username' not in session:  # if not logged in, redirect to login page
        return redirect(url_for('login'))

    user_type = session['user_type']
    return redirect(url_for(user_type))


@app.route('/drop_class', methods=['POST'])
def drop_class():
    course_id = request.form['course_id']
    db.drop_course(session['account_id'], course_id)

    return redirect(url_for('student'))


@app.route('/add_class', methods=['POST'])
def add_class():
    course_id = request.form['course_id']
    db.add_course(session['account_id'], course_id)

    return redirect(url_for('student'))


@app.route('/update_grade', methods=['POST'])
def update_grades():
    course_id = request.form['course_id']
    student_id = request.form['student_id']
    new_grade = request.form['new_grade']

    db.update_grade(student_id, course_id, new_grade)

    return redirect(url_for('professor'))


if __name__ == '__main__':
    app.run(debug=True)
