#!/bin/bash

### jenkins.sh
# This shellscript is responsible for installing Jenkins.
# Tested on an amazon linux machine

echo Starting Jenkins installation procedure

# Remove default Java and install version known to work with Jenkins
sudo yum remove java -y
sudo yum install java-1.8.0-openjdk-devel -y

# Initial installation of Jenkins. Disable prompt for Admin password and suggested plugins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y
sudo sed -i 's/JENKINS_JAVA_OPTIONS.*/JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false -Xmx1024m -XX:MaxPermSize=512m"/' /etc/sysconfig/jenkins

# Installation of plugins and dependencies using Jenkins CLI
sudo service jenkins start

sudo chkconfig jenkins on

echo Jenkins installation procedure completed
