
# ssh

## 1. In your terminal, in the ssh folder, run this command so we can generate a new key.
```
ssh-keygen -t rsa -b 4096 -C "<enter email>
``` 
It uses the RSA  to create two keys:

A secret key (like a master key) you keep only for emergencies.
A public key (like a copy you can give to friends, that only they can use) that lets you connect securely.


## 2. Display the contents of file


``` 
cat <keyname>, displays the contents of a file named <keyname> on your computer screen
``` 

``` 
cat <KEYNAME>.pub
``` 
## 3
deploy keys on Git hub <— if only for one repo
if not and want to do for whole account add keys to github as opp0sed to deploy

## 4
``` 
cd .. #make sure to not be in ssh folder!!!!
``` 
``` 
eval `ssh-agent`
`this lets the process know the key exists, must do this every time in a new terminal.

#4
``` 
ssh-add ~/.ssh/<key name> 
``` 
 must run every time on a new terminal to register key!!! start with this, doesn’t matter where you are in file structure. We unlock the private key, so we specify that.
 ``` 

  ## 5. Lets test our connection!

``` 
ssh -T git@github.com 
``` 

 This command tries to connect to GitHub securely using SSH, but it doesn't aim to open a terminal window or allow you to type commands on the remote server. It's more like a test to see if your SSH keys are set up correctly for connecting to GitHub.

You can see below i get a message to suggest qI have been succesful.
Hi Scarlett100/git-test-repo! You've successfully authenticated, but GitHub does not provide shell access.

I can now clone, push, pull, etc succesfully using ssh.


# Please remember:

Never push/add/expose a private key!
