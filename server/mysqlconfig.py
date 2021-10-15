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

    return db