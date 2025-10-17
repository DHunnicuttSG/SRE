# 🐍 Installing Python on Your Computer

Python is free, open-source, and works on all major operating systems. Follow the steps below to install Python on your computer.

---

## 🔹 Step 1: Check if Python is Already Installed

Before installing, let’s see if Python is already on your system.

1. Open a **terminal** (or **Command Prompt** on Windows).
2. Type:

   ```bash
   python --version
   ```

   or

   ```bash
   python3 --version
   ```
3. If you see a version number (like `Python 3.12.6`), you already have Python installed.
   If you see an error (e.g., *command not found*), you’ll need to install it.

---

## 🔹 Step 2: Download Python

1. Go to the official website: [https://www.python.org/downloads/](https://www.python.org/downloads/)
2. The site will automatically suggest the **latest stable version** for your operating system.
   ✅ Always choose **Python 3.x** (not Python 2.x, which is no longer supported).

---

## 🔹 Step 3: Install on Windows

1. Download the **Windows installer (.exe)** from the website.
2. Double-click the file to start the installation.
3. On the first screen, **check the box that says**:

   ```
   ✅ Add Python 3.x to PATH
   ```

   (This makes it easier to run Python from the command line.)
4. Click **Install Now**.
5. After installation, open **Command Prompt** and type:

   ```bash
   python --version
   ```

   You should see the installed version number.

---

## 🔹 Step 4: Install on macOS

### Option 1: Download from Python.org

1. Download the **macOS installer (.pkg)** from [python.org/downloads](https://www.python.org/downloads/).
2. Open the file and follow the prompts to install.
3. After installation, open **Terminal** and type:

   ```bash
   python3 --version
   ```

### Option 2 (Advanced): Use Homebrew

If you have [Homebrew](https://brew.sh/) installed:

```bash
brew install python
```

---

## 🔹 Step 5: Install on Linux

Most Linux distributions come with Python preinstalled.
To check:

```bash
python3 --version
```

If it’s missing or outdated, install it using your package manager:

* **Ubuntu / Debian**:

  ```bash
  sudo apt update
  sudo apt install python3
  ```
* **Fedora**:

  ```bash
  sudo dnf install python3
  ```
* **Arch Linux**:

  ```bash
  sudo pacman -S python
  ```

---

## 🔹 Step 6: Verify the Installation

Run:

```bash
python --version
```

or

```bash
python3 --version
```

If you see a version number like `Python 3.12.6`, you’re all set! 🎉

---

## 🔹 Step 7: Install a Code Editor (Optional but Recommended)

While you can write Python code in any text editor, using a dedicated editor makes coding much easier.
Popular choices:

* [Visual Studio Code](https://code.visualstudio.com/) (beginner-friendly)
* [PyCharm Community Edition](https://www.jetbrains.com/pycharm/download/)

---

👉 Next, you’re ready to write your first Python program!

---
