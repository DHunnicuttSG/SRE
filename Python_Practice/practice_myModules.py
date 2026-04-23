def hello():
    print('hello from mymodule')

def my_add(a, b):
    return a + b

def my_subtract(a,b):
    return a - b

if __name__ == '__main__':
    print("running directly")
else:
    print("imported as a module")