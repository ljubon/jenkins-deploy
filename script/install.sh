#@IgnoreInspection BashAddShebang
echo "*****************GENERATE SSH_KEY*****************"
echo "Generate ssh-key for ec2-user account..."
sudo cd /home/ec2-user/
sudo ssh-keygen -t rsa -N "" -f /home/ec2-user/.ssh/jenkins
sudo chmod 600 /home/ec2-user/.ssh/jenkins
sudo chown -R ec2-user:ec2-user /home/ec2-user/.ssh
sudo ls -lart /home/ec2-user/.ssh
echo "Key jenkins is generated"

echo "Copy ssh-keys to root account and set permission"
sudo cp /home/ec2-user/.ssh/jenkins* /root/.ssh/
sudo ls -lart /root/.ssh
echo "Copy ssh-keys to root account and set permission"

echo "Current location: $(pwd)"
cd /home/ec2-user/
echo "Change to : $(pwd)"
echo "*****************SSH_KEYS DONE*****************"

echo "*****************EPEL RELEASE*****************"
sudo yum -y install wget telnet git nmap zip unzip dos2unix
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-10.noarch.rpm
sudo rpm -ivh epel-release-7-10.noarch.rpm
sudo yum -y install epel-release
sudo yum -y update
sudo rm -rf epel-release-7-10.noarch.rpm
cd /home/ec2-user/
echo "*****************DONE EPEL*****************"

echo "*****************GIT*****************"
git config --global user.email "ljubonikolic@gmail.com"
git config --global user.name "Ljub Nikolic"
echo "*****************DONE GIT*****************"

echo "*****************CONFIGURE RHEL*****************"
echo "Change hostname"
sudo hostnamectl set-hostname jenkins-server
echo "New hostname is: $(echo hostnamectl status)"
echo "*****************DONE RHEL*****************"