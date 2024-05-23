
# Manually connect database and VM




The goal with this task is to get /posts page working manually to do this, we will need to to deploy a database and connect a database vm and our app vm through an environment variable that houses our private IP.

- [Manually connect database and VM](#manually-connect-database-and-vm)
- [Create db vm](#create-db-vm)
- [Manually work out each command](#manually-work-out-each-command)
- [Install mongo db](#install-mongo-db)
- [Edit bind file in vim:](#edit-bind-file-in-vim)
- [In app vm](#in-app-vm)
- [NPM Install](#npm-install)
- [Check application](#check-application)
- [Check application with database](#check-application-with-database)
- [references](#references)
- [Working db script](#working-db-script)
- [working app script](#working-app-script)





# Create db vm

There are a few things to note:
1. private subnet
2. using ramons image for now
3. only using ssh port
 <br>

 As you can see below, the validation passed.
   
![alt text](<../images/Screenshot 2024-03-13 at 11.59.06.png>)
# Manually work out each command

Once I had ssh'd into my vm I ran an update and upgrade:
 ``` 
# Update
sudo apt update -y

#  upgrade for bypassing user input
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

 ``` 

# Install mongo db

``` 
# install curl
sudo apt-get install -y gnupg curl

# get our key

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor


echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# run an update
sudo apt-get update -y

# install mongo

sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.1.5 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6
``` 

# Edit bind file in vim:

``` 
sudo vim /etc/mongod.conf
change bind ip to all 0's so that we have the correct bind IP

check changes made
cat /etc/mongod.conf

# check status again:
sudo systemctl status mongod
You will see that it is running, as seen in photo below.
``` 

![alt text](<../images/Screenshot 2024-03-13 at 12.23.39.png>)


# In app vm
 Next we in another terminal and ssh into our app vm (remember we are using the public ip) and run:

 ``` 

 export DB_HOST=mongodb://<ip-address>:27017/posts

 export DB_HOST=mongodb://10.0.3.5:27017/posts

Note, that we use the *private* ip of the db vm.
Also note, in our script, we may not want to connect to db, so we can comment this DB_HOST line out.


 Check env variable has been set
 ``` printenv DB_HOST 

``` 

If we have used pm2 with user data, as we have it will not stop the process so we must first find the process id with 
``` 
ps aux

 ``` 

 <br>
 then we must find pm2, and kill it. To do this we must run:
 <br>

 ``` 
 sudo kill 968 <968 is pm2 process id>

  ``` 


![alt text](<../Linux/Screenshot 2024-03-13 at 12.45.59.png>)

# NPM Install

If we just run the usual npm install command from where we are in folder structure it will fail.


![alt text](<../Linux/Screenshot 2024-03-13 at 13.08.43.png>)

If we have app folder in home directory, this next step with sudo -E is not necessary,  but since I do not have app folder in home directory I must add an **-E** tag

  ``` 
sudo -E npm install

sudo -E npm start
  ``` 

![alt text](<../Linux/Screenshot 2024-03-13 at 13.09.43.png>)


# Check application


App will now be back up running if we put the public ip of app vm into our browser.

![alt text](<../Linux/Screenshot 2024-03-13 at 12.53.56.png>)

# Check application with database

We will see app is back online and post page works once we add /posts to the end of ip in browser.

![alt text](<../Linux/Screenshot 2024-03-13 at 12.52.55.png>)




# references

https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
https://www.hostinger.co.uk/tutorials/how-to-install-mongodb-on-ubuntu/


# Working db script


The below will get the db working via script.

 ``` 
#!/bin/bash


# get our key

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor


echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# run an update
sudo apt-get update -y

# install mongo

sudo apt-get install -y mongodb-org=7.0.6 mongodb-org-database=7.0.6 mongodb-org-server=7.0.6 mongodb-mongosh=2.1.5 mongodb-org-mongos=7.0.6 mongodb-org-tools=7.0.6


# Configure MongoDB to accept connections from anywhere by setting bindIp to 0.0.0.
sudo sed -i 's@127.0.0.1@0.0.0.0@' /etc/mongod.conf


# Restart MongoDB service to apply changes
sudo systemctl restart mongod

# Enable MongoDB service to start on boot
sudo systemctl enable mongod


 ``` 




# working app script

```
#!/bin/bash

# Update
sudo apt update -y

#  upgrade for bypassing user input
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# Install nginx
sudo apt install -y nginx

#reverse proxy 
sudo sed -i "s|try_files .*;|proxy_pass http://127.0.0.1:3000;|g" /etc/nginx/sites-available/default

# Restart nginx
sudo systemctl restart nginx

# Enable nginx
sudo systemctl enable nginx

# cd into root so it clones there on our vm
cd /

# Git Clone
git clone https://github.com/Scarlett100/tech257-sparta-app.git

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# CD into app2 folder
cd tech257-sparta-app/app2

# Install npm dependencies
npm install

# Start npm (can also use node.js)
#npm start <-- not needed if doing pm2, because script will never reach pm2 if npm is started.

# Install pm2
sudo npm install pm2@latest -g

#stopPm2 before rerunning.
pm2 stop app.js

# Start app with pm2
pm2 start app.js

```