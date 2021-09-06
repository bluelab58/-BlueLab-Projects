#! /bin/bash
# install httpd (Linux 2 version)
yum update -y 
yum install httpd
systemctl start httpd.service
sytemctl enable httpd.service
echo "You are welcome to this site" > /var/www/html/index.html
