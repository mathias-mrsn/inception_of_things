#!/bin/bash

# env : ARCH -> "arm64" or "x86_64"

FILENAME="k3s.installer.all"
LOGFILE="/vagrant/.log/$FILENAME.$(hostname).log"

# Header
printf "$FILENAME\n\n"

run() {
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : $2"
    eval $1 &>> $LOGFILE
    if [ $? -eq 0 ]; then
        echo "[$(date +'%m_%d__%H:%M:%S')] SUCCESS : $3"
    else
        >&2 echo "[$(date +'%m_%d__%H:%M:%S')] ERROR   : Failed to run the command \"$1\"."
        >&2 echo "Check $LOGFILE for details."
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

if [ "$ARCH" == "arm64" ]; then
    run \
        "curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s-arm64" \
        "Downloading k3s binary..." \
        "K3s binary has been installed successfully."
else
    run \
        "curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s" \
        "Downloading k3s binary..." \
        "K3s binary has been installed successfully."
fi


run \
    "chmod a+x /usr/local/bin/k3s" \
    "Changing permissions of /usr/local/bin/k3s binary..." \
    "Permissions for /usr/local/bin/k3s have been changed."

