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




#set ENV Variable, comment out if dont want to connect to db!
export DB_HOST=mongodb://10.0.3.5:27017/posts

# Git Clone
git clone https://github.com/Scarlett100/tech257-sparta-app.git

# CD into app2 folder
cd tech257-sparta-app/app2

#npm install
sudo -E npm install

# Install pm2
sudo npm install pm2@latest -g

#stopPm2 before rerunning.
pm2 stop app.js

# Start app with pm2
pm2 start app.js