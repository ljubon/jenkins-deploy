#!/bin/bash

echo "[*****************JENKINS*****************]"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
sudo cd $HOME
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

sudo mv /etc/sysconfig/jenkins /etc/sysconfig/jenkins.backup
sudo cp $HOME/jenkins/jenkins /etc/sysconfig/
sudo chmod 666 /etc/sysconfig/jenkins
sudo chmod 666 -R /var/lib/jenkins/
sudo chmod 666 -R /var/cache/jenkins/
sudo chmod 666 -R /var/log/jenkins/
echo "Who am i? $(whoami)"
echo "Where am i? $(pwd)"
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
echo "[*****************FNISH JENKINS*****************]"