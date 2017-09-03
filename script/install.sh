#!/bin/bash
echo "*****************EPEL RELEASE*****************"
sudo yum -y install wget telnet git nmap 
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum -y install epel-release
sudo yum -y update
sudo rm -rf epel-release-7-10.noarch.rpm
sudo cd $HOME
echo "*****************FINISH EPEL RELEASE*****************"



echo "*****************CONFIGURE RHEL*****************"
echo "Change hostname"
sudo hostnamectl set-hostname jenkins-server
echo "New hostname is: $(echo hostnamectl status)"




# sudo hostname nat - this is for nat instance
# sudo hostnamectl set-hostname web-server - this is for web server
# sudo hostnamectl set-hostname db-server - this is for db server

# from jenkins
# !! ssh-keyscan [web-ip] >> ~/.ssh/known_hosts
# !! ssh-keyscan [nat-ip] >> ~/.ssh/known_hosts
# from web
# !! ssh-keyscan [jenkins-ip] >> ~/.ssh/known_hosts
# !! ssh-keyscan [nat-ip] >> ~/.ssh/known_hosts
# from nat
# !! ssh-keyscan [jenkins-ip] >> ~/.ssh/known_hosts
# !! ssh-keyscan [web-ip] >> ~/.ssh/known_hosts


# sudo usermod -a -G root jenkins
# sudo vi /etc/sysconfig/jenkins
# change JENKINS_LISTEN_ADDRESS="0.0.0.0"
# ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
# ssh -o StrictHostKeyChecking=no username@hostname.com
# sudo cat /etc/sudoers
# add jenkins user
# useradd myNewUser
# sudo myNewUser