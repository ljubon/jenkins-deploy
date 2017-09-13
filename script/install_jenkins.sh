# Jenkins user: ec2-user
# Jenkins home: /var/lib/jenkins/
# 4 pre-configured jobs
# plugins

echo "[*****************JENKINS*****************]"
sudo cd /home/ec2-user/jenkins_backup
echo "$(ls -lart)"
echo "$(pwd)"

sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

# BACKUP
echo "Backup original jobs and files..."
sudo mv /etc/sysconfig/jenkins /etc/sysconfig/jenkins.backup
sudo mv /var/lib/jenkins /var/lib/jenkins.backup
echo "$(ls -lart)"
echo "$(pwd)"
echo "Backup DONE"

# IMPORT FILES
echo "Import files..."
echo "$(ls -lart)"
echo "$(pwd)"
sudo mv -v /home/ec2-user/jenkins_backup/home_dir/jenkins/ /var/lib/
sudo mv -v /home/ec2-user/jenkins_backup/jenkins  /etc/sysconfig/
echo "$(ls -lart /var/lib/jenkins)"
echo "$(ls -lart /etc/sysconfig/jenkins)"
echo "Import DONE"

# SET PERMISSIONS
echo "Set permissions..."
sudo chown ec2-user:ec2-user /etc/hosts # FIX: for job, to allow terraform output public_ip set to /etc/hosts
sudo chown ec2-user:ec2-user /home/ec2-user/.ssh/jenkins*

sudo chown -R ec2-user:ec2-user /var/lib/jenkins
sudo chown -R ec2-user:ec2-user /var/log/jenkins
sudo chown -R ec2-user:ec2-user /var/cache/jenkins
sudo chown ec2-user:ec2-user /etc/sysconfig/jenkins
echo "Permissions DONE"

# edit /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml:
# <jenkinsUrl>http://35.157.92.54:8080/</jenkinsUrl>
sudo sed -i "s/[old IP]/[new IP]/g" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml

sudo dos2unix /etc/sysconfig/jenkins
sudo dos2unix /var/lib/jenkins/config.xml

#echo "Importing Jenkins files and jobs..."
#cd /$HOME/script/jenkins
#echo "Location: $(pwd) User: $(whoami) List current directory: $(ls -lart)"

# START JENKINS
echo "Start Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
cd $HOME
echo "Jenkins is started..."
echo "$(sudo systemctl status jenkins)"
echo "[*****************FINISH JENKINS*****************]"