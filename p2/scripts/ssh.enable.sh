#!/bin/bash

FILENAME="ssh.enable.all"
LOGFILE="/vagrant/.log/$FILENAME.$(hostname).log"

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
    "sed -i 's/^#PasswordAuthentication yes$/PasswordAuthentication yes/' /etc/ssh/sshd_config" \
    "Changing sshd_config..." \
    "sshd_config has been updated."

run \
    "sed -i 's/^#PermitEmptyPasswords no$/PermitEmptyPasswords yes/' /etc/ssh/sshd_config" \
    "Changing sshd_config..." \
    "sshd_config has been updated."

run \
    "passwd --delete vagrant" \
    "Removing vagrant user password..." \
    "vagrant password removed."

run \
    "systemctl restart sshd" \
    "Restarting SSH..." \
    "SSH has been restarted."

