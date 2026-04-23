```python
# def my_decorator(func):
#     def wrapper():
#         print("This happens BEFORE the function runs")
#         func()
#         print("This happens AFTER the function runs")
#     return wrapper
#
# @my_decorator
# def say_hello():
#     print("Hello")
#
# say_hello()

# def log_arguments(func):
#     def wrapper(*args, **kwargs):
#         print(f"Calling {func.__name__} with {args} and {kwargs}")
#         return func(*args, **kwargs)
#     return wrapper
#
# @log_arguments
# def add(a,b):
#     return a + b
#
# print(add(5,5))

import time

def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} ran in {end - start:.3f} seconds.")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(2)

slow_function()

```