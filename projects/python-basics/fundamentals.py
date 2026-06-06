name = "Bashir" 
age = 30
salary_target = 60000 
hired = False
print(f"My name is Bashir and my target salary is £{60000}")

regions = ["eu-west-2", "us-east-1", "ap-southeast-1"]
print(f"My primary region is {regions[0]}")

server = {
  "name": "web-server-01",
  "region": "eu-west-2",
  "status": "healthy",
  "cpu": 45
}

print(f"Server {server['name']} in {server['region']} is {server['status']}")

for region in regions:
  print(f"Deploying to {region}")

def check_server(name, status):
    if status == "healthy":
        print(f"{name} is running fine")
    else:
        print(f"ALERT: {name} is down - investigate immediately")

check_server("web-server-01", "healthy")
check_server("db-server-01", "unhealthy")  