## 🧠 What `logrotate` Does

`logrotate` is a system utility that **manages log files automatically** — it rotates, compresses, removes, and mails logs to prevent them from consuming too much disk space.

Typical tasks:

* Rotating (renaming) old logs
* Compressing old logs (`gzip`)
* Deleting old logs after a set time
* Running post-rotation scripts (e.g., restarting a service)

---

## 🗂️ Where Logrotate Lives

| File / Directory            | Purpose                                                             |
| --------------------------- | ------------------------------------------------------------------- |
| `/etc/logrotate.conf`       | Main configuration file                                             |
| `/etc/logrotate.d/`         | Directory for app-specific configs (e.g., `/etc/logrotate.d/httpd`) |
| `/var/lib/logrotate/status` | Stores last rotation timestamps                                     |

---

## ⚙️ Basic Syntax

```bash
logrotate [options] <configfile>
```

Common options:

| Option           | Description                                      |
| ---------------- | ------------------------------------------------ |
| `-d`             | Debug mode (shows what would happen, no changes) |
| `-f`             | Force rotation regardless of time or size        |
| `-v`             | Verbose output                                   |
| `-s <statefile>` | Specify custom state file                        |
| `-m <command>`   | Override the mail command used                   |

---

## 📄 Example 1: Run Logrotate with Default Config

To run all configured rotations (as root):

```bash
sudo logrotate /etc/logrotate.conf
```

This reads the main config and all the files in `/etc/logrotate.d/`.

---

## 🧩 Example 2: Custom Logrotate Configuration File

Let’s say you have logs at `/var/log/myapp/*.log`.
Create a config file `/etc/logrotate.d/myapp`:

```bash
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root adm
    postrotate
        systemctl restart myapp.service > /dev/null 2>&1 || true
    endscript
}
```

### Explanation:

| Directive                  | Description                                                        |
| -------------------------- | ------------------------------------------------------------------ |
| `daily`                    | Rotate logs once per day                                           |
| `rotate 7`                 | Keep 7 old logs                                                    |
| `compress`                 | Compress old logs with gzip                                        |
| `delaycompress`            | Skip compression for the most recent rotated log (helps debugging) |
| `missingok`                | Skip if log file is missing                                        |
| `notifempty`               | Skip rotation if log is empty                                      |
| `create`                   | Create new log with specified permissions                          |
| `postrotate ... endscript` | Commands to run after rotation (e.g., restart a service)           |

---

## 📦 Example 3: Test Configuration

Always test before applying:

```bash
sudo logrotate -d /etc/logrotate.conf
```

This will **show what would happen** (dry-run) without changing anything.

Verbose run:

```bash
sudo logrotate -v /etc/logrotate.conf
```

Force rotation (even if not due):

```bash
sudo logrotate -f /etc/logrotate.conf
```

---

## 🕒 Example 4: Manual Rotation on Demand

You can also use `logrotate` on a single custom file:

```bash
sudo logrotate -f /etc/logrotate.d/myapp
```

---

## 🧹 Example 5: Rotate by Size Instead of Time

You can trigger rotation based on file size:

```bash
/var/log/myapp/*.log {
    size 100M
    rotate 5
    compress
    missingok
    notifempty
}
```

This rotates the log when it exceeds 100 MB.

---

## 🔁 How It’s Automated

Typically, `logrotate` runs automatically via a cron job:

| File                        | Example Schedule                         |
| --------------------------- | ---------------------------------------- |
| `/etc/cron.daily/logrotate` | Runs daily by `cron` or `systemd` timers |

To check the systemd timer:

```bash
systemctl status logrotate.timer
```

---

## 🧾 Example: View Rotation History

Logrotate tracks last rotation times in:

```
/var/lib/logrotate/status
```

You can inspect it:

```bash
cat /var/lib/logrotate/status
```

---

## ✅ Quick Reference Table

| Task              | Command                                 |
| ----------------- | --------------------------------------- |
| Test all configs  | `sudo logrotate -d /etc/logrotate.conf` |
| Force rotation    | `sudo logrotate -f /etc/logrotate.conf` |
| Verbose output    | `sudo logrotate -v /etc/logrotate.conf` |
| Rotate one config | `sudo logrotate /etc/logrotate.d/myapp` |
| View status       | `cat /var/lib/logrotate/status`         |

---

## 🧾 **Example `/etc/logrotate.conf` (Annotated)**

```bash
# See "man logrotate" for details on available options.

# Rotate logs weekly
weekly

# Keep 4 weeks of backlogs
rotate 4

# Compress old log files to save space
compress

# Delay compression until the next rotation cycle
# (keeps the most recent rotated log uncompressed)
delaycompress

# Do not rotate logs if they are empty
notifempty

# If the log file is missing, skip it without error
missingok

# Create a new log file after rotation
# Format: create <mode> <owner> <group>
create 0640 root adm

# Include all application-specific log rotation rules
# Each service (e.g. apache2, nginx, mysql) may have its own file here
include /etc/logrotate.d

# Uncomment this if you want to use the system journal instead
# su root syslog

# Uncomment for debugging (shows actions without making changes)
# verbose

# Example of manually rotating a single file:
# /var/log/wtmp {
#     monthly
#     create 0664 root utmp
#     rotate 1
# }

# Example for btmp (failed login attempts)
# /var/log/btmp {
#     monthly
#     missingok
#     rotate 1
# }
```

---

## 🧩 How It Works

### Global Settings

Everything before the `include` line applies to **all logs**, unless overridden by specific configs in `/etc/logrotate.d`.

### Included Files

Each service (like nginx, sshd, system logs, etc.) has its own file in `/etc/logrotate.d/`.
For example:

**`/etc/logrotate.d/nginx`**

```bash
/var/log/nginx/*.log {
    daily
    missingok
    rotate 14
    compress
    delaycompress
    notifempty
    create 0640 www-data adm
    sharedscripts
    postrotate
        [ -f /var/run/nginx.pid ] && kill -USR1 $(cat /var/run/nginx.pid)
    endscript
}
```

This overrides the global settings for Nginx logs.

---

## 🧪 Testing Your Config

Before running automatically, always test:

```bash
sudo logrotate -d /etc/logrotate.conf
```

If you get no errors, you can force it to execute:

```bash
sudo logrotate -f /etc/logrotate.conf
```

---

## 🧭 Check When Logrotate Runs Automatically

Most systems schedule it with **systemd** or **cron**:

```bash
systemctl status logrotate.timer
```

If it’s a cron job, you’ll find it at:

```
/etc/cron.daily/logrotate
```

That script simply runs:

```bash
/usr/sbin/logrotate /etc/logrotate.conf
```

---

## 🧰 Pro Tip: Debugging Common Issues

| Problem                       | Solution                                                          |
| ----------------------------- | ----------------------------------------------------------------- |
| Logs not rotating             | Check `logrotate -d /etc/logrotate.conf` for syntax issues        |
| Rotation happens too often    | Verify time directive (`daily`, `weekly`, etc.)                   |
| Compressed logs not appearing | Ensure `compress` and `delaycompress` aren’t both disabled        |
| Log not recreated             | Make sure `create` is defined with correct permissions            |
| Custom app logs ignored       | Add them to `/etc/logrotate.d/myapp` and ensure correct ownership |

---
