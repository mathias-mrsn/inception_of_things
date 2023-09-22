#!/bin/bash

FILENAME="ssh.enable.all"
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
    "sed -i 's/^PasswordAuthentication no$/PasswordAuthentication yes/' /path/to/your/file" \
    "Changing sshd_config..." \
    "sshd_config has been updated."

run \
    "systemctl restart sshd" \
    "Restarting ssh..." \
    "Ssh has been restarted."
