variable "vpc_cidr" {
    default = "10.0.0.0/16"
  
}

variable "ACCESS_KEY" {}

variable "SECRET_KEY" {}




variable "tenancy" {
    type = string
    default = "default"
  
}

variable "subnet_1" {
    default = "10.0.1.0/24"
  
}

variable "availability-1" {
    default = "us-east-1a"

}

variable "map_ip_1B" {
    type= bool
    default= "true"
  
}



variable "RTB_cidr" {
    default = "0.0.0.0/0"
  
}




variable "ec2_count_1" {
    default = 1
  
}

variable "ami_id_1B" {
    default = "ami-087c17d1fe0178315"
  
}

variable "instance_type_1B" {
    default = "t2.micro"
  
}


variable "zone_1B" {
    default = "us-east-2a"
  
}

