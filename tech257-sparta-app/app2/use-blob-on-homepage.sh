#!/usr/bin/bash

# upgrade for bypassing user input <-- may not be needed but just in case
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq


# Create a storage account
az storage account create --name tech257morganstorage --resource-group tech257 --location uksouth --sku Standard_LRS  --allow-blob-public-access true

# sleep for 15

sleep 15

# enable anonymous blob access on storage account
# added a  --allow-blob-public-access flag to storage account


#create container
 az storage container create \
    --account-name tech257morganstorage \
    --name testcontainer \
    --public-access container \
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

# CD into app2/views folder
cd views

# make a backup of this file
sudo cp index.ejs index.ejs.bk

# modify homepage file (index.ejs found in views folder) to include cat image in blob storage (could use sed command to replace )
sudo sed -i "/<h2>The app is running correctly.<\/h2>/a <img src=\"https://tech257morganstorage.blob.core.windows.net/testcontainer/newcat.jpg\">" index.ejs

# cd back to app folder
cd ..


# stopPm2 before rerunning.
pm2 kill 

# Start app with pm2
pm2 start app.js

