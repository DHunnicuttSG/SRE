Below is a **clear, practical, real‑world guide** to what you can *actually* do with `systemctl` and `journalctl` on any modern **systemd‑based Linux distribution** (Ubuntu, Debian, RHEL, Rocky, Alma, Fedora, Amazon Linux 2/2023, etc.).

***

# ✅ `systemctl` — Manage Services, Units, and System State

`systemctl` is your main interface to **systemd**, the init system and service manager.

***

## ✅ 1. Start, Stop, Restart, and Check Services

### Start a service:

```bash
sudo systemctl start nginx
```

### Stop a service:

```bash
sudo systemctl stop nginx
```

### Restart it:

```bash
sudo systemctl restart nginx
```

### Reload configuration without restarting:

```bash
sudo systemctl reload nginx
```

Useful for apps like Nginx, HAProxy, or applications that re-read configs gracefully.

### Check its current status:

```bash
sudo systemctl status nginx
```

Shows:

*   Active/inactive state
*   Enabled/disabled
*   Recent logs
*   PIDs, memory, tasks

***

## ✅ 2. Enable or Disable Services at Boot

### Enable a service to start at boot:

```bash
sudo systemctl enable nginx
```

### Disable auto-start:

```bash
sudo systemctl disable nginx
```

### Enable and immediately start:

```bash
sudo systemctl enable --now nginx
```

### Disable and stop:

```bash
sudo systemctl disable --now nginx
```

***

## ✅ 3. Check System-Wide Service Health

List all services:

```bash
systemctl list-units --type=service
```

List failed units:

```bash
systemctl --failed
```

Extremely useful after a reboot or deployment to see what didn’t start.

***

## ✅ 4. Reload Systemd After Adding/Changing Unit Files

When you create or modify `/etc/systemd/system/*.service`:

```bash
sudo systemctl daemon-reload
```

Then restart the service:

```bash
sudo systemctl restart myapp.service
```

***

## ✅ 5. Mask and Unmask Services

Mask prevents a service from being started *by any means*—manual, dependency, or automated.

```bash
sudo systemctl mask bluetooth.service
```

Unmask:

```bash
sudo systemctl unmask bluetooth.service
```

Useful for disabling malfunctioning services permanently.

***

## ✅ 6. View Service Files and Metadata

Show the unit file systemd is using:

```bash
systemctl cat nginx.service
```

Show dependencies:

```bash
systemctl list-dependencies nginx.service
```

Show low-level unit info:

```bash
systemctl show nginx
```

***

# ✅ `journalctl` — View and Filter Systemd Logs Like a Pro

`journalctl` gives you centralized logs from:

*   Services
*   Kernel messages
*   System boots
*   User sessions
*   Custom app logs (via stdout/stderr)

It’s the systemd alternative to `tail -f /var/log/*`.

***

## ✅ 1. View All System Logs

```bash
journalctl
```

***

## ✅ 2. Follow Logs in Real Time (like `tail -f`)

```bash
journalctl -f
```

Follow only a specific service:

```bash
journalctl -u nginx -f
```

***

## ✅ 3. Show Logs for a Specific Unit

```bash
journalctl -u nginx
```

Limit to current boot:

```bash
journalctl -u nginx -b
```

Limit to last 100 lines:

```bash
journalctl -u nginx -n 100
```

***

## ✅ 4. Filter Logs by Time

### Logs from last 1 hour:

```bash
journalctl --since "1 hour ago"
```

### Between two times:

```bash
journalctl --since "2026-03-19 12:00" --until "2026-03-19 12:30"
```

### From today:

```bash
journalctl --since today
```

***

## ✅ 5. Filter by Priority (Severity Level)

Levels range from 0 (emerg) to 7 (debug)

Show warnings and above:

```bash
journalctl -p warning
```

Show only errors:

```bash
journalctl -p err -f
```

***

## ✅ 6. View Kernel Logs Only

```bash
journalctl -k
```

***

## ✅ 7. Viewing Logs for the Previous Boot

List boots:

```bash
journalctl --list-boots
```

View previous boot (`-1`):

```bash
journalctl -b -1
```

This is invaluable after reboots where something fails to start.

***

## ✅ 8. View Logs from a Specific Process, User, or PID

By PID:

```bash
journalctl _PID=1234
```

By user:

```bash
journalctl _UID=1000
```

By executable path:

```bash
journalctl /usr/bin/python3
```

***

## ✅ 9. Export Logs for Debugging

Export entire journal to a file:

```bash
journalctl > journal.txt
```

Export only a service:

```bash
journalctl -u myapp.service > myapp.log
```

***

# ✅ How `systemctl` and `journalctl` Work Together in Real-World Admin Work

### Deploy new app → create service → check logs:

**1. Create/edit your service**

```bash
sudo nano /etc/systemd/system/myapp.service
sudo systemctl daemon-reload
sudo systemctl enable --now myapp
```

**2. Check service health**

```bash
systemctl status myapp
```

**3. View logs**

```bash
journalctl -u myapp -f
```

***

### Debug a service crash after reboot:

```bash
systemctl --failed
journalctl -b -1 -u myapp
```

***

### Investigate performance or kernel issues:

```bash
journalctl -k -p warning
```

***

# ✅ Summary: What You Can Do

## ✅ `systemctl` lets you:

*   Start/stop/restart/reload services
*   Enable/disable boot services
*   View service status & dependencies
*   Reload systemd after changes
*   Mask/unmask units
*   Inspect service files

## ✅ `journalctl` lets you:

*   Read all system logs
*   Follow logs in real time
*   Filter by unit, PID, severity, time range
*   Read logs from past boots
*   Export logs for debugging
*   See kernel and hardware events

Together, they form the **core toolkit** for managing any systemd-based Linux system in production or development.

***
