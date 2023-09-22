firewall-cmd --add-port=6444/tcp
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld

yum install -y curl net-tools
#curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s 
curl -sfL https://get.k3s.io | K3S_TOKEN=$(cat /vagrant/.agent-token) K3S_URL=https://192.168.56.110:6443 INSTALL_K3S_EXEC="agent --flannel-iface=eth1 " sh -

#sudo head -n -3 /etc/systemd/system/k3s-agent.service > /etc/systemd/system/k3s-agent.service.tmp
#sudo echo "ExecStart=/usr/local/bin/k3s agent --flannel-iface 'eth1'" >> /etc/systemd/system/k3s-agent.service.tmp
#sudo cp /etc/systemd/system/k3s-agent.service.tmp /etc/systemd/system/k3s-agent.service
#
sudo echo K3S_KUBECONFIG_MODE=\"644\" >> /etc/systemd/system/k3s-agent.service.env
#chmod a+x /usr/local/bin/k3s

#nohup /usr/local/bin/k3s agent --server "https://192.168.56.110:6443" --token $(cat /vagrant/.agent-token) --flannel-iface=eth1
sudo systemctl daemon-reload
sudo systemctl restart k3s-agent


#sudo apt install -y openssh-client
#curl -sfL https://get.k3s.io/ 
#| K3S_URL='https://<k3s_master_ip>:6443' K3S_TOKEN='xaxagardelesecret' sh -s - --node-label 'node_type=worker' --kube-proxy-arg 'metrics-bind-address=0.0.0.0'
