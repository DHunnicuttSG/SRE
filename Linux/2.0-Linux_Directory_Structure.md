
## **Linux Directory Structure**

### **1. Overview**

The Linux file system follows the **Filesystem Hierarchy Standard (FHS)**, which defines the directory structure and contents in Unix-like operating systems. Everything in Linux is represented as a file, including devices and processes.

***

### **2. Root Directory `/`**

*   The **root directory** is the top-level directory in Linux.
*   All other directories and files branch from `/`.
*   Example:
        /
        ├── bin
        ├── etc
        ├── home
        ├── usr
        ├── var
        └── tmp

***

### **3. Key Directories and Their Purpose**

| Directory | Purpose                                                        |
| --------- | -------------------------------------------------------------- |
| `/bin`    | Essential user binaries (e.g., `ls`, `cp`, `mv`)               |
| `/sbin`   | System binaries for administration (e.g., `mount`, `shutdown`) |
| `/etc`    | Configuration files for system and applications                |
| `/home`   | User home directories                                          |
| `/root`   | Home directory for the root user                               |
| `/usr`    | User programs, libraries, documentation                        |
| `/var`    | Variable data (logs, spool files)                              |
| `/tmp`    | Temporary files                                                |
| `/dev`    | Device files (e.g., `/dev/sda` for disks)                      |
| `/proc`   | Virtual filesystem for process and kernel info                 |
| `/lib`    | Shared libraries needed by binaries in `/bin` and `/sbin`      |

***

### **4. Special Directories**

*   `.` → Current directory
*   `..` → Parent directory
*   `~` → Home directory of the current user

***

### **5. Navigation Commands**

*   `pwd` → Print working directory
*   `cd /path` → Change directory
*   `ls` → List files
    *   `ls -l` → Long format
    *   `ls -a` → Show hidden files

***

### **6. Practical Examples**

```bash
# Navigate to /etc
cd /etc

# List contents with details
ls -l

# Go back to home directory
cd ~

# Check current directory
pwd
```

***

### **7. Visual Representation**

Imagine the Linux directory tree like this:

    /
    ├── bin
    ├── boot
    ├── dev
    ├── etc
    ├── home
    │   ├── user1
    │   └── user2
    ├── lib
    ├── media
    ├── mnt
    ├── opt
    ├── proc
    ├── root
    ├── run
    ├── sbin
    ├── srv
    ├── tmp
    ├── usr
    │   ├── bin
    │   ├── lib
    │   └── share
    └── var
        ├── log
        ├── tmp
        └── www

***

### **8. Hands-On Lab**

**Exercise:**

1.  Navigate to `/usr/bin` and list all files starting with `g`.
    ```bash
    cd /usr/bin
    ls g*
    ```
2.  Find the absolute path of your home directory.
    ```bash
    echo $HOME
    ```
3.  Create a directory `testdir` in `/tmp` and verify.
    ```bash
    mkdir /tmp/testdir
    ls /tmp
    ```

***
