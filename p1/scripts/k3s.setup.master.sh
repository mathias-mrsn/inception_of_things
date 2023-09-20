#!/bin/bash

FILENAME="k3s.setup.master"
LOGFILE="/var/log/$FILENAME.log"
ETH_IP=$1
NAME=$2

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
    "sysctl -w net.ipv4.ip_forward=1" \
    "Setting net.ipv4.ip_forward to 1..." \
    "IP forwarding has been set to 1."

run \
    "nohup /usr/local/bin/k3s server --write-kubeconfig-mode=644 --node-ip ${ETH_IP} --node-name ${NAME} &" \
    "Running k3s server in the background..." \
    "K3s server has been started in the background."

until /usr/local/bin/k3s kubectl describe node &>/dev/null
do
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting for k3s to start up..."
    sleep 2;
done

run \
    "cp /var/lib/rancher/k3s/server/agent-token /vagrant/.agent-token" \
    "Copying the agent-token to the shared directory" \
    "The agent-token has been copied."

