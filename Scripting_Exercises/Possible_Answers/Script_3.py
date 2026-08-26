import psutil

cpu = psutil.cpu_percent(interval=1)

print(f"CPU Usage: {cpu}%")

if cpu > 80:
    print("WARNING: High CPU Usage")