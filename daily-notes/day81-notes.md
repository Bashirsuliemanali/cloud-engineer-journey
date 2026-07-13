Day 81

Python session 2 done today

Covered JSON, learned that AWS API responses come back as JSON 
and Python handles it with json.dumps() to convert a dictionary 
to JSON and json.loads() to convert JSON back to a dictionary. 
Seen this format before in the terminal, didn't know it was called 
JSON.

Learned how to read and write files in Python using open() with 
read and write modes. Always use "with open()" so Python closes 
the file automatically.

Error handling with try and except, instead of the script 
crashing when something goes wrong, you catch the error and 
handle it cleanly. Important for scripts running automatically 
in production.

The big one today was boto3. Installed it in a virtual 
environment, wrote a script that talked directly to my AWS 
account and pulled back all EC2 instances in eu-west-2 — 
instance ID, type and state. Same data as the AWS CLI but 
pulled with Python I wrote myself.

