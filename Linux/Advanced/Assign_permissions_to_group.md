## 🧩 **Overview**

In Linux, every file and directory has **three sets of permissions:**

| Entity         | Description                 |
| -------------- | --------------------------- |
| **User (u)**   | The owner of the file       |
| **Group (g)**  | Members of the file’s group |
| **Others (o)** | Everyone else               |

Each of those can have:

* **r** → read
* **w** → write
* **x** → execute (or access, for directories)

---

## 🧱 **1️⃣ Create a Group**

To create a new group:

```bash
sudo groupadd developers
```

To verify it:

```bash
getent group developers
```

---

## 👥 **2️⃣ Add Users to the Group**

Add an existing user to the group:

```bash
sudo usermod -aG developers alice
```

Confirm:

```bash
groups alice
```

→ Output might be:

```
alice : alice developers
```

---

## 📁 **3️⃣ Change a File or Directory’s Group Ownership**

Change the group that “owns” a file:

```bash
sudo chown :developers /var/www/project
```

Now `/var/www/project` belongs to the group `developers`.

---

## ⚙️ **4️⃣ Assign Permissions to the Group**

Use the `chmod` command to modify permissions.

### Example: Give the group read/write access

```bash
sudo chmod 770 /var/www/project
```

| Permission  | Meaning            |
| ----------- | ------------------ |
| **7** (rwx) | Owner: full access |
| **7** (rwx) | Group: full access |
| **0** (---) | Others: no access  |

This means:

* The **owner** and **group members** can read/write/execute
* **Others** cannot access the folder

---

## 🧩 **5️⃣ Set the “Setgid” Bit on Directories (Important for Teams)**

To make sure *new files and folders* created inside inherit the same group:

```bash
sudo chmod g+s /var/www/project
```

Now:

* Any new file created inside `/var/www/project` will automatically have the group **developers**.
* This is essential for shared project directories.

You’ll see the “s” flag in permissions:

```bash
ls -ld /var/www/project
drwxrws---  2 root developers 4096 Oct 6 10:00 /var/www/project
```

---

## 📦 **6️⃣ Optional: Default File Permissions (umask)**

When users create new files, you can control the default permissions with `umask`.
Typical defaults:

* Files: 664 (`rw-rw-r--`)
* Directories: 775 (`rwxrwxr-x`)

If you want group collaboration, ensure users’ `umask` is set to `002` (allows group write).

You can set it in:

```bash
~/.bashrc
```

```bash
umask 002
```

---

## 🧠 **7️⃣ Quick Reference Table**

| Task                     | Command                               | Description                  |
| ------------------------ | ------------------------------------- | ---------------------------- |
| Create group             | `sudo groupadd groupname`             | Make a new group             |
| Add user to group        | `sudo usermod -aG groupname username` | Give user group membership   |
| View groups              | `groups` or `id username`             | Show user’s groups           |
| Change group of file     | `sudo chown :groupname filename`      | Assign group ownership       |
| Give group permissions   | `chmod g+rwx filename`                | Read/write/execute for group |
| Remove group permissions | `chmod g-rwx filename`                | Remove all group rights      |
| Set setgid bit           | `chmod g+s directory`                 | Make new files inherit group |
| View permissions         | `ls -l`                               | Check current permissions    |

---

## 🧩 **Example Scenario**

Let’s say you have a web project and want a **shared directory** for your Dev team.

```bash
sudo groupadd webdev
sudo usermod -aG webdev alice
sudo usermod -aG webdev bob

sudo mkdir /var/www/shared
sudo chown :webdev /var/www/shared
sudo chmod 2770 /var/www/shared
```

* `2` in `2770` sets the **setgid** bit
* Both **alice** and **bob** can create/edit files there
* Files inherit group ownership automatically

---

