import sqlite3
import threading
import time

"""
Deadlock Demonstration Simulator

This does NOT require MySQL.
It visually demonstrates how a deadlock occurs by using two locks
that represent two database rows/resources.

Thread A locks Resource 1 then waits for Resource 2.
Thread B locks Resource 2 then waits for Resource 1.

This creates the classic deadlock pattern.
"""

lock_account1 = threading.Lock()
lock_account2 = threading.Lock()


def transaction_a():
    print("Transaction A: Locking Account 1")
    lock_account1.acquire()
    print("Transaction A: Account 1 locked")

    time.sleep(2)

    print("Transaction A: Waiting for Account 2...")
    acquired = lock_account2.acquire(timeout=5)

    if not acquired:
        print("*** DEADLOCK DETECTED: Transaction A could not obtain Account 2 ***")

    lock_account1.release()
    print("Transaction A: Released Account 1")



def transaction_b():
    print("Transaction B: Locking Account 2")
    lock_account2.acquire()
    print("Transaction B: Account 2 locked")

    time.sleep(2)

    print("Transaction B: Waiting for Account 1...")
    acquired = lock_account1.acquire(timeout=5)

    if not acquired:
        print("*** DEADLOCK DETECTED: Transaction B could not obtain Account 1 ***")

    lock_account2.release()
    print("Transaction B: Released Account 2")


if __name__ == '__main__':
    print('=' * 60)
    print('MYSQL DEADLOCK DEMONSTRATION')
    print('=' * 60)

    t1 = threading.Thread(target=transaction_a)
    t2 = threading.Thread(target=transaction_b)

    t1.start()
    t2.start()

    t1.join()
    t2.join()

    print('\nDemo complete.')
    print('Discussion:')
    print('- Transaction A held Account 1 and wanted Account 2')
    print('- Transaction B held Account 2 and wanted Account 1')
    print('- This circular dependency is a deadlock')
