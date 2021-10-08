from mysql.connector import MySQLConnection, Error
from configparser import ConfigParser


def read_mysql_db_config_file(filename='config.ini', section='mysql'):

    # python parser to read INI files
    parser = ConfigParser()
    parser.read(filename)

    # get section, default to mysql
    db = {}
    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception(
            '{0} not found in the {1} file'.format(section, filename))

    print(db)
    return db


def open_connection():
    db_config = read_mysql_db_config_file()
    try:
        # connect to mysql server and get a MYSQLConnection object
        connection = MySQLConnection(**db_config)

        if connection.is_connected():
            print("connected")

        return connection

    except Error as error:
        print(error)

        if connection is not None and connection.is_connected():
            print("close connection")
            connection.close()
        else:
            print("There's no connection")

        return 0


def close_connection(connection):
    if connection is not None and connection.is_connected():
        print("close connection")
        connection.close()
    else:
        print("There's no connection")
