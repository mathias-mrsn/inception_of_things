#!/bin/bash

FILENAME="firewall.disable.all"
LOGFILE="/var/log/$FILENAME.log"

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
    "systemctl disable firewalld --now" \
    "Disabling firewall..." \
    "firewall has been disabled."

