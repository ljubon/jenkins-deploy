#@IgnoreInspection BashAddShebang
# Jenkins user: ec2-user
# Jenkins home: /var/lib/jenkins/
# 5 pre-configured jobs for https://github.com/ljubon/webapp-aws-terraform
# plugins

echo "[*****************JENKINS*****************]"
sudo cd /home/ec2-user/jenkins_backup
echo "$(ls -lart)"
echo "$(pwd)"

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
echo "[*****************JENKINS DONE*****************]"

# BACKUP
echo "BACKUP original directories..."
sudo mv /etc/sysconfig/jenkins /etc/sysconfig/jenkins_backup
sudo mv /var/lib/jenkins /var/lib/jenkins_backup
sudo mv /var/log/jenkins /var/log/jenkins_backup
sudo mv /var/cache/jenkins /var/cache/jenkins_backup
echo "BACKUP DONE"

# IMPORT FILES
#echo "Import files..."
#echo "$(ls -lart)"
#echo "$(pwd)"
#sudo mv -v /home/ec2-user/jenkins_backup/home_dir/jenkins/ /var/lib/
#sudo mv -v /home/ec2-user/jenkins_backup/jenkins  /etc/sysconfig/
#echo "$(ls -lart /var/lib/jenkins)"
#echo "$(ls -lart /etc/sysconfig/jenkins)"
#echo "Import DONE"

# SET PERMISSIONS
echo "Set permissions..."
#sudo zip -r jenkins_lib.zip /var/lib/jenkins/
#sudo zip -r jenkins_cache.zip /var/cache/jenkins/
#sudo zip -r jenkins_log.zip /var/log/jenkins/
#sudo zip jenkins_config.zip /etc/sysconfig/jenkins
echo "Change user and permissions"
echo "$(ls -lart)"
echo "$(pwd)"
cd /home/ec2-user/jenkins_backup/
sudo chown ec2-user:ec2-user jenkins*
sudo chmod 666 jenkins*

echo "Unzip Jenkins files to locations..."
sudo unzip jenkins_log.zip -d /var/log/jenkins
sudo unzip jenkins_cache.zip -d /var/cache/jenkins
sudo unzip jenkins_lib.zip -d /var/lib/jenkins
sudo mv jenkins /etc/sysconfig/

echo "Change user and permissions -----> DONE"
sudo chown -R ec2-user:ec2-user /var/lib/jenkins
sudo chown -R ec2-user:ec2-user /var/log/jenkins
sudo chown -R ec2-user:ec2-user /var/cache/jenkins
sudo chown ec2-user:ec2-user /etc/sysconfig/jenkins
echo "Permissions DONE"

echo "Dos2unix /var/lib/jenkins/config.xml and /etc/sysconfig/jenkins"
sudo dos2unix /etc/sysconfig/jenkins
sudo dos2unix /var/lib/jenkins/config.xml
echo "Dos2unix -> DONE"

# START JENKINS
echo "Start Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
echo "Jenkins is started..."
echo "$(sudo systemctl status jenkins)"
echo "[*****************FINISH JENKINS*****************]"