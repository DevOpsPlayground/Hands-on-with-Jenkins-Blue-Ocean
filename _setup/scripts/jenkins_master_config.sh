#!/bin/bash

### jenkins_master_config.sh
# This shellscript sets up the configuration of the Jenkins master, such as security configuration and accounts.
# Also installs the plugins, along with necessary dependencies
# Tested on amazon linux machine

echo Starting Jenkins master configuration procedure

sleep 30s #DO NOT DELETE. Setting some time for Jenkins to get up and running facilitates the installation of plugins

# Override the default jenkins config file
sudo mv /tmp/jenkins_config.xml /var/lib/jenkins/config.xml

# Make the directory to place the admin account config file in
sudo mkdir /var/lib/jenkins/users
sudo mkdir /var/lib/jenkins/users/admin
sudo mv /tmp/admin_accnt_config.xml /var/lib/jenkins/users/admin/config.xml

# Set the owner of the entire jenkins directory to jenkins. Jenkins will not work if permissions are different
sudo chown -R jenkins:jenkins /var/lib/jenkins

wget localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin blueocean
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin artifactory
sudo service jenkins restart

echo Jenkins master configuration procedure completed
