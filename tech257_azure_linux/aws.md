virtual machines:


ec2 is aws service to launcg an instance

![alt text](<Screenshot 2024-03-19 at 10.43.49.png>)




we downloaded a pem file:

w then had to move it to .ssh
``` 
mv ~/Downloads/tech257.pem ~/.ssh/tech257.pem
 ``` 

once there we change the permissions
``` 
chmod 400 tech257.pem
``` 

Then we make a seurity group

![alt text](<Screenshot 2024-03-19 at 10.57.20.png>)

sudo apt update -y

Make sure port 80 and 22 are open at minimum.

![alt text](<Screenshot 2024-03-19 at 11.50.32.png>)



