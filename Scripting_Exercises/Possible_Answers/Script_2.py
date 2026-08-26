# Need to pip install requests

import requests

url = "https://jsonplaceholder.typicode.com/posts"

try:
    response = requests.get(url, timeout=10)

    if response.status_code == 200:
        print("API is Healthy")
    else:
        print(f"API returned {response.status_code}")

except Exception as e:
    print("API Down:", e)