#!/bin/bash

### docker_username_configuration.sh
# This shellscript adds every argument passed to it to the Docker user group.

for username in "$@"
do
    sudo usermod -aG docker "$username"

done

