# Blob Task

Our task was to create a storage account, container and blob via a script on a vm that had a vm that already had the app running. Once we were able to do that and get the blob image  showing we then had to create a script to delete the container and its contents.
<br>
I had to edit my script a few times because it was not finding the index.ejs file. So I decided to make it very clear how to get to index file by cd'ing into folder instead of having views/index.ejs in sed file, just index.ejs. First we had to have the app running, then write a script to add the cat.
<br>
You can see in my screenshot below, the cat is showing! Below I will explain hoe I got there.

![alt text](<Screenshot 2024-03-15 at 10.28.18.png>)


# Prerequisites

First of all, it was important the app was workingso I spun up a vm pm2 start.
you must also install and be logged into the azure cli otherwise this will not work! 
 ```
 curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
 az versionaz 
 az login
  ```



# Ownership and Permission

First of all I had to run the following commands in the root directory so that I could make and edit and save a script in the app folder:
 ```
 # Change ownership recursively to adminuser:adminuser
sudo chown -R adminuser:adminuser /tech257-sparta-app
# Change permissions recursively to 755 
sudo chmod -R 755 /tech257-sparta-app

re 755:
4 for read (r)
2 for write (w)
1 for execute (x)

The owner has read, write, and execute permissions 7
The group has read and execute permissions 5
Others have read and execute permissions 5
 ```

 # <center> Access <center/>
One of the things I found incredibly useful, was on Microsoft documents, it mentioned you can add anonmous access when creating containers and storage accounts.<br>
For example at the end of making a storage account you can add: 
 ```
 --allow-blob-public-access true
 ```
 You can see the full command below when making a storage account:
 <br>

  ```
# Create a storage account
az storage account create \
 --name tech257morganstorage \
 --resource-group tech257 \
 --location uksouth \
 --sku Standard_LRS \
 --allow-blob-public-access true
 ```

 Likewise when making a container we can do the same, but it is imperative we also **set** the permission afterward. Note the  --public-access container flag. 

 ```
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
 ```


# <center> Working Blob Script <center/>

To note, this is run within app folder!
<br>

 ```
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

 ```

 

## STORAGE ACCOUNT
Below you can see my storage account has been created and exists:
<br>
![alt text](<Screenshot 2024-03-15 at 10.39.54.png>)

 ## CONTAINERS ACCOUNT
Below you can see my container has been created and exists:
<br>
![alt text](<Screenshot 2024-03-15 at 10.40.39.png>)

## BLOBS
Below you can see my blob has been created and exists:
<br>
![alt text](<Screenshot 2024-03-15 at 10.44.05.png>)


# Revert


Next we had to revert, in order to close our storage accounts and remove the blob. If you notice, at the end of my sed command I have: */d*.  This is the sed command to delete lines that match the specified pattern. So, in this case, it's searching for lines containing the specified <img> tag and deleting them.
This was my process:


## script for revert-homepage.sh
```
#!/usr/bin/bash

# navigate to folder

cd views

# revert image

sudo sed -i "/<img src=\"https:\/\/tech257morganstorage\.blob\.core\.windows\.net\/testcontainer\/newcat\.jpg\">/d" index.ejs

# navigate to app2 folder

cd ..


# kill pm2 process

pm2 kill 

# start pm2

pm2 start app.js

# remove storage account created in the blob creation script:

az storage account delete -n tech257morganstorage -g tech257 --yes
```
As you can see below the blob (or cat) is gone.

![alt text](<Screenshot 2024-03-17 at 15.55.14.png>)
 

# References

https://learn.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure?tabs=azure-cli

