#!/bin/bash

FILENAME="k3s.apply.master"
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

whoami

run \
    "/usr/local/bin/k3s kubectl apply -f /vagrant/confs/configmap.all.yaml" \
    "Creating ConfigMap for every app..." \
    "ConfigMaps created."

while [ $(/usr/local/bin/k3s kubectl get configmap | grep "configmap-app" | wc -l ) != 3 ]
do
   echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting ConfigMap to be accessible"
   sleep 2;
done

for f in /vagrant/confs/deployment.app* ; do

    pod_name=$(echo "$f" | cut -d"." -f2)

    echo $pod_name

    run \
        "/usr/local/bin/k3s kubectl apply -f $f" \
        "Deploying pod \"$pod_name\"..." \
        "Pod \"$pod_name\" deployed."

    while [ $(/usr/local/bin/k3s kubectl get pods --all-namespaces --selector app=$pod_name | grep "Running" | wc -l) -ge 1 ]
    do
        echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting pods \"$pod_name\" to be ready"
        sleep 2;
    done
    /usr/local/bin/k3s kubectl get pods --all-namespaces --selector app=$pod_name | grep "Running" | wc -l
done

for f in /vagrant/confs/service.app* ; do

    service_app_name=$(echo "$f" | cut -d"." -f2)

    echo $service_app_name

    run \
        "/usr/local/bin/k3s kubectl apply -f $f" \
        "Deploying service \"$service_app_name\"..." \
        "Service \"$pod_name\" deployed."

    while [ $(/usr/local/bin/k3s kubectl get service | grep "$service_app_name" | wc -l) != 1 ]
    do
        echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting service \"$pod_name\" to be ready"
        sleep 2;
    done
done

run \
    "/usr/local/bin/k3s kubectl apply -f /vagrant/confs/ingress.all.yaml" \
    "Creating Ingress..." \
    "Ingress created."

while [ $(/usr/local/bin/k3s kubectl get ingress | grep "ingress-all" | wc -l ) != 1 ]
do
   echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting Ingress to be accessible"
   sleep 2;
done


