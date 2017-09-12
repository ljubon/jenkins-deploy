#!/usr/bin/env bash

# Maven
echo "*****************MAVEN*****************"
echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
echo "[Download and uzip maven]"
cd /opt/
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
echo "[Unzip .tar.gz file]"
sudo tar xzf apache-maven-3.3.9-bin.tar.gz

echo "[Remove tar.gz file]"
sudo rm -rf apache-maven-3.3.9-bin.tar.gz

echo "[Link apache-maven-3.3.9 -> maven]"
sudo ln -s apache-maven-3.3.9 maven

echo "[Create /etc/profile.d/maven.sh]"
sudo touch /etc/profile.d/maven.sh	

echo "[Change permissions maven.sh]"
sudo chmod 666 /etc/profile.d/maven.sh

echo "[Edit configuration file /etc/profile.d/maven.sh]"
sudo echo "export M2_HOME=/opt/maven" >> /etc/profile.d/maven.sh
sudo echo "export M2=$M2_HOME/bin" >> /etc/profile.d/maven.sh
sudo echo "export PATH=/opt/maven/bin:$PATH" >> /etc/profile.d/maven.sh
	

echo "[Load maven.sh file]"
source /etc/profile.d/maven.sh
echo "[Maven Version: $(mvn -v)]"

echo "$(echo $JAVA_HOME)"
echo "$(echo $PATH)"
cd /$HOME/
echo "*****************FINISH MAVEN*****************"