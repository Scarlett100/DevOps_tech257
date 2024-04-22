

**AMI**


An Amazon Machine Image (AMI) is a aws provided image with information required to launch an instance. This info includes *"Elastic Block Store (Amazon EBS) snapshots,  a template for the root volume of the instance (for example, an operating system, an application server, and applications), launch permissions that control which AWS accounts can use the AMI to launch instances and A block device mapping that specifies the volumes to attach to the instance when it's launched."*
Multiple instances can be launched from a single AMI if you want the same config. You cannot create an instance without specifying an AMI.

Below is the AMI Lifecycle according to aws:

![alt text](<images/Screenshot 2024-04-09 at 11.46.36.png>)


To get the app up and running I used the following in user data for my vm, we cannot launch a ami based off the app without a running app. please note this is on `ubuntu lts 22.04`.



```
#!/bin/bash
 
# Update and upgrade packages
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
 
# Install Nginx
sudo apt install nginx -y
 
# Restart and enable Nginx to run on startup
sudo systemctl restart nginx
sudo systemctl enable nginx
 
# Install Node.js 20.x (this also installs npm as a dependency)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
 
echo "Installing Node.js..."
echo
 
sudo apt-get install -y nodejs
 
echo "Node.js Installed: version: $(node -v)"
echo
 
# Install pm2 globally
sudo npm install pm2@latest -g
 
echo "Installed pm2"
 
# Clone the app from GitHub
git clone https://github.com/followcrom/tech257-sparta-app.git
 
echo "Cloned the app from GitHub"
 
# Navigate to the app directory
cd tech257-sparta-app/app
 
# Install dependencies
npm install
 
echo "Installing dependencies..."
 
echo "Installed dependencies"
 
NGINX_CONF_PATH="/etc/nginx/sites-available"
 
cd $NGINX_CONF_PATH
 
NGINX_CONF="default"
 
# Display the full path of the Nginx configuration file being edited
echo "Updating Nginx configuration in: $NGINX_CONF_PATH/$NGINX_CONF"
echo
 
 
sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000/;|' $NGINX_CONF
 
# Test Nginx configuration for syntax errors
if sudo nginx -t; then
    echo "Nginx configuration syntax is okay."
    sudo systemctl restart nginx
    echo "Nginx restarted successfully."
else
    echo "Error in Nginx configuration. Check the config file at $NGINX_CONF_PATH/$NGINX_CONF."
fi
 
echo
 
cd -
 
if pm2 list | grep -q "online"; then
    pm2 stop all
    echo "Stopped all running processes."
else
    echo "No running processes found."
fi
 
echo
 
# Use pm2 to start app and ensure it runs in the background
pm2 start app.js --name "sparta-test-app"

```





## Create an AMI


To create an AMI, first you must have an instance with the app running on it.

**1.** Then on the instance click `actions > Images and templates > create Image.`


**2.** Begin to name istance and give a description in `Image name and Image description`

![alt text](<images/Screenshot 2024-04-09 at 10.36.37.png>)

**3.** Next it is crucial to add a **Name** tag in `add new tag`, otherwise yous AMI name will be blank.

![alt text](<images/Screenshot 2024-04-09 at 10.37.16.png>)

**4.** Click `create` in right hand corner

**5** Once this is done navigate to `AMI` on the left hand side of the screen.

**6** Search for your ami, you will notice it will be pending for a little while (about 5 mins), eventually it will change to `running`
![alt text](<images/Screenshot 2024-04-09 at 10.39.12.png>)

##  Create a vm from AMI

**1** On the AMI you will notice on the top there is a `Launch an Instance from AMI` button, click it.


**2** On instance creation page you will notice we have now got our ami preselected as seen below.

![alt text](<images/Screenshot 2024-04-09 at 11.16.13.png>)

**3** Follow it through, choosing all the normal choices `t2.micro, your app security group with port 80,22 and 3000 open for inbound`.

**4**
in `Adavnced` in the `user data`,  I put the following:

```
#!/bin/bash
 
# Navigate to the app directory from user data
cd /tech257-sparta-app/app
 
pm2 stop all
 
# Use pm2 to start app and ensure it runs in the background
pm2 start app.js --name "sparta-test-app"

```

**5** click `launch`

**6** you can see that if you go to the ip address, the app is running.
![alt text](<images/Screenshot 2024-04-09 at 11.25.00.png>)


##  To delete an AMI:


**1.** Navigate to your Ami and  click on it.

**2.** on `Actions` click `deregister`

**3.** **BEFORE** confirming the deregister, click on the option in yellow box to go to your `Snapshots screen`.

![alt text](<images/Screenshot 2024-04-09 at 11.28.59.png>)

keep the snapshots window open
![alt text](<images/Screenshot 2024-04-09 at 11.31.54.png>)

**4.** navigate back to the AMI TAB and choose to deregister
![alt text](<images/Screenshot 2024-04-09 at 10.48.03.png>)


### delete snapshot

**1.** navigate back to the snapshot page and delete the snapshot


Once app is running, you can delete original instance.


# references
* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html