#!/usr/bin/env bash

# Ansible
echo "*****************ANSIBLE*****************"
sudo yum -y install gcc 
sudo yum -y install python-setuptools
sudo yum -y install python-devel
sudo easy_install pip
sudo yum -y install ansible
echo "$(ansible --version)"
echo "*****************FINISH ANSIBLE*****************"