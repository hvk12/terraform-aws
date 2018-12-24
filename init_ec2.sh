#!/bin/bash

sudo yum update -y
#sudo amazon-linux-extras install docker
sudo yum install docker git -y
sudo service start docker
sudo usermod -a -G docker ec2-user

echo "Done with docker" >> /tmp/step1.txt
sudo git config --global credential.helper '!aws codecommit credential-helper $@'
sudo git config --global credential.UseHttpPath true

#git clone --mirror https://git-codecommit.us-east-1.amazonaws.com/v1/repos/Source LocalRepository
#cd LocalRepository
#git remote set-url --push origin https://git-codecommit.us-east2.amazonaws.com/v1/repos/Destination
echo "Done with git" >> /tmp/step2.txt