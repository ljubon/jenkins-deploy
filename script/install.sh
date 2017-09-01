echo "*****************EPEL RELEASE"
sudo yum -y install wget telnet git nmap 
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
#!/bin/bash
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum -y install epel-release
sudo yum -y update
echo "*****************FINISH EPEL RELEASE"

# Java
echo "*****************JAVA"
sudo yum -y install java
sudo cp /etc/profile /etc/profile_backup
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
echo "*****************FINISH TOOLS"

# Ansible
echo "*****************ANSIBLE"
sudo yum -y install gcc 
sudo yum -y install python-setuptools
sudo yum -y install python-devel
sudo easy_install pip
sudo yum -y install ansible
echo "*****************FINISH ANSIBLE"

# Maven
echo "*****************MAVEN"
mkdir /usr/local/apache-maven
cd /usr/local/apache-maven
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
sudo tar xzf apache-maven-3.3.9-bin.tar.gz
sudo rm -rf apache-maven-3.3.9-bin.tar.gz

sudo touch /etc/profile.d/maven.sh
sudo chmod 666 /etc/profile.d/maven.sh

sudo echo "export M2_HOME=/usr/local/apache-maven/apache-maven-3.3.9" >> /etc/profile.d/maven.sh
sudo echo "export M2=$M2_HOME/bin" >> /etc/profile.d/maven.sh
sudo echo "export PATH=$M2:$PATH" >> /etc/profile.d/maven.sh
export M2_HOME=/usr/local/apache-maven/apache-maven-3.3.9
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

source /etc/profile.d/maven.sh

echo "Verification Maven"
mvn -version 
echo "Maven Version: $(mvn -version)"
cd ~
echo "*****************FINISH MAVEN"

echo "*****************JENKINS"
# install jenkins
sudo yum –y update
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "*****************FINISH JENKINS"
# sudo usermod -a -G root jenkins
# sudo vi /etc/sysconfig/jenkins
# change JENKINS_LISTEN_ADDRESS="0.0.0.0"
# ssh-keyscan -H [hostname],[ip_address] >> ~/.ssh/known_hosts
# ssh -o StrictHostKeyChecking=no username@hostname.com
# sudo cat /etc/sudoers
# add jenkins user
# useradd myNewUser
# sudo myNewUser