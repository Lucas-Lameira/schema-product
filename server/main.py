import os
from flask import Flask
import flask
from flask_cors import CORS
from mysql.connector import Error, MySQLConnection

# my modules
from mysqlconfig import read_mysql_db_config_file

DB_CONFIG = read_mysql_db_config_file()

app = Flask(__name__)
CORS(app)


@app.route("/products", methods=["GET"])
def products():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        cursor.callproc('get_products')

        # result is a MySQLCursorBuffered list_iterator object
        for result in cursor.stored_results():
            # list of tuple
            row = result.fetchall()
    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row)


if __name__ == '__main__':
    # When running locally, disable OAuthlib's HTTPs verification.
    # turn it off in production.
    os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'

    app.run('127.0.0.1', 5000, debug=True)
