### Differences between AWS and Azure


By Default



**<center>VM's IP Address:</center>**
  

  |          Azure                                               |                    AWS                                     |
| :----------------------------------------------------------: | :--------------------------------------------------------: |
| When we create an image on Azure, it terminates the VM**   | Whereas on AWS, we do not need to terminate the VM.    |
| Static VM IP by default (stay the same)                  | Dynamic VM IP by default (change with every stop/start, to make them static we can use "elastic IPs"). |



**Creating an Image:**

  - AZURE: when creating an image we need to deprovision the user first useing "waagent", rendering vm unusable, whereas, aws it can all be done on interface and can be reused.
  




**<center>Resource groups:</center>**


| Azure                                  | AWS                                    |
| :------------------------------------ | :------------------------------------- |
| Resources must go in a resource group | Resources can, but it is not mandatory |




**<center>Virtual network:</center>**



|          Azure                     |                      AWS                                    |
| :--------------------------------: | :--------------------------------------------------------: |
| Create own from the beginning      | Default VPC given for you to use, and subnets are attached/connected to each AZ zone |




**<center>Security Groups:</center>**

Azure: set security groups so that sg's can protect/ be linked to two things: NIC(WHICH CONNECTS TO VM)  AND SUBNET

aws: Security group is linked to NIC, BUT FOR SUBNET YOU USE NACL (IF YOU WANT TO ATTACH SG TO SUBNET)

**Terminology**
- Azure: "Create VM", AWS: "Launch instance"
- AZURE: "NSG", AWS: "SG"
- Azure: Azure monitor  AWS: cloudwtch


- Azure:1 MIN AWS: 5MINS
- azure: scalesets, aws: autoscaling groups.

**autoscaling:**
- in **aws** autoscaling group: you need a launch template .
launch templates: when we launch an image we need launch template for the config (eg. pem file,)


**monitoring**
- Azure monitoring of Vms, 1 min is default.
- AWS: have to turn on detailed monitoring to change default of 5 mins to 1 min.


 **storage**
 blob s3
 containers bucket


 S3 -simple storage services

 advantages:
 - Limitless
 - Security: prtivate by default 
 - Accessible: url/endpoint to access storage from anywhere
 - redundancy: built in from the start. multiple copies of things in case of a disaster.
 - 