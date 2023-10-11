#!/bin/bash

FILENAME="k3s.setup.worker"
LOGFILE="/vagrant/.log/$FILENAME.$(hostname).log"
ETH_IP=$1
SERVER_IP=$2
NAME=$3
AGENT_TOKEN=$(cat /vagrant/.agent-token)

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
    "nohup /usr/local/bin/k3s agent --server https://${SERVER_IP}:6443 --token ${AGENT_TOKEN} --node-ip ${ETH_IP} --node-name ${NAME} &" \
    "Running k3s agent in the background..." \
    "K3s agent has been started in the background."
