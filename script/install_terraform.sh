#!/usr/bin/env bash

# Install Terraform

echo "Download Terraform..."
cd /opt
sudo wget https://releases.hashicorp.com/terraform/0.10.4/terraform_0.10.4_linux_amd64.zip
sudo unzip terraform_0.10.4_linux_amd64.zip
sudo rm -rf terraform_0.10.4_linux_amd64.zip
echo "Unzip and remove .zip file"
echo "Create path to bin file..."
export PATH=$PATH:/opt/
cd /usr/bin/
sudo ln -s /opt/terraform terraform
sudo cd $HOME
echo "Terraform is installed"