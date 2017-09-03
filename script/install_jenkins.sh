#!/bin/bash

echo "[*****************JENKINS*****************]"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
echo "[*****************FNISH JENKINS*****************]"