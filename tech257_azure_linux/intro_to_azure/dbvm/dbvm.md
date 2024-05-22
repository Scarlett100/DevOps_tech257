
#  <center> 3 subnet architecture to make the database private <center/>

![alt text](<Screenshot 2024-03-19 at 09.19.09.png>)


# 1.Create a virtual network
Virtual Networks give us the base for our private network within Azure. 
VM's are resources within a virtal network. The benefits of using an azure virtual network can be scalability, availability, and isolation for your infrastructure.


* First, create a whole new vn with 3 subnets: public, demilitarised and private as you can see below. 
* The ip for our public subnet was: 10.0.2.0
* The ip for our dmz subnet was: 10.0.3.0
* The ip for our private subnet was: 10.0.4.0
<br>

![alt text](<Screenshot 2024-03-18 at 10.38.27.png>)

## Private Subnet
* The ip for our private subnet was: 10.0.4.0
* As mentioned on the Azure site *"Private subnets enhance security by not providing default outbound access."*  <br>
  
![alt text](<Screenshot 2024-03-18 at 10.35.30.png>)

Our vn again in whole:
![alt text](<Screenshot 2024-03-18 at 10.38.27.png>)

When reviewing it is important for this to be enabled:

![alt text](<Screenshot 2024-03-18 at 10.39.17.png>)


# 2. Create a virtual machine for db using image

Next, it is important to create a virtual machine for the db.

The most important steps were too:
* use Ramons custom ready to run db image
* Put the db in zone 3 in line with or diagram
* give **"none"** as an option for public ip
* private subnet
* Allow only port 22.
![alt text](<Screenshot 2024-03-18 at 10.49.40.png>)
![alt text](<Screenshot 2024-03-18 at 10.51.07.png>)
![alt text](<Screenshot 2024-03-18 at 10.52.32.png>)

#  3. Create app vm using our own image:
Next, we created a vm using our own app image. There were 3 things to note.
* Put availiability zone in Zone 1
* use your custom app image
* input user data
* don't need to put an advanced security group with port 3000 enabled because we have allowed via the proxy in script, just basic and allow port 80 and ssh. No need to create an advanced security group as these are basic options

![alt text](<Screenshot 2024-03-18 at 11.00.17.png>)


Below is what we put into user data, if you notice the mongo db has the export line has the private ip of the db vm.

```
#!/bin/bash

export DB_HOST=mongodb://10.0.4.4:27017/posts

# CD into app2 folder
cd /tech257-sparta-app/app2

#stopPm2 before rerunning.
pm2 kill

# Start app with pm2
pm2 start app.js

```

We can see the app works and is connected to db when we run http://<ip_for_app_vm>>/posts 

![alt text](<Screenshot 2024-03-18 at 11.10.34.png>)

# 4.  Create dmz vm using ramon clean img


Next, is a demiliterized vm.
* for ports only ssh is necessary

![alt text](<Screenshot 2024-03-18 at 15.07.40.png>)

what we have put in our user data to ensure a clean slate
```
#!/bin/bash

# Update
sudo apt update -y

#  upgrade for bypassing user input
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
```

# 5. ssh in & ping
Next we must ssh into **app** vm to check nva is running by running a ping command with the **db** vm ip(10.0.4.4)
```
ping 10.0.4.4
```

![alt text](<Screenshot 2024-03-18 at 11.48.55.png>)


# 6. Set up routing
* go to search bar and select route tables
* make a route table to get traffic to go to private subnet

![alt text](<Screenshot 2024-03-18 at 15.16.36.png>)
##  Set up a route:
* within Route table, on left hand side navigate to route and add a route by
* Put the private subnet cidr range in first bit.
* put the nva ip as the next hop
![alt text](<Screenshot 2024-03-18 at 11.58.26.png>)
Then associate by going to **subnets** on right hand side,
![alt text](<Screenshot 2024-03-18 at 12.00.16.png>)
![alt text](<Screenshot 2024-03-18 at 15.28.46.png>)

You will now notice our pings stop. You will also notice a problem with the posts page:

![alt text](<Screenshot 2024-03-18 at 12.02.54.png>)

# 7. Enable ip forwarding on Azure
As aforementioned this must be applied in two places: Azure and in Linux.
On Azure in the nva vm so we can set up ip4 enabling on the network interface card:<br>
  *  go to network setting press the big button.
choose **Enable ip forwarding** and click **Apply**
![alt text](<Screenshot 2024-03-18 at 15.33.07.png>)
![alt text](<Screenshot 2024-03-18 at 15.34.37.png>)

In linux on our nva vm run the below (do this in another terminal so you can watch the other app terminal)

Below you can see when running this command, nothing is being forwarded
```
sysctl net.ipv4.ip_forward
```
![alt text](<Screenshot 2024-03-18 at 12.08.20.png>)


## changing file to enable forwarding
```
sudo vim /etc/sysctl.conf
```
![alt text](<Screenshot 2024-03-18 at 15.40.17.png>)

It is important we change the ip foward to = 1, what you will notice in the script is that it does, but it is commented out. Thus we must uncomment it and check.
```
cat /etc/sysctl.conf |grep ip_forward
```
![alt text](<Screenshot 2024-03-18 at 12.11.18.png>)

To apply ip forwarding we need to reload config file , you will notice the pings restart. we can use command below
```
sudo sysctl -p
```
Now the packets are being fowarded onto the private subnet!

# 8 Configure the ip tables
Next, a scripts must be made in the **nva vm** called config-ip-tables.sh
```
vim config-ip-tables.sh
```

Within the script we put the below:

```
#!/bin/bash
 
# configure iptables
 
echo "Configuring iptables..."
 
# Allow incoming traffic on the loopback interface.
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow outgoing traffic on the loopback interface.
sudo iptables -A OUTPUT -o lo -j ACCEPT
 
# Allow incoming traffic that is part of an established connection or related to an established connection.
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
 
# Allow outgoing traffic that is part of an established connection.
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT
 
# Drop incoming packets that are not part of any established connection.
sudo iptables -A INPUT -m state --state INVALID -j DROP
 
# Allow incoming TCP traffic on port 22 (SSH) for new connections and established connections.
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT

# Allow outgoing TCP traffic from port 22 (SSH) for established connections.
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH into NVA only through the public subnet (app VM as a jumpbox)
# this must be done once the NVA's public IP address is removed
#sudo iptables -A INPUT -p tcp -s 10.0.2.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT
 
# uncomment the following lines if want allow SSH to other servers using the NVA as a jumpbox
# if need to make outgoing SSH connections with other servers from NVA
#sudo iptables -A OUTPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
#sudo iptables -A INPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
 
 Allow TCP traffic from source network 10.0.2.0/24 to destination network 10.0.4.0/24 on port 27017 for forwarding.
sudo iptables -A FORWARD -p tcp -s 10.0.2.0/24 -d 10.0.4.0/24 --destination-port 27017 -m tcp -j ACCEPT
 

# Allow ICMP traffic from source network 10.0.2.0/24 to destination network 10.0.4.0/24 for forwarding.
sudo iptables -A FORWARD -p icmp -s 10.0.2.0/24 -d 10.0.4.0/24 -m state --state NEW,ESTABLISHED -j ACCEPT
 
# Set the default policy for incoming packets to DROP (deny all unless explicitly allowed).
sudo iptables -P INPUT DROP
sudo iptables -P INPUT DROP
 
# Set the default policy for forwarded packets to DROP (deny all unless explicitly allowed).
sudo iptables -P FORWARD DROP
 
echo "Done!"
echo ""
 
# make iptables rules persistent
# it will ask for user input by default
 
echo "Make iptables rules persistent..."
sudo DEBIAN_FRONTEND=noninteractive apt install iptables-persistent -y
echo "Done!"
echo ""
```

You can see site works again:

![alt text](<Screenshot 2024-03-18 at 15.57.40.png>)


# questions to ask later
where does this go?
node seeds/seed.js