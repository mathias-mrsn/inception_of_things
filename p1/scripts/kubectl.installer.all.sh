#!/bin/bash

FILENAME="kubectl.installer.all"
LOGFILE="/var/log/$FILENAME.log"
ARCH="amd64"

printf "$FILENAME\n\n"

run() {
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : $2"
    eval $1 &> $LOGFILE
    if [ $? -eq 0 ]; then
        echo "[$(date +'%m_%d__%H:%M:%S')] SUCCESS : $3"
    else
        >&2 echo "[$(date +'%m_%d__%H:%M:%S')] ERROR   : Failed to run the command \"$1\". Check $LOGFILE for details."
    fi
}

run \
    "curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH/kubectl" \
    "Downloading kubectl binary..." \
    "Kubectl has been successfully installed."

run \
    "chmod a+x /usr/local/bin/kubectl" \
    "Changing permissions of /usr/local/bin/kubectl binary..." \
    "Permissions for /usr/local/bin/kubectl have been changed."

run \
    "mkdir -p /home/vagrant/.kube && ln -s /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config" \
    "Creating a symbolic link between the kubectl configuration file and the k3s configuration file..." \
    "Symbolic link has been created."

run \
    "echo 'alias k=\"kubectl\"' > /etc/profile.d/00-aliases.sh" \
    "Creating an alias (k -> kubectl)..." \
    "Alias has been created."
