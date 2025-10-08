# 👥 **Managing Users and Groups in Linux**

---

## 🧩 **Overview**

Linux uses groups to manage permissions and organize users.
Each user can belong to:

* **A primary group** (default when they log in)
* **One or more secondary groups** (additional memberships)

This structure helps control who can read, write, or execute files and directories.

---

## 🧠 **Basic Terms**

| Term                | Description                                                |
| ------------------- | ---------------------------------------------------------- |
| **Group**           | A collection of users with shared permissions.             |
| **Primary group**   | Automatically assigned to a user upon creation.            |
| **Secondary group** | Additional groups a user belongs to.                       |
| **`/etc/group`**    | File that stores group information.                        |
| **`/etc/passwd`**   | File that stores user account info (and primary group ID). |

---

## ⚙️ **1️⃣ Create a Group**

```bash
sudo groupadd developers
```

✅ Creates a group named **developers**

You can verify by checking the `/etc/group` file:

```bash
grep developers /etc/group
```

---

## ⚙️ **2️⃣ Create a User and Assign to a Group**

```bash
sudo useradd -m -G developers alice
sudo passwd alice
```

✅ This:

* Creates a user named **alice**
* Adds her to the **developers** group (as a **secondary group**)
* `-m` creates a home directory
* You’ll set her password with `passwd`

Check her groups:

```bash
groups alice
```

Output:

```
alice : alice developers
```

---

## ⚙️ **3️⃣ Add an Existing User to a Group**

### Method 1: Using `usermod`

```bash
sudo usermod -aG developers bob
```

✅ Adds user **bob** to the **developers** group.

> ⚠️ The `-a` (append) flag is critical!
> Without it, you’ll *replace* all of Bob’s current secondary groups.

Verify:

```bash
groups bob
```

---

## ⚙️ **4️⃣ Change a User’s Primary Group**

```bash
sudo usermod -g developers alice
```

✅ Sets **developers** as Alice’s primary group.

Check:

```bash
id alice
```

Output shows:

```
uid=1001(alice) gid=1002(developers) groups=1002(developers)
```

---

## ⚙️ **5️⃣ Remove a User from a Group**

Unfortunately, there’s no single “remove user from group” command — you have to **edit group membership**.

### Method 1: Using `gpasswd`

```bash
sudo gpasswd -d alice developers
```

✅ Removes **alice** from the **developers** group.

---

### Method 2: Using `deluser` (on Debian/Ubuntu)

```bash
sudo deluser alice developers
```

---

### Method 3: Manually edit `/etc/group`

```bash
sudo vigr
```

Find the line for the group:

```
developers:x:1002:alice,bob,carol
```

Remove the username and save.

---

## ⚙️ **6️⃣ Delete a Group**

```bash
sudo groupdel developers
```

> Note: You must remove all users or reassign them first.

---

## ⚙️ **7️⃣ View Group Membership**

To see which users belong to a group:

```bash
getent group developers
```

Output:

```
developers:x:1002:alice,bob
```

---

## 🧰 **8️⃣ View All Groups on the System**

```bash
cut -d: -f1 /etc/group
```

---

## 🧮 **Summary Table**

| Task                   | Command                | Example                         |
| ---------------------- | ---------------------- | ------------------------------- |
| Create group           | `groupadd`             | `sudo groupadd devops`          |
| Add user to group      | `usermod -aG`          | `sudo usermod -aG devops alice` |
| Change primary group   | `usermod -g`           | `sudo usermod -g devops alice`  |
| Remove user from group | `gpasswd -d`           | `sudo gpasswd -d alice devops`  |
| Delete group           | `groupdel`             | `sudo groupdel devops`          |
| Show user’s groups     | `groups`               | `groups alice`                  |
| Show group info        | `getent group <group>` | `getent group devops`           |

---

## 🧪 **Classroom Activities**

### 🧩 **Activity 1 — Group Creation**

1. Create three groups: `developers`, `designers`, and `admins`.
2. Verify with:

   ```bash
   cut -d: -f1 /etc/group
   ```

---

### 🧩 **Activity 2 — User Management**

1. Create users: `alice`, `bob`, and `carol`.
2. Add:

   * Alice → `developers`
   * Bob → `designers`
   * Carol → both `developers` and `designers`
3. Verify with `groups` command.

---

### 🧩 **Activity 3 — Update Memberships**

1. Change Carol’s primary group to `designers`.
2. Remove Alice from `developers`.
3. Confirm changes using `getent group developers`.

---

### 🧩 **Activity 4 — Cleanup**

1. Remove the group `designers`.
2. Check `/etc/group` to confirm it’s gone.

---

## ✅ **Tips and Best Practices**

| Tip                                           | Why It Matters                    |
| --------------------------------------------- | --------------------------------- |
| Always use `sudo` for group and user commands | Requires admin privileges         |
| Use `-aG` (append) carefully                  | Avoid overwriting memberships     |
| Verify changes with `id` or `groups`          | Confirms correct setup            |
| Log out and back in after group changes       | Group membership updates on login |
| Use descriptive group names                   | e.g., `dev_team`, `qa_team`       |

---
