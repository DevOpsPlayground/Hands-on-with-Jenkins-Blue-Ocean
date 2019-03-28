#!/bin/bash

### theia_installation.sh
# This shellscript starts the Theia container on a port passed as an argument

sudo chmod -R go+w /home/digital

sudo docker run -d -p "$1":3000 --restart always -v "/home/digital:/home/project" theiaide/theia:next 
