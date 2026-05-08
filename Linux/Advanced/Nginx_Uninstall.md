To uninstall Nginx from your EC2 Linux instance, you need to:

1.  **Stop the service**
2.  **Disable it (optional but recommended)**
3.  **Remove the package**
4.  **Clean up leftover files (optional)**

***

# 🧹 Step-by-Step: Uninstall Nginx

## 🔴 Step 1: Stop Nginx

```bash
sudo systemctl stop nginx
```

***

## 🔴 Step 2: Disable Nginx (so it doesn’t auto-start)

```bash
sudo systemctl disable nginx
```

***

# 🗑️ Step 3: Remove Nginx Package

## ✅ Amazon Linux / RHEL-based systems

```bash
sudo yum remove nginx -y
```

***

## ✅ Ubuntu / Debian systems

```bash
sudo apt remove nginx -y
```

***

# 🧼 Step 4: Remove Configuration Files (Optional but Recommended)

These are not always removed automatically.

```bash
sudo rm -rf /etc/nginx
```

***

# 🧹 Step 5: Remove Logs (Optional)

```bash
sudo rm -rf /var/log/nginx
```

***

# ✅ Step 6: Verify Removal

Run:

```bash
nginx -v
```

✅ Expected result:

    command not found

***

# 🧪 Bonus: Check That Service is Gone

```bash
systemctl status nginx
```

✅ Expected:

    Unit nginx.service could not be found

***

# ⚠️ Common Gotcha

If Nginx still appears after uninstall:

*   You may have installed from a different source (e.g., compiled manually)
*   Or leftover binaries may remain

***

# 🧠 Quick Summary

| Step         | Command                                  |
| ------------ | ---------------------------------------- |
| Stop service | `systemctl stop nginx`                   |
| Disable      | `systemctl disable nginx`                |
| Remove       | `yum remove nginx` or `apt remove nginx` |
| Cleanup      | `rm -rf /etc/nginx`                      |

***
