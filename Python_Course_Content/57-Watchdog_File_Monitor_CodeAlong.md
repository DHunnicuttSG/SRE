# Code-Along Lab: File Monitoring with Python Watchdog

**Audience:** Intermediate Python students  
**Duration:** 60–90 minutes  
**Prerequisites:** Functions, classes, exceptions, and basic file I/O

---

## Learning Objectives

By the end of this lab, students will be able to:

* Explain what the `watchdog` package does.
* Create an event handler using `FileSystemEventHandler`.
* Monitor a directory with `Observer`.
* Identify file-created, modified, moved, and deleted events.
* Filter events by file extension.
* Log monitored activity to the terminal and a file.
* Handle shutdown signals and stop an observer safely.

---

## What Is Watchdog?

`watchdog` monitors directories for changes such as:

* A file is created.
* A file is modified.
* A file is renamed or moved.
* A file is deleted.
* A directory is created or removed.

Common uses include:

* Automatically processing uploaded files.
* Triggering builds when source files change.
* Reloading configuration files.
* Monitoring log directories.
* Auditing changes made to a directory.

Watchdog uses efficient operating-system notifications instead of repeatedly
checking whether files have changed.

---

## Lab Files

Create a project folder and add the Python program:

```text
watchdog_lab/
├── file_monitor.py
└── watched_files/
```

Create the folder in the terminal:

```bash
mkdir watchdog_lab
cd watchdog_lab
mkdir watched_files
```

In a virtual environment, install Watchdog:

```bash
python -m pip install watchdog
```

Verify the installation:

```bash
python -c "import watchdog; print(watchdog.__version__)"
```

---

## Step 1: Import the Required Modules

Create `file_monitor.py` and begin with these imports:

```python
import logging
import sys
import time
from pathlib import Path

from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer
```

The `Observer` watches a directory and sends events to an event handler.

---

## Step 2: Configure Logging

Add logging that writes the same message to the terminal and a log file:

```python
LOG_FILE = "file_events.log"

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler(sys.stdout),
    ],
)
```

Run the program from the project directory. The log file is created in that
directory.

---

## Step 3: Create an Event Handler

An event handler receives notifications from `Observer`.

```python
class MonitoredFileHandler(FileSystemEventHandler):
    def on_created(self, event):
        logging.info("Created: %s", event.src_path)

    def on_modified(self, event):
        logging.info("Modified: %s", event.src_path)

    def on_deleted(self, event):
        logging.info("Deleted: %s", event.src_path)

    def on_moved(self, event):
        logging.info("Moved: %s -> %s", event.src_path, event.dest_path)
```

`event.is_directory` distinguishes files from directories.

---

## Step 4: Improve Directory Event Handling

Replace the basic event methods with logic that ignores directory events:

```python
class MonitoredFileHandler(FileSystemEventHandler):
    def _log_file_event(self, action, path):
        if Path(path).is_file():
            logging.info("%s file: %s", action, path)

    def on_created(self, event):
        if not event.is_directory:
            logging.info("Created file: %s", event.src_path)

    def on_modified(self, event):
        if not event.is_directory:
            logging.info("Modified file: %s", event.src_path)

    def on_deleted(self, event):
        if not event.is_directory:
            logging.info("Deleted file: %s", event.src_path)

    def on_moved(self, event):
        if not event.is_directory:
            logging.info(
                "Moved file: %s -> %s",
                event.src_path,
                event.dest_path,
            )
```

The helper is not used yet, but the class demonstrates useful organization for
a larger monitoring program.

---

## Step 5: Start the Observer

Add the main function below the class:

```python
def main():
    watch_directory = Path("watched_files")

    if not watch_directory.exists():
        watch_directory.mkdir()
        logging.info("Created directory: %s", watch_directory)

    event_handler = MonitoredFileHandler()
    observer = Observer()
    observer.schedule(event_handler, str(watch_directory), recursive=True)
    observer.start()

    logging.info("Watching directory: %s", watch_directory.resolve())
    logging.info("Press Ctrl+C to stop.")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        logging.info("Stopping file monitor...")
    finally:
        observer.stop()
        observer.join()
        logging.info("File monitor stopped.")
```

The `finally` block runs even if the program exits because of
`KeyboardInterrupt`.

---

## Step 6: Run the Program

Add the program entry point:

```python
if __name__ == "__main__":
    main()
```

Run:

```bash
python file_monitor.py
```

Leave this terminal open. In a second terminal, enter the project directory:

```bash
cd watchdog_lab
```

Create a file:

```bash
echo "First version" > watched_files/notes.txt
```

Modify it:

```bash
echo "Second version" >> watched_files/notes.txt
```

Rename it:

```bash
mv watched_files/notes.txt watched_files/renamed.txt
```

Delete it:

```bash
rm watched_files/renamed.txt
```

Watch both terminals for event messages.

---

## Completed Code

```python
import logging
import sys
import time
from pathlib import Path

from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer


LOG_FILE = "file_events.log"

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler(sys.stdout),
    ],
)


class MonitoredFileHandler(FileSystemEventHandler):
    def on_created(self, event):
        if not event.is_directory:
            logging.info("Created file: %s", event.src_path)

    def on_modified(self, event):
        if not event.is_directory:
            logging.info("Modified file: %s", event.src_path)

    def on_deleted(self, event):
        if not event.is_directory:
            logging.info("Deleted file: %s", event.src_path)

    def on_moved(self, event):
        if not event.is_directory:
            logging.info(
                "Moved file: %s -> %s",
                event.src_path,
                event.dest_path,
            )


def main():
    watch_directory = Path("watched_files")

    if not watch_directory.exists():
        watch_directory.mkdir()
        logging.info("Created directory: %s", watch_directory)

    event_handler = MonitoredFileHandler()
    observer = Observer()
    observer.schedule(event_handler, str(watch_directory), recursive=True)
    observer.start()

    logging.info("Watching directory: %s", watch_directory.resolve())
    logging.info("Press Ctrl+C to stop.")

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        logging.info("Stopping file monitor...")
    finally:
        observer.stop()
        observer.join()
        logging.info("File monitor stopped.")


if __name__ == "__main__":
    main()
```

---

## Extension 1: Monitor a Specific File Extension

Add a list of permitted extensions to the handler:

```python
class MonitoredFileHandler(FileSystemEventHandler):
    def __init__(self, extensions):
        super().__init__()
        self.extensions = extensions

    def should_log(self, event):
        return (
            not event.is_directory
            and Path(event.src_path).suffix.lower() in self.extensions
        )

    def on_created(self, event):
        if self.should_log(event):
            logging.info("Created file: %s", event.src_path)
```

Then instantiate the handler:

```python
event_handler = MonitoredFileHandler({".txt", ".csv"})
```

Update the remaining event methods to use `should_log`.

---

## Extension 2: Respond to File Changes

When a CSV file changes, a monitoring program could automatically validate or
process it.

```python
def on_created(self, event):
    if self.should_log(event) and Path(event.src_path).suffix == ".csv":
        logging.info("CSV ready for processing: %s", event.src_path)
```

For production workloads, processing should happen after the writer has
finished and the file is stable. A complete solution can use a cooldown or
debounce timer.

---

## Challenge: Watched File Audit Logger

Enhance the lab to:

1. Monitor only `.txt` and `.csv` files.
2. Write events to `file_audit.log`.
3. Include the event time, action, and file name.
4. Ignore temporary files ending in `.tmp`.
5. Handle both moves and deletions.
6. Stop cleanly with `Ctrl+C`.

---

## Discussion Questions

1. Why is Watchdog preferable to sleeping and repeatedly polling a directory?
2. Why should directory events be treated differently from file events?
3. What happens when a large file is modified while another process is writing
   it?
4. Which file changes could generate multiple modified events?
5. How could this program be used in an automated build or upload workflow?

---

## Key Takeaways

* `Observer` watches a path.
* `FileSystemEventHandler` receives filesystem events.
* Event handlers should check whether an event represents a file.
* Recursive monitoring watches nested directories.
* The observer must be stopped and joined before the program exits.
* File extension filters help programs respond only to relevant files.
