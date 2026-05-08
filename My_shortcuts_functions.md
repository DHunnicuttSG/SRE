### Copy these to the end of your ~/.bashrc file

```bash
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias home='cd ~'

# File management
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Searching and monitoring

alias ports='netstat -tulanp'
alias ports='ss -tulanp'
alias myIP='curl ipinfo.io/ip'

# Ststem shortcuts

alias df='df -h'
alias du='du -h'

# Git shortcuts
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

# Convenience Commands
alias c='clear'
alias please='sudo !!'

# Prod Support
alias t='tail -f'
alias tf='tail -f'
alias t100='tail -n 100 -f'

alias errors='grep -i error'
alias warn='grep -i warning'
alias greperr='grep -i -n -C 1 error'

alias cpu='ps aux --sort=-%cpu | head'
alias mem='ps aux --sort=-%mem | head'

alias logs='cd /var/log'
alias applogs='cd /var/log/app'
alias nginxlogs='cd /var/log/nginx'

alias findf='find . -type f -name'
alias findd='find . -type d -name'

alias health='echo "---CPU---"; top -b -n1 | head -10; \
echo "---Memory---"; free -m; \
echo "---Disk---"; df -h; \
echo "---Top Processes---"; ps aux --sort=-%cpu | head'


# Functions
mkcd() {
  mkdir -p "$1" && cd "$1"
}

mkexec() {
    chmod u+x "$1"
}

killp() {
     ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs -r kill -9
}

# search for any pattern, not just errors
grepc() {
  grep --color=auto -i -n -C 1 "$1" "$2"
}
```