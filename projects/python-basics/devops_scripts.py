import json

server_data = {
    "name": "web-server-01",
    "region": "eu-west-2",
    "status": "healthy",
    "cpu": 45
}

json_string = json.dumps(server_data, indent=2)
print(json_string)

json_input = '{"name": "db-server-01", "region": "eu-west-2", "status": "unhealthy"}'

server = json.loads(json_input)
print(f"Server {server['name']} is {server['status']}")

# Writing to a file
with open("server_log.txt", "w") as f:
    f.write("web-server-01 is healthy\n")
    f.write("db-server-01 is unhealthy\n")

# Reading from a file
with open("server_log.txt", "r") as f:
    contents = f.read()
    print(contents)

try:
    with open("missing_file.txt", "r") as f:
        contents = f.read()
except FileNotFoundError:
    print("File not found - check the path and try again")    


import boto3

ec2 = boto3.client("ec2", region_name="eu-west-2")
response = ec2.describe_instances()

for reservation in response["Reservations"]:
    for instance in reservation["Instances"]:
        instance_id = instance["InstanceId"]
        state = instance["State"]["Name"]
        instance_type = instance["InstanceType"]
        print(f"{instance_id} — {instance_type} — {state}")