import os

def open_read_file():
    f = open("flatland.txt", "r")
    print(f.read())
    f.close()

def read_lines():
    f = open("flatland.txt", "r")
    print(f.readline(), end='')
    print(f.readline(), end='')
    print(f.readline(), end='')
    print(f.readline(), end='')
    print(f.readline(), end='')
    f.close()

def iterate_thru_file():
    f = open("flatland.txt", "r")
    for line in f:
        print(line, end='')
    f.close()

def lines_starting_with():
    f = open("flatland.txt", "r")
    for line in f:
        if line.lower().startswith("i"):
            print(line,end='')
    f.close()

def append_data_to_file():
    f = open("data.txt", "a")
    f.write("This is a test\n")
    f.write("This is only a test\n")
    f.write("For the next 60 seconds this station will conduct a test\n")
    f.close()


states_abbrev = ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                 "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                 "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                 "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                 "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]


def write_list_2_file(input_list, input_file_path):
    # remove pass and add code here
    f = open(input_file_path, "w")
    for item in input_list:
        f.write(str(item) + "\n")
    f.close()

def check_if_file_exists(my_path):
    if os.path.exists(my_path):
        print("The file exists")
    else:
        print("The file does not exist")

def delete_file(my_path):
    try:
        os.remove(my_path)
        print("File was successfully deleted.")
    except FileNotFoundError:
        print("File was not found")

def create_new_file(my_path):
    try:
        f = open(my_path, "x")
        print("file created.")
    except FileExistsError:
        print("file already exists.")


def main():
    # open_read_file()
    # read_lines()
    # iterate_thru_file()
    # lines_starting_with()
    # append_data_to_file()
    # write_list_2_file(states_abbrev, "states.txt")
    # delete_file("states.txt")
    # delete_file("random.txt")
    create_new_file("test1.txt")
    create_new_file("data.txt")

if __name__ == '__main__':
    main()