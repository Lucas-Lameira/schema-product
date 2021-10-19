import os
from flask import Flask, request, make_response
import flask
from flask_cors import CORS
from mysql.connector import Error, MySQLConnection

# my modules
from mysqlconfig import read_mysql_db_config_file

DB_CONFIG = read_mysql_db_config_file()

app = Flask(__name__)
CORS(app)


@app.route("/products", methods=["GET", "POST", "DELETE", "PUT"])
def products():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        if request.method == "POST":
            # print(request.get_data()) retorna uma bytes string
            data = request.get_json()
            newProduct = []

            for attribute in data:
                newProduct.append(data[attribute])

            cursor.callproc('add_new_product', newProduct)

            for result in cursor.stored_results():

                row = result.fetchall()

            status_code = 201  # created status code

        elif request.method == "GET":
            cursor.callproc('get_products')

            # result is a MySQLCursorBuffered list_iterator object
            for result in cursor.stored_results():
                # list of tuple
                row = result.fetchall()  # list

            status_code = 200

        elif request.method == "DELETE":
            producId = request.args.get('id')
            cursor.callproc('delete_product', [producId])

            row = "produto {} deletado".format(producId)
            status_code = 204

        elif request.method == "PUT":
            # list
            product = request.get_json()
            cursor.callproc('update_product', product)

            # result is a MySQLCursorBuffered list_iterator object
            for result in cursor.stored_results():
                # list of tuple
                row = result.fetchall()  # list

            print(row)
            status_code = 200
    except Error as error:
        print(error)
        row = error
        # status_code = 400  # bad request status code
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row), status_code


@app.route("/sales", methods=["GET", "POST"])
def sales():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        if request.method == "GET":
            # call the sales history procedure
            cursor.callproc('products_for_sale')

            # result is a MySQLCursorBuffered list_iterator object
            for result in cursor.stored_results():
                # list of tuple
                row = result.fetchall()  # list

            status_code = 200

        elif request.method == "POST":
            user_id = request.args.get("id")
            print("userID: ", user_id)

            # raise an error if the user_id is not valid
            if user_id == None or not user_id.isdigit():
                raise Error("No user")

            # pass a mandatory list as an argument
            args = [user_id]
            cursor.callproc('register_sale', args)

            # get the return value from db
            for result in cursor.stored_results():
                row = result.fetchall()

                # raise an error if the user id does not exists  [("user does not exists",)]
                if row[0][0] == -1:
                    raise Error("User id Invalid or does not exists")

                # extrac the code for sale [(code,)]
                code_sale = row[0][0]
                print("code_sale: ", code_sale)

            # [quantity, cod_product] - [[],[]]
            sales_data = request.get_json()
            print("sales_data: ", sales_data)

            # make sale
            for sale_item in sales_data:
                sale_item.append(code_sale)
                print("sale_item: ", sale_item)
                cursor.callproc('make_sale', sale_item)
                for result in cursor.stored_results():
                    # get return from db [(1,)]
                    row = result.fetchall()
                    # row:  [(1,)] returned value when sale made
                    # row:  [('Quantidade insuficiente no estoque',)] returned when not enough product

            # call the database and get the updated products
            # oorr return the updated products after make a sale
            row = "Register sale Success!"
            status_code = 201
    except Error as error:
        print(error)
        status_code = 400
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row), status_code


@app.route('/login', methods=["POST"])
def login():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        data = request.get_json()
        print(data)

        # lazy
        args = [data['email'], data['password']]

        cursor.callproc('login_user', args)

        # result is a MySQLCursorBuffered list_iterator object
        for result in cursor.stored_results():
            # list of tuple
            row = result.fetchall()  # list [()]

        # raise an error if [('Senha ou Email Inválidos',)]
        if len(row[0]) == 1:
            raise Error(row[0][0])

        # (1, 'lucas lameira', 'lucaslameira@gmail.com')
        # row list
        # row[0] tuple
        status_code = 200
    except Error as error:
        print(error)
        status_code = 401
    finally:
        cursor.close()
        connection.close()

    # tuple isn't a valid response, so return a jsonify
    return flask.jsonify(row[0]), status_code


@app.route('/categories')
def get_categories():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        cursor.callproc('get_categories')

        # result is a MySQLCursorBuffered list_iterator object
        for result in cursor.stored_results():
            # data format [[],[]]
            row = result.fetchall()

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row)


@app.route('/products/categories', methods=["GET"])
def get_products_by_category():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        categoryId = request.args.get('id')
        print(categoryId)

        cursor.callproc('products_by_category', [categoryId])

        # result is a MySQLCursorBuffered list_iterator object
        for result in cursor.stored_results():
            # list of tuple
            row = result.fetchall()  # list

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row)


@app.route('/teste', methods=["POST"])
def teste():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        data = request.get_json()  # [[],[]]

        cod_sale = None

        for item in data:
            cursor.callproc('teste_proc', item)
            for result in cursor.stored_results():
                # list of tuple
                row = result.fetchall()  # list [(),()] only one, cod_venda
                cod_sale = row[0][0]
                print('cod_sale', cod_sale)

        """ print('row:', row[0][0]) # id
        print(type(row[0][0])) """

        # (user_id, data de venda, quantidade de venda do produto, cod_venda, cod_produto)
    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(row)


@app.route('/sales/history', methods=["GET"])
def sales_history():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        cursor.callproc('sales_history')
        for result in cursor.stored_results():
            sales = result.fetchall()

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(sales)


@app.route('/purchases/history', methods=["GET"])
def purchases_history():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        cursor.callproc('purchase_history')
        for result in cursor.stored_results():
            purchases = result.fetchall()

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(purchases)


@app.route('/purchases')
def purchases():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        data = request.get_json()

        cursor.callproc('new_purchase', data)
        """  for result in cursor.stored_results():
            purchases = result.fetchall() """

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(purchases)


@app.route('/suppliers')
def suppliers():
    try:
        connection = MySQLConnection(**DB_CONFIG)
        cursor = connection.cursor()

        cursor.callproc('get_suppliers')
        for result in cursor.stored_results():
            suppliers = result.fetchall()

    except Error as error:
        print(error)
    finally:
        cursor.close()
        connection.close()

    return flask.jsonify(suppliers)


if __name__ == '__main__':
    app.run('127.0.0.1', 5000, debug=True)
