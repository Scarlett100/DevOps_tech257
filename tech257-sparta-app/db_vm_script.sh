
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
