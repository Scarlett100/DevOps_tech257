


# Auto scaling with db

I had to get the db running on 22.04 ubuntu lts then set up an auto scaling group after launching a template built on my ami and show the Autoscale Node JS 20 Sparta app WITH /posts page working. opening up the mongo DB port in SG and only autoscaling the app instances.


First I had to setup the db and check nginx was running however, I had misread and used the wrong image (20.04) so got stuck at this point this was a big blocker.

![alt text](<images/Screenshot 2024-04-10 at 15.01.42.png>)

However, had I got further I would have gone through the process of creating a launch template then the steps [here](https://github.com/Scarlett100/tech257_aws/blob/master/HA-SC_with_AWS.md) to create an asg as listed and used the db private ip. 

my db script I had hoped to use:

```
#!/bin/bash

# Update & upgrade
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y



# run an update
sudo apt update -y

# run an upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq


# vim into the config file to stop need for restarts (remember this is just for ubuntu 22.04)
sudo vim /etc/needrestart/needrestart.conf

 
# change the line to 'a' from 'i' - Check this works!
sudo sed -i "s/#\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/g" /etc/needrestart/needrestart.conf

# get our key and download mongodb
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc |   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg   --dearmor


# creates list file
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

# update again
sudo apt-get update -y

# Install MongoDB
# Install the latest version
sudo apt-get install -y mongodb-org
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# change the bind ip
sudo sed -i 's@127.0.0.1@0.0.0.0@' /etc/mongod.conf

# restart mongodb
sudo systemctl restart mongod

# enable mongod
sudo systemctl enable mongod

# check mongod status
sudo systemctl status mongod
```


if this doesn't work for me , then after speaking with colleagues I realised i may need to change the mongodb install version to latest in script:

```
# Install the latest version
sudo apt-get install -y mongodb-org
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

```


test with sudo systemctl status mongod

I did not get a chance to try the above and get it working but I believe chaging the mongo to latest on correct image would have worked.

Had I finished this my next task would have been to do the following:

Use Terraform to create:
- Security groups
- DB instance from custom AMI
- Launch template for ASG (autoscale only the app with HA-SC)
- ASG
