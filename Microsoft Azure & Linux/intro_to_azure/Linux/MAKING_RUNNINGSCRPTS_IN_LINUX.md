



- [make an](#make-an)
- [sudo apt install](#sudo-apt-install)
- [sudo apt install](#sudo-apt-install-1)
- [Environment Variables](#environment-variables)
- [making my own VARIABLE TO STORE AND RETIEVE](#making-my-own-variable-to-store-and-retieve)




make a script that is starts a webserver.
# make an
touch prov-nginx.sh
nano into it
shebang.

#! /bin/bash <--put shebamg in> must go at beginning of every script file
# sudo apt install
# sudo apt install
must be next few lines


sudo systemctl  status nginx <-- 
![image](../images/ngixrunterminal.png)

control c <-- how to get out of it

![image](../images/Nginx_running.png)

![image](../images/newscript.png)

chmod +x prov-nginx.sh <--- give executable permissions>

![image](../images/scriptcontents.png)

./prov-nginx.sh <--running our script

![image](../images/scripthasrun.png)


# Environment Variables

values stores in memory that are accessible to different softwares and tools 

printenv USER
![image](../images/env_var.png)

printenv
# making my own VARIABLE TO STORE AND RETIEVE
MYYNAME=morgan
![image](../images/store_retrieve_variable.png)


TO MAKE MY OWN ENV VARIABLE
use 
export env_var=input
then you can 
printenv env_var

![image](../images/ENVIRONMENT_VARIABLE.png)

The problem is this doesn't persist! if you close and come back it will not be there.

![image](../images/persistentdata.png)

we need to change in the bash file.

![image](../images/nano.png)

We then need to reload the file to make it up to date, we can do it with the command:

source .bashrc

![image](../images/source.png)

it is now truly persistent!