# jenkins-deploy
Deploy and setup Jenkins on RHEL AWS instance with terraform and ansible

* Run Pagent and load key *.ppk
* Install/Update Terraform and set path to the .exe file (verify with terraform status)
* Add file with access parameters for AWS
* git clone [repo link]
* terraform init
* terraform plan
* terraform apply

* Log in to Jenkins
* Go to Manage Jenkins -> Jenkins URL change from http://jenkins:8080/ -> http://[jenkin public ip]:8080/
* Save
* Go to Manage Jenkins -> GitHub section -> GitHub servers
* Name: GitHub server
* API URL: save default [https://api.github.com]
* Credentials: Create secret text and add your Personal access tokens from GitHub (https://github.com/settings/tokens)
* Check Manage hooks.
* TEST CONNECTION
* Go to Job which will receive PUSH from GitHub
* Check Source Code Management section and Git parameters (repo URL and credentials)
* In section Build triggers, check GitHub hook trigger for GITScm polling
* Check https://[repo url]/settings/hooks and verify that hook is created
* Make some change on your repo [repo url] and push it to the GitHub
* Verify that job is triggered with your push
