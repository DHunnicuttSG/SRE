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
