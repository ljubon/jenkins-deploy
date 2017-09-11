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

sudo chmod 600 /root/.ssh/jenkins
sudo chmod 600 /home/ec2-user/.ssh/jenkins

sudo ls -lart /root/.ssh/
sudo ls -lart /home/ec2-user/.ssh/jenkins
sudo cd $HOME
echo "Who am I? You are: $(whoami)"
echo "Where am I? You are in: $(pwd)"
echo "*****************SSH_KEYS DONE*****************"

echo "*****************EPEL RELEASE*****************"
sudo yum -y install wget telnet git nmap zip unzip dos2unix
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

#echo "Importing public IP addreses hosts file..."
#sudo echo "$(terraform output public_nat) nat-server nat" >> /etc/hosts
#sudo echo "$(terraform output public_web) nat-server nat" >> /etc/hosts
#echo "Importing DONE"
