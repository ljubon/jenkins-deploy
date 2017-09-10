#!/bin/bash

echo "*****************GENERATE SSH_KEY*****************"
echo "Who am i? You are: $(whoami)"
echo "Where am i? You are in: $(pwd)"
echo "Generate ssh-key for root account..."
sudo ssh-keygen -t rsa -N "" -f /root/.ssh/jenkins
sudo ls -lart /root/.ssh/
echo "Copy ssh-keys for ec2-user account....."
sudo cp /root/.ssh/jenkins  /home/ec2-user/.ssh/
sudo cp /root/.ssh/jenkins.pub /home/ec2-user/.ssh/
sudo ls -lart /$HOME/.ssh/
sudo cd $HOME
echo "Who am I? You are: $(whoami)"
echo "Where am I? You are in: $(pwd)"
echo "*****************SSH_KEYS DONE*****************"

echo "*****************EPEL RELEASE*****************"
sudo yum -y install wget telnet git nmap zip unzip
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum -y install epel-release
sudo yum -y update
sudo rm -rf epel-release-7-10.noarch.rpm
sudo cd $HOME
echo "*****************DONE EPEL*****************"

echo "*****************GIT*****************"
git config --global user.email "ljubonikolic@gmail.com"
git config --global user.name "Ljub Nikolic"
echo "*****************DONE GIT*****************"

echo "*****************CONFIGURE RHEL*****************"
echo "Change hostname"
sudo hostnamectl set-hostname jenkins-server
echo "New hostname is: $(echo hostnamectl status)"
echo "*****************DONE RHEL*****************"

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

# terraform install
# cd /tmp
# wget https://releases.hashicorp.com/terraform/0.10.4/terraform_0.10.4_linux_amd64.zip
# sudo unzip terraform_0.10.4_linux_amd64.zip
# sudo rm -rf terraform_0.10.4_linux_amd64.zip
# export PATH=$PATH:/tmp/
# sudo cd /usr/bin
# sudo ln -s /tmp/terraform terraform

#	Git token
#	16a76354036f50abe8a8288c2c421f503198c536 

# sudo usermod -a -G root jenkins
# sudo vi /etc/sysconfig/jenkins
# change JENKINS_LISTEN_ADDRESS="0.0.0.0"
# ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
# ssh -o StrictHostKeyChecking=no username@hostname.com
# sudo cat /etc/sudoers
# add jenkins user
# useradd myNewUser
# sudo myNewUser