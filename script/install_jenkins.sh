#@IgnoreInspection BashAddShebang
echo "[*****************JENKINS*****************]"
echo $JAVA_HOME
echo $PATH

sudo cd $HOME
#sudo chmod -R 666 jenkins/
ls -lart
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

echo "Backup original jobs and files..."
sudo mv /etc/sysconfig/jenkins /etc/sysconfig/jenkins.backup
sudo mv /var/lib/jenkins /var/lib/jenkins.backup
echo "Backup DONE"

echo "Importing Jenkins files and jobs..."
cd /$HOME/script/jenkins
echo "Location: $(pwd) User: $(whoami) List current directory: $(ls -lart)"

#sudo mv -v var_lib_jenkins/ /var/lib/jenkins/
sudo mv jenkins /etc/sysconfig/
sudo mv config.xml /var/lib/jenkins/
#sudo mv -v plugins/ /var/lib/jenkins/
sudo mv -v users/ /var/lib/jenkins/
sudo mv -v jobs/ /var/lib/jenkins/
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
sudo systemctl status jenkins
cd $HOME
echo "Jenkins is started..."
echo "$(sudo systemctl status jenkins)"
echo "[*****************FINISH JENKINS*****************]"