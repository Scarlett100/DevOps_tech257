# Azure Monitor monitoring, alert management 


# What is worst to best in terms of What is worst to best in terms of monitoring and responding to load/traffic.

* A dashboard is also a way in which we can have in terms of monitoring and responding to load/traffic, however  its possible we may have missed it.
* An alarm and notification would be the next best way
* The best way to monitor and respond to load/traffic is through autoscaling.

# How you setup a dashboard

To set up a dashboard in Azure, you will need to follow the below steps.

1. On your vm page go to overview > monitoring.
 ![alt text](<Screenshot 2024-03-14 at 14.24.23.png>)

2. Then scroll down and you will see some charts, on the chart you want click the pin icon.
3. Once there you can choose *Create New* and choose a private or shared dashboard, in this case, I will choose shared, also pick a name.
4. After this in the search bar, type and click on *dashboard hub*. Here you will see your dashboard, click on it.
5. Now the desired charts that you have added will be available. you can drag and drop to place as you wish, don't forget to save!
6. once on a specific chart you can change the time frame by clicking on the current timeframe in rioght hand corner and changing, confirming by clicking apply. This will then be further confirmed once you click *Save to dashboard*.
   
Here is my dashboard:
![alt text](<Screenshot 2024-03-14 at 14.30.50.png>)


To load test we installed Apache Bench.
 ```
sudo apt-get install apache2-utils
 ```

# Apache Bench load Requests
My dashboard stopped giving a response at this point, my requests were timing out: <br>
Now to increase to 10,000 requests and increase speed to 200:
 ```
ab -n 10000 -c 200 http://172.166.126.201/
 ```
![alt text](<Screenshot 2024-03-14 at 14.03.57.png>)

as you can see via my dash board below:
![alt text](<Screenshot 2024-03-14 at 14.34.00.png>)


# Create a CPU usage alert for your app instance 


step one: alert rule
<br>
![alt text](<Screenshot 2024-03-14 at 14.39.08.png>)


![alt text](<Screenshot 2024-03-14 at 14.40.38.png>)

step two: quick actions
![alt text](<Screenshot 2024-03-14 at 14.44.42.png>)

Our alert has been made as seen below:
<br>

![alt text](<../blob_storage/Screenshot 2024-03-14 at 14.46.06.png>)
<br>
Lastly, as you can see below I have recieved my alert email:
![alt text](<Screenshot 2024-03-14 at 14.53.38.png>)

# note
I did create another one to show useage over 1%
as seen below:

![alt text](<Screenshot 2024-03-14 at 15.01.02.png>)

here is my alert when it hit 1% :

![alt text](<Screenshot 2024-03-14 at 15.10.47.png>)