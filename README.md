# jenkins-deploy
Deploy and setup Jenkins on RHEL AWS instance with terraform and ansible

* Make sure that script/jenkins file is set to Unix EOL *

1.  Run Pagent and load key
1a. Install/Update Terraform and set path to the file
2.  Add file with access parameters
3.  git clone [repo link]
4.  terraform init
5.  terraform plan / apply

Log in to Jenkins
Add git server
Generate Git API token
Add git token to remote repo

