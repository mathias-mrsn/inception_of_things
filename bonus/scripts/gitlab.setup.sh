#!/bin/bash

FILENAME="gitlab.setup"
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
    "/usr/local/bin/k3s kubectl apply -f /vagrant/confs/namespace" \
    "Creating of gitlab namespace..." \
    "Namespace created."

run \
    "/usr/local/bin/k3s kubectl apply -f /vagrant/confs/gitlab" \
    "Deploying of gitlab..." \
    "Gitlab deployed"


while [ $(/usr/local/bin/k3s kubectl get pods -n gitlab 2>$LOGFILE | grep "Running" | wc -l) != 1 ]
do
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting gitlab to be deployed..."
    sleep 5;
done

while [ $(/bin/curl localhost:80 2>/dev/null | grep "Bad Gateway" | wc -l) == 1 ]
do
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting gitlab to be accessible..."
    sleep 5;
done
