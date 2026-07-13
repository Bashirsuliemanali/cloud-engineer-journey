import json

with open("terraform/outputs.json") as f:
    data = json.load(f)

print("EC2 Public IP:", data["instance_public_ip"]["value"])