# Java
echo "*****************JAVA*****************"
sudo yum -y install java
sudo cp /etc/profile /etc/profile_backup
sudo echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | sudo tee -a /etc/profile
sudo echo 'export JRE_HOME=/usr/lib/jvm/jre' | sudo tee -a /etc/profile
source /etc/profile
echo "*****************FINISH JAVA*****************"