# where to create -provide cloud name
provider "aws"  {
    # which region
    region = "eu-west-1"
    # terraform will now download all the required dependencies/plugins
    # terraform init
}

resource "aws_security_group" "tech257-morgan_terraform_sg" {
   #name = "tech257-morgan_terraform_sg"
   name = var.name
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
}

# which service
resource "aws_instance" "app_instance" {
    # which ami: ami-02f0341ac93c96375
    # ami = "ami-02f0341ac93c96375"

    ami = var.app_ami_id
    # what type of instance
    
    #instance_type = "t2.micro"
    instance_type = var.instance_type


    # add public ip
    #associate_public_ip_address = true
    associate_public_ip_address = var.associate_public_ip_address


    # aws access key
    # aws secret key
    # Tech 257
    # key_name = "tech257"
    key_name = var.key_name
    # name the service
    tags = {
         #Name = "Morgan-terraform-tech257-app"
         Name = var.Name
       
    }
   vpc_security_group_ids      = [aws_security_group.tech257-morgan_terraform_sg.id]
   
}

terraform {
 required_providers {
 github = {
 source = "integrations/github"
 version = "~> 5.0"
 }
 }
}
# Configure the GitHub Provider
provider "github" {
 token = var.token # github token 
}
resource "github_repository" "example" {
 name = "multi-provider-terraform" # demo_repo will create. Change the repo name as per your repo.
 description = "testing" # this is the description field.
 visibility = "public" # Repository type . There are two type available private and public.
}

  
   