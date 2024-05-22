# Monitoring and alert managment

- [Monitoring and alert managment](#monitoring-and-alert-managment)
  - [Get a cpu alert](#get-a-cpu-alert)

In order to monitor instances, navigate to `monitoring` on the instance.


**1.** click on `manage detailed moitoring` so that you can enable detailed monitoring
![alt text](<images/Screenshot 2024-04-09 at 16.59.38.png>)

**2.** Click `Enable`
![alt text](<images/Screenshot 2024-04-09 at 12.23.51.png>)

**3.** Click `Add to Dashboard` add dashboard name and click `create` if a new dashboard.

![alt text](<images/Screenshot 2024-04-09 at 16.59.38.png>)

**4.** Lastly, save the dashboard in right hand corner.

![alt text](<images/Screenshot 2024-04-09 at 12.28.18.png>)




## Get a cpu alert

First get a vm running with app instance, here is documentation on that if needed
[app vm](https://github.com/Scarlett100/DevOps_tech257/blob/master/tech257_aws/APP_AMI.md)


Next I went to cloudwatch and created an alarm, 
in browse :

 ![alt text](<Screenshot 2024-04-16 at 10.31.09.png>)

below are my settings:

![alt text](<Screenshot 2024-04-16 at 10.09.48.png>)

![alt text](<Screenshot 2024-04-16 at 09.42.18.png>)


next i enabled detailed monitoring:
![alt text](<Screenshot 2024-04-16 at 10.09.48.png>)


once i had created an `SNS topic` I had to conform my subscription:


![alt text](<Screenshot 2024-04-16 at 10.10.28.png>)



I then in `monitoring` within my instance enabled `detailed monitoring`:

![alt text](<Screenshot 2024-04-16 at 10.27.19.png>)

I ran the followiing commands to really run up the cpu

```
# Update and upgrade packages
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
```
To load test we installed Apache Bench.
 ```
sudo apt-get install apache2-utils
 ```


 ```
 http://54.76.46.243/fibonacci/37
 ````
![alt text](<Screenshot 2024-04-16 at 10.18.06.png>)

we can see it entered into alarm:
![alt text](<Screenshot 2024-04-16 at 10.29.05.png>)

 Once I did these things I got an email:
 ![alt text](<Screenshot 2024-04-16 at 10.16.41.png>)

 