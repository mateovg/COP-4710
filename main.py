# from geeksforgeeks.org tutorial
from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import re

# create the application object
app = Flask(__name__)

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'root'
app.config['MYSQL_DB'] = 'abcuniversity'

mysql = MySQL(app)

# home page


@app.route('/')
def index():
    return render_template('index.html')

# login page
# from the realpython.com tutorial


@app.route('/login', methods=['GET', 'POST'])
def login():
    # correctly provides username and password
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        # check if the username and password are correct
        user = request.form['username']
        password = request.form['password']

        # check if it's an admin account
        if user == 'admin' and password == 'admin':
            session['loggedin'] = True
            session['username'] = 'admin'
            msg = 'Logged in successfully!'
            return redirect(url_for('index'), msg=msg)

        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        # check if it's a student account
        cursor.execute(
            'SELECT * FROM STUDENT WHERE student_username = %s AND student_password = %s', (
                user, password)
        )
        account = cursor.fetchone()
        # if it's not a student account, check if it's a professor account
        if account is None:
            cursor.execute(
                'SELECT * FROM PROFESSOR WHERE professor_username = %s AND professor_password = %s', (
                    user, password)
            )
            account = cursor.fetchone()

        if account:
            session['loggedin'] = True
            session['username'] = account['username']
            msg = 'Logged in successfully!'
            return redirect(url_for('index'), msg=msg)
        else:
            msg = 'Incorrect username/password!'
            return render_template('login.html', msg=msg)

    return render_template('login.html', msg=msg)


# add new student to the database
@app.route('/register', methods=['GET', 'POST'])
def register():
    msg = ''
    if request.method == 'POST':
        f_name = request.form['f_name']
        l_name = request.form['l_name']
        email = request.form['email']
        address = request.form['address']
        phone = request.form['phone']
        dob = request.form['dob']
        username = request.form['username']
        password = request.form['password']

        # not validating any input for now
        # just checking if the username is already taken
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute(
            'SELECT * FROM STUDENT WHERE student_username = %s', (username,)
        )
        account = cursor.fetchone()
        if account:
            msg = 'Account already exists!'
        else:
            # find new student id
            cursor.execute(
                'SELECT MAX(student_id) FROM STUDENT'
            )
            student_id = cursor.fetchone()
            student_id = student_id['MAX(student_id)'] + 1

            cursor.execute(
                'INSERT INTO STUDENT VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)', (
                    student_id, f_name, l_name, email, address, phone, dob, username, password)
            )
            mysql.connection.commit()
            msg = 'You have successfully registered!'

        return redirect(url_for('index'))
    return render_template('register.html', msg=msg)


# page for students to view their grades/available classes
@app.route('/student', methods=['GET', 'POST'])
def student():
    return render_template('student.html')

# page for professors to view the grades of students in their classes


@app.route('/professor', methods=['GET', 'POST'])
def professor():
    return render_template('professor.html')

# page for admins to view all grades/available classes


@app.route('/admin', methods=['GET', 'POST'])
def admin():
    return render_template('admin.html')


if __name__ == '__main__':
    app.run(debug=True)
