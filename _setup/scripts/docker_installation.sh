#!/bin/bash

### docker_installation.sh
# This shellscript installs Docker on an Amazon Linux machine

echo Starting Docker instllation procedure

# Remove other versions of Docker and associated dependencies
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine

sudo yum install http://vault.centos.org/centos/7.3.1611/extras/x86_64/Packages/container-selinux-2.9-4.el7.noarch.rpm -y

# Get the Docker repositories and install the latest one
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y
sudo yum install docker-ce docker-ce-cli containerd.io -y

sudo systemctl start docker
docker -v

echo Docker installation procedure completed
