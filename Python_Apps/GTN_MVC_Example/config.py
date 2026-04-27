import os

class Config:
    DB_HOST = os.getenv("GTN_DB_HOST", "127.0.0.1")
    DB_PORT = int(os.getenv("GTN_DB_PORT", "3306"))
    DB_USER = os.getenv("GTN_DB_USER", "root")
    DB_PASS = os.getenv("GTN_DB_PASSWORD", "RootRoot")  # <- change for your setup
    DB_NAME = os.getenv("GTN_DB_NAME", "gtn")           # <- your DB name
    JSON_SORT_KEYS = False  # preserve insertion order in Flask responses
