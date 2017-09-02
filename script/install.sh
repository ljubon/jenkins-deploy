echo "*****************EPEL RELEASE*****************"
sudo yum -y install wget telnet git nmap 
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
#!/bin/bash
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum -y install epel-release
sudo yum -y update
echo "*****************FINISH EPEL RELEASE*****************"

# sudo usermod -a -G root jenkins
# sudo vi /etc/sysconfig/jenkins
# change JENKINS_LISTEN_ADDRESS="0.0.0.0"
# ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
# ssh -o StrictHostKeyChecking=no username@hostname.com
# sudo cat /etc/sudoers
# add jenkins user
# useradd myNewUser
# sudo myNewUser