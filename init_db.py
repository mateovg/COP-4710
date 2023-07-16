"""
This script is used to create the database and tables for the ABC University
database. It reads the schema.sql file and executes the commands in it.
"""

import db


def execute_sql_file(filename):
    sql_file = open(filename, 'r', encoding='utf-8')
    sql_script = sql_file.read()
    sql_file.close()

    commands = sql_script.split(';')
    for command in commands:
        try:
            db.execute_query(command)
        except Exception as ex:
            print("Command skipped: ", command)
            print(ex)


def init_db():
    execute_sql_file(filename='COP-4710\schema.sql')
    db.connection.commit()


init_db()
