#!/bin/bash

echo "[*****************JENKINS*****************]"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
sudo cd $HOME
ls -lart
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins


echo "Importing Jenkins files and jobs..."
cd $HOME/jenkins
echo "$(pwd)"
echo "Who am i? $(whoami)"
ls -lart


echo "Backup original jobs and files..."
sudo mv /etc/sysconfig/jenkins /etc/sysconfig/jenkins.backup
sudo mv /var/lib/jenkins/config.xml /var/lib/jenkins/config.xml.backup
# sudo cp /var/lib/jenkins /var/lib/jenkins.backup
# sudo cp /var/cache/jenkins /var/cache/jenkins.backup
# sudo cp /var/log/jenkins /var/log/jenkins.backup
echo "Backup DONE"


echo "Import jobs and files"
sudo mv -v jobs/ /var/lib/jenkins/
#sudo mv config.xml /var/lib/jenkins/
#sudo mv -v plugins/ /var/lib/jenkins/
sudo mv -v users/ /var/lib/jenkins/
sudo mv jenkins /etc/sysconfig/
echo "$(pwd)"
echo "$(ls -lart)"
echo "Importing DONE"


echo "Setting permissions"
sudo chmod 666 /etc/sysconfig/jenkins
sudo chmod 666 -R /var/lib/jenkins/
sudo chmod 666 -R /var/cache/jenkins/
sudo chmod 666 -R /var/log/jenkins/
echo "Permissions DONE"


echo "Who am i? $(whoami)"
echo "Where am i? $(pwd)"


echo "dos2unix /etc/sysconfig/jenkins"
sudo dos2unix /etc/sysconfig/jenkins
sudo dos2unix /var/lib/jenkins/config.xml
echo "dos2unix jenkins file....DONE"


echo "Start Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins
cd $HOME
echo "Jenkins is started..."
echo "$(sudo systemctl status jenkins)"
echo "[*****************FNISH JENKINS*****************]"