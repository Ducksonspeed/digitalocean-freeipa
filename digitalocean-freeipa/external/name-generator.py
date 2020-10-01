import json, time

fixed_name = "freeipa"
result = {
  "name": f"{fixed_name}-{int(time.time())}",
}

print(json.dumps(result))