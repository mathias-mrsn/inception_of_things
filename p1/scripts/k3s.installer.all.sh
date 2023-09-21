#!/bin/bash

FILENAME="k3s.installer.all"
LOGFILE="/var/log/$FILENAME.log"

# Header
printf "$FILENAME\n\n"

run() {
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : $2"
    eval $1 
    if [ $? -eq 0 ]; then
        echo "[$(date +'%m_%d__%H:%M:%S')] SUCCESS : $3"
    else
        >&2 echo "[$(date +'%m_%d__%H:%M:%S')] ERROR   : Failed to run the command \"$1\". Check $LOGFILE for details."
    fi
}

run \
    "timedatectl set-timezone Europe/Paris" \
    "Setting VM timezone to Europe/Paris..." \
    "Timezone has been set to Europe/Paris successfully."

run \
    "yum install -y curl net-tools" \
    "Downloading/updating packages..." \
    "Packages have been downloaded/updated successfully."

run \
    "curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s" \
    "Downloading k3s binary..." \
    "K3s binary has been installed successfully."

run \
    "chmod a+x /usr/local/bin/k3s" \
    "Changing permissions of /usr/local/bin/k3s binary..." \
    "Permissions for /usr/local/bin/k3s have been changed."

