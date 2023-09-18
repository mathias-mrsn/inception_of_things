TITLE="K3S SETUP WORKER"

ETH_IP=$1
SERVER_IP=$2
AGENT_TOKEN=$(cat /vagrant/.agent-token)

echo "[${TITLE}] Run k3s as worker"
nohup /usr/local/bin/k3s agent \
    --server https://${SERVER_IP}:6443 \
    --token ${AGENT_TOKEN} \
    --flannel-iface eth1 0<&- &>/dev/null &
 


