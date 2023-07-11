from flask import Flask, render_template, request, redirect, url_for

# create the application object
app = Flask(__name__)

# home page


@app.route('/')
def index():
    return render_template('index.html')

# login page
# from the realpython.com tutorial


@app.route('/login', methods=['GET', 'POST'])
def login():
    error = None
    if request.method == 'POST':
        # check if the username and password are correct
        user = request.form['username']
        password = request.form['password']
        return redirect(url_for('index'))
    return render_template('login.html', error=error)


@app.route('/register', methods=['GET', 'POST'])
def register():
    error = None
    if request.method == 'POST':
        return redirect(url_for('index'))
    return render_template('register.html', error=error)


if __name__ == '__main__':
    app.run(debug=True)
