#!/bin/bash

# Java
echo "*****************JAVA*****************"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
sudo yum -y install java-1.8.0-openjdk.x86_64
sudo yum -y install java-1.8.0-openjdk-devel.x86_64
sudo yum -y install java
# backup existing profile
sudo cp /etc/profile /etc/profile_backup
sudo echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
sudo echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
echo "$(java -version)"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
echo "*****************FINISH JAVA*****************"