"""
This script is used to create the database and tables for the ABC University
database. It reads the schema.sql file and executes the commands in it.
"""

import mysql.connector

config = {
    'user': 'root',
    'password': 'root',
    'host': '127.0.0.1',
    'database': 'abcuniversity'
}

cnx = mysql.connector.connect(**config)

cursor = cnx.cursor()


def execute_sql_file(filename):
    sql_file = open(filename, 'r', encoding='utf-8')
    sql_script = sql_file.read()
    sql_file.close()

    commands = sql_script.split(';')
    for command in commands:
        try:
            cursor.execute(command)
        except Exception as ex:
            print("Command skipped: ", command)
            print(ex)


execute_sql_file(filename='schema.sql')

cnx.commit()

cursor.close()
cnx.close()
