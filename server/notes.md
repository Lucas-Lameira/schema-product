# create a virtual environment

```
python -m venv env
```

# update pip in virtual environment

```
python -m pip install --upgrade pip
```

# install mysql driver

```
pip install mysql-connector-python
```

# install flask

```
python -m pip install flask
```

# install flask-cors

```
pip install -U flask-cors
```

# flask notes

# response with jsonify or regular data
retorna a resposta em json caso dicionario  **serializable data type**

#### query params
request.args: the key/value pairs in the URL query string

#### body params
request.form: the key/value pairs in the body, from a HTML post form, or JavaScript request that isn't JSON encoded

