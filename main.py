import tkinter as tk
import mysql.connector as mysql


def login(username, password):
    db = mysql.connect(host="localhost", user="admin",
                       passwd="admin", database="abc_university")
    cursor = db.cursor()


def submit():
    username = username.get()
    password = password.get()
    login(username, password)


def register():
    pass


# init app
root = tk.Tk()
root.title("ABC University Login/Register")
root.geometry("400x400")
root.resizable(0, 0)

# define labels
title_label = tk.Label(
    root, text="ABC University Login/Register", font=("Arial", 20))
title_label.grid(row=0, column=0, columnspan=2, pady=20)

username_label = tk.Label(root, text="Student ID: ")
username_label.grid(row=1, column=0, pady=5)
username = tk.Entry(root)
username.grid(row=1, column=1, pady=5)

password_label = tk.Label(root, text="Password: ")
password_label.grid(row=2, column=0, pady=5)
password = tk.Entry(root,  show="*")
password.grid(row=2, column=1, pady=5)

submit_button = tk.Button(root, text="Login", command=submit)
submit_button.grid(row=3, column=0, pady=5)

# register button
register_button = tk.Button(root, text="Register", command=register)
register_button.grid(row=3, column=1, pady=5)

# run app
root.mainloop()
