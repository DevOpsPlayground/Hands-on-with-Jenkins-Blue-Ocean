#!/bin/bash

### sonarqube_linux_installation.sh
# This shellscript installs sonarqube on a linux machine, specifically on a x86_64 Linux system

echo Starting SonarQube installation procedure

# Assign variables
port_number=$1

# Remove default Java and install version known to work with SonarQube
sudo yum remove java -y
sudo yum install java-1.8.0-openjdk-devel -y

# Get the installation zip file and unzip it
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.7.6.zip
sudo mkdir /etc/sonarqube
sudo unzip -qq sonarqube-6.7.6.zip -d /etc/sonarqube/

# setup sonarqube to run as a service
sudo mv /tmp/sonar /etc/init.d
sudo ln -s /etc/sonarqube/sonarqube-6.7.6/bin/linux-x86-64/sonar.sh /usr/bin/sonar
sudo chmod 755 /etc/init.d/sonar
sudo chown root:root /etc/init.d/sonar
sudo chkconfig --add sonar
sudo sed -i 's/wrapper.java.command=java/wrapper.java.command=\/usr\/lib\/jvm\/jre\/bin\/java/' /etc/sonarqube/sonarqube-6.7.6/conf/wrapper.conf

# Change sonar port to a variable port number
sudo sed -i "s/#sonar.web.port=9000/sonar.web.port=$port_number/" /etc/sonarqube/sonarqube-6.7.6/conf/sonar.properties

# Create sonar user and change file permissions
sudo useradd sonar
sudo sed -i 's/#RUN_AS_USER=/RUN_AS_USER=sonar/' /etc/sonarqube/sonarqube-6.7.6/bin/linux-x86-64/sonar.sh
sudo chown -R sonar:sonar /etc/sonarqube

sudo service sonar start

# Show logs for verifying setup is successful
sleep 10s
sudo cat /etc/sonarqube/sonarqube-6.7.6/logs/sonar.log
# sudo cat /etc/sonarqube/sonarqube-6.7.6/logs/es.log

echo SonarQube installation procedure completed
