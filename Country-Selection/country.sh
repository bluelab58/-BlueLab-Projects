#!/usr/bin/env python
# install httpd (Linux 2 version)
yum update -y 
yum install httpd
systemctl start httpd.service
sytemctl enable httpd.service
import random
Cities = ["WASHINGTON DC", "NEW YORK", "LONDON", "LAGOS", "PARIS", "BERLIN", "ACCRA", "PRETORIA", "ABUJA", "TOKYO"]
random_countries = random.choice(Countries)
print ("Selected city is : " + str(random_countries)) > /var/www/html/index.html