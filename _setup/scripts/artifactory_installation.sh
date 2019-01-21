#!/bin/bash

### artifactory_installation.sh
# This shellscript installs artfiactory on a linux machine, specifically on a x86_64 Linux system

echo Starting Artifactory installation procedure

# Remove default Java and install version known to work with SonarQube
sudo yum remove java -y
sudo yum install java-1.8.0-openjdk-devel -y

sleep 30s # give time for yum to complete installation and release it to

# Install artifactory as a service
sudo wget https://bintray.com/jfrog/artifactory-rpms/rpm -O bintray-jfrog-artifactory-rpms.repo
sudo mv bintray-jfrog-artifactory-rpms.repo /etc/yum.repos.d/
sudo yum install jfrog-artifactory-oss -y
sudo service artifactory start
sudo chkconfig artifactory on

echo Artifactory installation procedure completed
