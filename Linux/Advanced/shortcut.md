To create a shortcut so you can use `ll` instead of typing `ls -l`, you’re basically defining an **alias** in your shell.

Here’s how to do it step by step:

***

## ✅ Temporary (current session only)

Just type this in your terminal:

```bash
alias ll='ls -l'
```

Now `ll` will work—but only until you close the terminal.

***

## ✅ Permanent (recommended)

You need to add the alias to your shell config file.

### 1. Open your shell config file

If you're using **bash**:

```bash
nano ~/.bashrc
```

If you're using **zsh**:

```bash
nano ~/.zshrc
```

***

### 2. Add this line at the bottom

```bash
alias ll='ls -l'
```

***

### 3. Save and reload

Save and exit (`CTRL + O`, `ENTER`, `CTRL + X` in nano), then run:

```bash
source ~/.bashrc
```

or

```bash
source ~/.zshrc
```

***

## ✅ Test it

```bash
ll
```

You should now see the long listing format—same as `ls -l`.

***

## 👍 Bonus (common improvement)

Many systems define `ll` with colors:

```bash
alias ll='ls -alF --color=auto'
```

***
