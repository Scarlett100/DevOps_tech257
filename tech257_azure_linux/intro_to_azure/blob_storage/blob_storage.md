# <center> Blob Storage <center/>

Azure Blob Storage can be defined as *"Microsoft's object storage solution for the cloud"*. Blob Storage is allows for the storage of large amounts of unstructured data. 
<br>
Unstructured data (data that has no set structure and is unorganised) comes in a plethora of formats including emails, images, video files, audio files, social media posts, PDFs.
<br>
According to Azure,blob Storage is designed for:
<br>
* *"Serving images or documents directly to a browser".*
* *"Storing files for distributed access".*
* *"Streaming video and audio".*
* *"Writing to log files".*
* *"Storing data for backup and restore, disaster recovery, and archiving".*
* *"Storing data for analysis by an on-premises or Azure-hosted service".*
<br>
Blob Storage offers three types of resources:

* A storage account
* A container within the storage account
* A blob in a container

# Install azure cli on the command line in vm:
  ``` 
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  ``` 

then 
  ``` 
az --version
  ```  
  to check version

Then do an az login which will give us the output seen below: a link to follow and a code to add in once prompted on broswer . 
![alt text](<Screenshot 2024-03-14 at 10.06.46.png>)

# <center> Storage account <center/>

A storage account provides a unique space for your data within Azure. All objects stored in Azure Storage have an address that includes your account name (which is unique). The combination of the account name and the Blob Storage endpoint forms the base address for the objects within your storage account.

## Create a storage account
  ``` 
az storage account create --name tech257morganstorage --resource-group tech257 --location uksouth --sku Standard_LRS
  ``` 
you cannot use hypens in a storage account name, it will not run.


Once it runs you will get a lot on terminal, but most importantly you notice we have an endpoint for our blob.
![alt text](<Screenshot 2024-03-14 at 10.13.57.png>)
<br>
## list storage accounts in resource group
this will show all of the storage accounts in tech 257 but not easy to view.
az storage account list --resource-group tech257
<br>
##  Alternative way to list storage accounts in resource group
 You will notice this is much more structured.

``` 
az storage account list --resource-group tech257 --query "[].{Name:name, Location:location, Kind:kind}" --output table
``` 
storage accounts > your storage >your container >your image

# <center> Containers <center/>

A container organises a set of blobs, similar to a directory in a file system.Within a storage account, there is no limit to the amount of containers, likewise a container can hold an unlimited amount of blobs.

<br>
## create a container
 note that the backslashes mean new line

  ``` 
az storage container create \
    --account-name tech257morganstorage \
    --name testcontainer
  ``` 

 ## delete our container:
```
  az storage container delete \
    --account-name tech257morganstorage \
    --name testcontainer 
    --auth-mode login
```

    If you do not want the yellow writing to appear:
 ```
az storage container delete \
    --account-name tech257morganstorage \
    --name testcontainer \
    --auth-mode login
 ```
    

    ## create container again but with auth mode login:
    this is so it avoids the warning (yellow writing)
 ```
    az storage container create \
    --account-name tech257morganstorage \
    --name testcontainer \
    --auth-mode login
 ```


## to check how many containers you have,
 ```
    az storage container list --account-name tech257morganstorage --auth-mode login
 ```

## better more structured way to see
 ```
    az storage container list \
    --account-name tech257morganstorage \
    --output table \
    --auth-mode login
 ```

I then made a quick .txt file called test.txt and added some content

#  <center> Blobs <center/>
Azure Storage supports three types of blobs:

## upload our blobs

    az storage blob upload \
    --account-name tech257morganstorage \
    --container-name testcontainer \
    --name newname.txt \
    --file test.txt \
    --auth-mode login

## how to see blob listed on command line.

    az storage blob list \
    --account-name tech257morganstorage \
    --container-name testcontainer \
    --output table \
    --auth-mode login


## Allow Blob anonymous access

on interface we make some changes:

 ![alt text](<Screenshot 2024-03-14 at 10.51.39.png>) 

 Now we have to change the access on the container to allow blobs:

![alt text](<Screenshot 2024-03-14 at 10.54.05.png>)

Now if we  reload the page on the url we will get the contents of out txt file![alt text](<Screenshot 2024-03-14 at 10.56.08.png>)


# How to delete everything:

az storage account delete -n tech257morganstorage -g tech257
what you will need to automate:

things to do script wise:

make storage account public
anaonamous blob access
add a sleep for 15 seconds to make that work
make container public access
az storage account delete -n tech257morganstorage -g tech257 <-- find a way to make this so it doesnt ask me yes or no
(try this one: az storage account delete -n tech257morganstorage -g tech257 --yes)

# References
* https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction <br>
* https://www.coursera.org/articles/structured-vs-unstructured-data?utm_medium=sem&utm_source=gg&utm_campaign=B2C_EMEA__coursera_FTCOF_career-academy_pmax-multiple-audiences-country-multi&campaignid=20858198824&adgroupid=&device=c&keyword=&matchtype=&network=x&devicemodel=&adposition=&creativeid=&hide_mobile_promo&gad_source=1&gclid=Cj0KCQjwwMqvBhCtARIsAIXsZpYKd4PN4_jS7SWfpaW7AhEB4uqpAwfNKWfmoTTnEI4HBkcmGXGATngaAg8fEALw_wcB <br>
* https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-overview
  
modify front page so it uses and modifies 

vin

cd app2/views

after the app is running correctly in file:

<img src = "blobl"/v 


