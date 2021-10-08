# file to teste some stuff
def teste():
    c = 5
    try:
        c = 10
        print(c)
    except ValueError as e:
        print(e)

    print(c)


if __name__ == '__main__':
    teste()
