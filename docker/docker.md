
# Docker
```
docker run hello-world
```


connect port 80 of my client to port 80 of my image. p is for ports d is for detached mode
```
 docker run -d -p 80:80 nginx
 ```

## to get container id
 docker ps


## go to `localhost` on browser to see:

![alt text](<images/Screenshot 2024-04-16 at 15.46.47.png>)

## To stop

`docker stop` <container_id>
![alt text](<images/Screenshot 2024-04-16 at 15.49.01.png>)

to start, we will be back where we left off

`docker stop` <container_id>


## To delete:

docker rm <container_id> -f

or safer to stop it then remove:

`docker stop` <container_id>
docker rm <container_id>

it is gone
![alt text](<images/Screenshot 2024-04-16 at 15.52.29.png>)


## See all containers:
```
docker ps -a
```



## To enter container:

* it is interactive mode
* sh is shell
```
docker exec -it d6fad36d83aa sh
```
![alt text](<images/Screenshot 2024-04-16 at 15.57.11.png>)





## get machine name 
```
uname -a
```

## Update everything, install dependencies
```
apt-get update -y
apt-get upgrade -y
apt-get install sudo

```

## How to get to nginx html file:


```
# pwd
/
# cd /usr
# pwd
/usr
# cd /share
sh: 8: cd: can't cd to /share
# cd share
# pwd
/usr/share
# cd nginx
# pwd
/usr/share/nginx
# cd html
# pwd
/usr/share/nginx/html
# 
```

## install nano and edit html file
```
ls
cat index.html

sudo apt-get install nano
sudo nano index.html
```
![alt text](<images/Screenshot 2024-04-16 at 16.05.52.png>)

so quick!
![alt text](<images/Screenshot 2024-04-16 at 16.05.07.png>)

##
To exit container just click `exit`.



docker run -d -p 90:80 <container_id> image name


docker run -d -p 80:80 nginx


## To create my own image:

**1.** First I must  create an image of the nginx container we just edited as I don't want to push the existing image, but rather the one that I have just made. To do this I must save changes on new image. I made some changes again to the html text (not needed, I was just curious)
```
docker commit b57b620c3e12
``` 

**2.** To find image as you have not added a tag it will be marked as `none`:

```
docker images -a 
```
![alt text](<images/Screenshot 2024-04-16 at 17.05.19.png>)

**3.** I must then tag the image
```
docker tag 4930b8f9436a scarlett100/tech257morgan
```
**4.** Then push the image to my repository

```
docker push scarlett100/tech257morgan
```


![alt text](<images/Screenshot 2024-04-16 at 17.06.20.png>)


![alt text](<images/Screenshot 2024-04-16 at 17.07.17.png>)

**5.** Now to test my image

run (i put 250 as it was unlikely to be a port in use)

```
docker run -d -p 250:80 scarlett100/tech257morgan
```

**6.** it works!
![alt text](<images/Screenshot 2024-04-16 at 17.09.10.png>)



