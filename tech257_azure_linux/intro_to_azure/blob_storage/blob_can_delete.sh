 #!/usr/bin/bash

 # change the ownership
sudo chown -R adminuser:adminuser /home/adminuser/tech257-sparta-app

#full permissions over the directory and its contents
sudo chmod -R 755 /home/adminuser/tech257-sparta-app

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

# Create a storage account
az storage account create --name tech257morganstorage --resource-group tech257 --location uksouth --sku Standard_LRS  --allow-blob-public-access true


#enable anonymous blob access on storage account
# added a  --allow-blob-public-access flag to storage account


# create container
 az storage container create \
    --account-name tech257morganstorage \
    --name testcontainer \
    --public-access on \
    --auth-mode login

#az storage container set-permission to make blob public\
az storage container set-permission \
    --name testcontainer \
    --account-name tech257morganstorage \
    --public-access container \
    --auth-mode login

#download a cat picture (jpg) using the curl command
curl -o NationalGeographic_2572187_square.jpg https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg

#rename the cat pic to newcat.jpg
mv NationalGeographic_2572187_square.jpg newcat.jpg

#upload blob

az storage blob upload \
    --account-name tech257morganstorage \
    --container-name testcontainer \
    --name newcat.jpg \
    --file newcat.jpg \
    --auth-mode login

#make blob public <--command done with container
# Git Clone
git clone https://github.com/Scarlett100/tech257-sparta-app.git

# Install Node.js and npm
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# CD into app2 folder
cd tech257-sparta-app/app2

# Install npm dependencies
npm install

#modify homepage file (index.ejs found in views folder) to include cat image in blob storage (could use sed command to replace )

# first i did this by Define variables for storage account name, container name, and blob name
#storage_account="tech257morganstorage"
#container_name="testcontainer"
#blob_name="newcat.jpg"

# Generate the blob URL using the variables
#blob_url="https://$storage_account.blob.core.windows.net/$container_name/$blob_name"

sudo sed -i "/<h2>The app is running correctly.<\/h2>/a <img src=\"https://tech257morganstorage.blob.core.windows.net/testcontainer/newcat.jpg\">" /views/index.ejs

# find out line before it again

# cd back to app folder so we can start pm2
#cd .. (dont't think needed if just ruuning a sudo said)

#use pm2 to start the app
sudo npm install pm2@latest -g

#stopPm2 before rerunning. 
pm2 stop app.js

#start the app using pm2
pm2 start app.js

