terraform {

    required_providers {

        aws = {

            source = "hashicorp/aws"
            version = " ~>3.0"
        }

    }
}


provider "aws" {

    region="us-east-2"
    access_key = "${var.ACCESS_KEY}"
    secret_key = "${var.SECRET_KEY}"
  
}



# Creation of custom vpcv
resource "aws_vpc" "Country_Lab-VPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = "Country_Lab-VPC"
  }
}

# Creation of Subnets
resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.Country_Lab-VPC.id
  cidr_block = var.subnet_1
  availability_zone = var.availability-2
  map_public_ip_on_launch = var.map_ip_1B
  tags = {
    Name = "public-sub-2"
  }
}

# Creation of the internet gateway to connect vpc to internet
resource "aws_internet_gateway" "Country-gwBL" {
  vpc_id = aws_vpc.Country_Lab-VPC.id

  tags = {
    Name = "Country-gwBL"
  }
}


#Routing Table for the Custom VPC
resource "aws_route_table" "Route_Table_Blue" {
  vpc_id = aws_vpc.Country_Lab-VPC.id
  route {
    cidr_block = var.RTB_cidr
    gateway_id = aws_internet_gateway.Country-gwBL.id
  }

  tags = {
    Name = "Route_Table_Blue"
  }
}

# Associate Route table subnets
resource "aws_route_table_association" "subnet-Blue" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.Route_Table_Blue.id
}

resource "aws_instance" "Country-Blue_ec2" {
  count         = var.ec2_count_1  
  ami           = var.ami_id_1B
  instance_type = var.instance_type_1B
  subnet_id = aws_subnet.public-sub-2.id
  availability_zone = var.zone_1B
  user_data = file("country.sh")
  security_groups = ["${aws_security_group.Country-Blue-SG.id}"]

  tags = {
    Name = "Country-Blue_ec2"
  }
}

#Security Group 
resource "aws_security_group" "Country-Blue-SG" {
  vpc_id      = aws_vpc.Country_Lab-VPC.id
  name        = "Country-Blue-SG"
  description = "security group that allows ssh connection"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "Country-Blue-SG"
  }
}