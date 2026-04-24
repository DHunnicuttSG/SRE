Here is a **clean, practical, sysadmin‑focused cheat sheet** for both **systemctl** and **journalctl**—everything you need at your fingertips.

No fluff. No theory. Just the commands you actually use in real Linux administration.

***

# ✅ **systemctl Cheat Sheet (Service & System Management)**

## ✅ **Basic Service Control**

Start a service:

```bash
sudo systemctl start <service>
```

Stop a service:

```bash
sudo systemctl stop <service>
```

Restart a service:

```bash
sudo systemctl restart <service>
```

Reload config without stopping:

```bash
sudo systemctl reload <service>
```

Check service status:

```bash
systemctl status <service>
```

***

## ✅ **Enable / Disable Services**

Enable service on boot:

```bash
sudo systemctl enable <service>
```

Disable service from boot:

```bash
sudo systemctl disable <service>
```

Enable AND start immediately:

```bash
sudo systemctl enable --now <service>
```

Disable AND stop immediately:

```bash
sudo systemctl disable --now <service>
```

***

## ✅ **Service Files & Daemon Reload**

Reload systemd after editing service files:

```bash
sudo systemctl daemon-reload
```

View service file (merged from all locations):

```bash
systemctl cat <service>
```

Show low‑level details:

```bash
systemctl show <service>
```

***

## ✅ **System State & Diagnostics**

List running services:

```bash
systemctl list-units --type=service
```

List all loaded services:

```bash
systemctl list-unit-files --type=service
```

List failed services:

```bash
systemctl --failed
```

***

## ✅ **Mask / Unmask Services**

Prevent any start attempt (hard disable):

```bash
sudo systemctl mask <service>
```

Undo masking:

```bash
sudo systemctl unmask <service>
```

***

## ✅ **Reboot / Power Management**

Reboot:

```bash
sudo systemctl reboot
```

Shutdown:

```bash
sudo systemctl poweroff
```

Suspend:

```bash
sudo systemctl suspend
```

***

# ✅ **journalctl Cheat Sheet (Systemd Logs)**

## ✅ **Basics**

Show all logs:

```bash
journalctl
```

Follow logs in real time (like `tail -f`):

```bash
journalctl -f
```

***

## ✅ **Logs for a Specific Service**

Show all logs:

```bash
journalctl -u <service>
```

Follow live logs:

```bash
journalctl -u <service> -f
```

Limit to last 100 lines:

```bash
journalctl -u <service> -n 100
```

Logs since last boot:

```bash
journalctl -u <service> -b
```

***

## ✅ **Filter by Time**

Since 1 hour ago:

```bash
journalctl --since "1 hour ago"
```

Since yesterday:

```bash
journalctl --since yesterday
```

Between two timestamps:

```bash
journalctl --since "2026-03-19 10:00" --until "2026-03-19 12:00"
```

***

## ✅ **Filter by Priority (Severity)**

*   0 = emerg
*   1 = alert
*   2 = crit
*   3 = err
*   4 = warning
*   5 = notice
*   6 = info
*   7 = debug

Errors only:

```bash
journalctl -p err
```

Warnings and above:

```bash
journalctl -p warning
```

***

## ✅ **Boot Logs**

List all recorded boots:

```bash
journalctl --list-boots
```

View logs from previous boot:

```bash
journalctl -b -1
```

***

## ✅ **Filter by Process, User, or Executable**

By PID:

```bash
journalctl _PID=1234
```

By user ID:

```bash
journalctl _UID=1000
```

By executable:

```bash
journalctl /usr/bin/python3
```

***

## ✅ **Export Logs**

Export service logs:

```bash
journalctl -u <service> > myapp.log
```

Export entire system journal:

```bash
journalctl > full-journal.log
```

***
