# Need to pip install requests

import requests
import time

url = "https://google.com"

start = time.time()

response = requests.get(url)

end = time.time()

print(f"Response Time: {end-start:.2f} seconds")