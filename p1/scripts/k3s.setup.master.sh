TITLE="K3S SETUP MASTER"

ETH_IP=$1
NAME=$2

echo "[${TITLE}] Run k3s as master"
nohup /usr/local/bin/k3s server \
    --write-kubeconfig-mode=644 \
    --node-ip ${ETH_IP} \
    --node-name ${NAME} 0<&- &>/dev/null &

until /usr/local/bin/k3s kubectl describe node &>/dev/null
do
    echo "[${TITLE}] Wait k3s to be started up…"
    sleep 5;
done

echo "[${TITLE}] Copy agent-token in project directory"
cp /var/lib/rancher/k3s/server/agent-token /vagrant/.agent-token
