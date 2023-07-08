import sqlite3

connection = sqlite3.connect('data.db')

with open('schema.sql') as f:
    connection.executescript(f.read())

cur = connection.cursor()

cur.execute("INSERT INTO users (username, password) VALUES (?, ?)",
            ('admin', 'admin')
            )

connection.commit()
connection.close()
