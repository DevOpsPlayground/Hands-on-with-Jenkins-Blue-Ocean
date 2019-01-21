#!/bin/bash

### jenkins_agent_config.sh
# This shellscript installs and sets the environmental variables needed for the Jenkins agent to run
# Tested on amazon linux machine

echo Starting Jenkins agent configuration procedure

# Installing git
sudo yum install git -y

# Installing maven
cd /var/lib
sudo wget https://www-eu.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
sudo tar -xf apache-maven-3.6.0-bin.tar.gz

# Set maven environmental values
export M2_HOME=/var/lib/apache-maven-3.6.0
echo export M2_HOME=/var/lib/apache-maven-3.6.0 >> ~/.bash_profile
export M2=$M2_HOME/bin
echo export M2=$M2_HOME/bin >> ~/.bash_profile
export PATH=$M2:$PATH
echo export PATH=$M2:$PATH >> ~/.bash_profile
mvn -v

echo Jenkins agent configuration procedure completed
