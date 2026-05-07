For **production support work**, you want aliases that help you **triage issues quickly, inspect logs, monitor systems, and recover fast**. Below is a curated set specifically for real-world support scenarios.

***

# 🚨 🔧 Production Support Alias Pack

Add these to your `~/.bashrc` or `~/.zshrc`.

***

# 📜 Logs & Troubleshooting

### Tail logs (most common action)

```bash
alias t='tail -f'
alias tf='tail -f'
alias t100='tail -n 100 -f'
```

### Show latest errors quickly

```bash
alias errors='grep -i error'
alias warn='grep -i warning'


```

### Search logs easily

```bash
alias logg='grep -i'
```

✅ Example:

```bash
t100 app.log | grep -i error
```

***

# 🖥️ Process Monitoring

### Top processes (better sorting)

```bash
alias cpu='ps aux --sort=-%cpu | head'
alias mem='ps aux --sort=-%mem | head'
```

### Find a process

```bash
alias p='ps aux | grep -i'
```

***

# 🌐 Network / Ports

### Check open ports

```bash
alias ports='ss -tulnp'
```

### Test connectivity

```bash
alias pingg='ping -c 4'
```

### Curl health check

```bash
alias curlh='curl -I'
```

***

# 💾 Disk & System Health

### Disk usage

```bash
alias df='df -h'
```

### Folder size

```bash
alias du='du -sh *'
```

### Memory usage

```bash
alias free='free -m'
```

***

# 📂 Navigation Shortcuts

### Jump to common log locations

```bash
alias logs='cd /var/log'
alias applogs='cd /var/log/app'
alias nginxlogs='cd /var/log/nginx'
```

### Jump back quickly

```bash
alias back='cd -'
```

***

# ⚙️ Service Management

### Systemd quick commands

```bash
alias st='systemctl status'
alias sta='systemctl start'
alias sto='systemctl stop'
alias re='systemctl restart'
```

✅ Example:

```bash
st nginx
re myapp
```

***

# 🐳 Containers (if using Docker)

```bash
alias dps='docker ps'
alias dlog='docker logs -f'
alias dexec='docker exec -it'
alias dstop='docker stop'
```

***

# 🧪 Quick Debugging Helpers

### Show last command with timestamp

```bash
alias historytime='HISTTIMEFORMAT="%F %T " history'
```

### Repeat last command with sudo

```bash
alias please='sudo !!'
```

***

# 🔍 File Search

```bash
alias findf='find . -type f -name'
alias findd='find . -type d -name'
```

***

# ⚡ High-Value Function (Must Have)

### Kill a process by name safely

```bash
killp() {
  ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs -r kill -9
}
```
Usage:
```bash
killp <process_name>
```

***

### Quick log watcher for multiple services

```bash
multitail() {
  tail -f "$@"
}
```

✅ Example:

```bash
multitail app.log nginx.log
```

***

# 🚀 "War Room Mode" (Super Useful)

This gives you a quick system snapshot:

```bash
alias health='echo "---CPU---"; top -b -n1 | head -10; \
echo "---Memory---"; free -m; \
echo "---Disk---"; df -h; \
echo "---Top Processes---"; ps aux --sort=-%cpu | head'
```

***

# ✅ How to Install All At Once

1.  Open your config:

```bash
nano ~/.bashrc
```

2.  Paste everything

3.  Apply:

```bash
source ~/.bashrc
```

***

# 💡 Pro Tips for Production

*   Combine commands:

```bash
t100 app.log | grep -i error
```

*   Always alias `rm` safely in production:

```bash
alias rm='rm -i'
```

*   Keep a **minimal but reliable set**—speed matters during incidents.

***

## More on functions

Yes — and this is **very useful in production environments**.

***

# ✅ List All Functions in Your Shell

### 🔹 Simple command:

```bash
declare -F
```

This will output a list of all defined functions:

    declare -f mkcd
    declare -f extract
    declare -f killp

***

# ✅ Show Full Function Definitions

If you want to see the actual code for all functions:

```bash
declare -f
```

***

# ✅ View a Specific Function

```bash
declare -f killp
```

***

# ✅ Alternative Methods

### 1. Using `typeset` (works in bash/zsh)

```bash
typeset -f
```

### 2. Using `compgen`

```bash
compgen -A function
```

***

# ✅ Combine with `grep` (very practical)

### Find a function quickly:

```bash
declare -F | grep kill
```

***

# ✅ Bonus: List Aliases Too

Since aliases + functions go together:

```bash
alias
```

***

# 🔧 Pro Tip (Production Use)

Create a helper alias to quickly view everything:

```bash
alias myfuncs='declare -F'
alias myaliases='alias'
```

***

# 🧠 Quick Summary

| Task                   | Command               |
| ---------------------- | --------------------- |
| List function names    | `declare -F`          |
| Show all function code | `declare -f`          |
| Show one function      | `declare -f name`     |
| List functions (alt)   | `compgen -A function` |

***

If you want, I can show you how to **export functions, share them across servers, or build a reusable production support toolkit file**.

***

You can do this cleanly with `grep`’s **context option** `-C`.

***

# ✅ Alias for error with 1 line before & after

Add this to your `~/.bashrc` or `~/.zshrc`:

```bash
alias greperr='grep -i -C 1 error'
```

***

# ✅ How it works

*   `-i` → case-insensitive (`ERROR`, `Error`, etc.)
*   `-C 1` → show **1 line before and 1 after**

***

# ✅ Usage

```bash
greperr app.log
```

***

# ✅ Example Output

    INFO Starting service
    ERROR Failed to connect to DB
    Retrying connection...

***

# ✅ Optional: Add line numbers (very helpful)

```bash
alias greperr='grep -i -n -C 1 error'
```

***

# ✅ Optional: Highlight + cleaner output

```bash
alias greperr='grep --color=auto -i -n -C 1 error'
```

***

# ✅ Pro Tip (more flexible function)

If you want to search **any pattern**, not just "error":

```bash
grepc() {
  grep --color=auto -i -n -C 1 "$1" "$2"
}
```

Usage:

```bash
grepc error app.log
grepc timeout server.log
```

***

# 🚀 Production Tip

During incidents, this pattern is gold:

```bash
tail -f app.log | grep -i -C 1 error
```

***
