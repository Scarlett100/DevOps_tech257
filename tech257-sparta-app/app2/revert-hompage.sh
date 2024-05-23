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
