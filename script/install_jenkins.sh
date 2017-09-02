echo "[*****************JENKINS*****************]"
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "[*****************FNISH JENKINS*****************]"