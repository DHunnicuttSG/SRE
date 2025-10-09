# 🧩 **Linux System & Environment Variables**

| Variable             | Description                                             | Example Value                                  |
| -------------------- | ------------------------------------------------------- | ---------------------------------------------- |
| **$USER**            | Current logged-in user name                             | `ec2-user`                                     |
| **$HOME**            | Path to the user’s home directory                       | `/home/ec2-user`                               |
| **$PWD**             | Current working directory                               | `/home/ec2-user/scripts`                       |
| **$OLDPWD**          | Previous working directory                              | `/home/ec2-user`                               |
| **$SHELL**           | Default shell for the user                              | `/bin/bash`                                    |
| **$PATH**            | Directories where executables are searched              | `/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin` |
| **$HOSTNAME**        | The system’s hostname                                   | `ip-172-31-20-12`                              |
| **$UID**             | The numeric user ID of the current user                 | `1000`                                         |
| **$EUID**            | Effective user ID (may differ when using `sudo`)        | `0`                                            |
| **$GROUPS**          | Group memberships for the user                          | `ec2-user wheel`                               |
| **$LOGNAME**         | Name of the logged-in user (similar to `$USER`)         | `ec2-user`                                     |
| **$LANG**            | Default system language and locale                      | `en_US.UTF-8`                                  |
| **$TERM**            | Type of terminal emulator being used                    | `xterm-256color`                               |
| **$EDITOR**          | Default text editor                                     | `nano` or `vi`                                 |
| **$MAIL**            | Path to user’s mailbox                                  | `/var/spool/mail/ec2-user`                     |
| **$TMPDIR**          | Temporary directory path                                | `/tmp`                                         |
| **$PS1**             | Command prompt format string                            | `[\u@\h \W]\$`                                 |
| **$HISTFILE**        | File where Bash stores command history                  | `~/.bash_history`                              |
| **$HISTSIZE**        | Number of commands kept in memory history               | `1000`                                         |
| **$HISTCONTROL**     | Controls how Bash saves duplicate commands              | `ignoredups`                                   |
| **$RANDOM**          | Returns a random integer between 0 and 32767            | (changes each use)                             |
| **$SECONDS**         | Number of seconds since the shell started               | (changes each use)                             |
| **$LINENO**          | Current line number in a Bash script                    | `42`                                           |
| **$PPID**            | Process ID of the parent process                        | `2345`                                         |
| **$$**               | Process ID of the current shell                         | `2897`                                         |
| **$?**               | Exit status of the last command (0 = success)           | `0`                                            |
| **$#**               | Number of command-line arguments passed to a script     | `3`                                            |
| **$@**               | All command-line arguments as separate words            | `arg1 arg2 arg3`                               |
| **$***               | All command-line arguments as one string                | `"arg1 arg2 arg3"`                             |
| **$0**               | The name of the current script                          | `./myscript.sh`                                |
| **$1, $2, ...**      | Positional arguments (first, second, etc.)              | `first_arg`, `second_arg`                      |
| **$PATH**            | Colon-separated list of paths to search for executables | `/usr/local/bin:/usr/bin:/bin`                 |
| **$LD_LIBRARY_PATH** | Shared library search path for dynamic linking          | `/usr/local/lib:/usr/lib`                      |
| **$DISPLAY**         | The active X display (for GUI apps)                     | `:0`                                           |
| **$SSH_CLIENT**      | IP and port of connected SSH client                     | `203.0.113.4 50922 22`                         |
| **$SSH_TTY**         | TTY device used for the SSH session                     | `/dev/pts/0`                                   |
| **$AWS_REGION**      | AWS region when using AWS CLI                           | `us-east-1`                                    |
| **$AWS_PROFILE**     | AWS CLI profile name                                    | `default`                                      |
| **$LOGLEVEL**        | Controls logging verbosity in some applications         | `INFO`                                         |

---

# 🧠 **How to View All Environment Variables**

Run:

```bash
printenv
```

or:

```bash
env
```

To search for a specific variable:

```bash
printenv PATH
```

To see **Bash shell variables (including local ones)**:

```bash
set
```

To see **exported environment variables only**:

```bash
export -p
```

---

# ⚙️ **How to Create and Export Your Own Variable**

```bash
MY_NAME="David"
echo $MY_NAME
export MY_NAME
```

Now `$MY_NAME` is available to any child processes (e.g., scripts you run afterward).

---

# 💡 **Pro Tip**

To make a variable **persistent across sessions**, add it to:

* `~/.bashrc` (for user-level)
* `/etc/profile` (for system-wide)

Example:

```bash
echo 'export MY_PROJECT_PATH="/home/ec2-user/projects"' >> ~/.bashrc
source ~/.bashrc
```

---
