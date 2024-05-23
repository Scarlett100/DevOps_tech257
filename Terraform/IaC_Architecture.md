# IaC with Config management and Orchestration end to end Architecture


## Terraform
Terraform first provisions the initial insrastructure then a configuration management tool lke ansible installs and updates software,

For example, in main.tf we will write configuration and then deploy to cloud provider of choice. Then we go to that cloud endpoint and the infrastructure it has been given to build in main.tf, terraform should have created and built the infrastructure eg. security groups, vm's, subnets, alerts, maybe a git repo etc. 

![alt text](<images/Screenshot 2024-03-28 at 12.21.33.png>)

## Ansible
In ansible we maually created ec2 instances, with terraform, we no longer need to do this. But we may need to do patch management updates.

Once the infrastructure is built it is time to install and config things, we can do this in ansible via playbooks to configure things like reverse proxy, deploy app etc.

![alt text](<images/Screenshot 2024-03-28 at 12.27.04.png>)


## Security
The key concepts between the two are security. Eg. SSH .pem, aws keys.
How we manage the keys to gain access is important.

The team responsible for config may not be able to access everything, likewise the same goes for infrastructure team, depending on the company. But as DevOps engineers we should be able to do both config and infrstructure if needed.

![alt text](<images/Screenshot 2024-03-28 at 12.30.44.png>)