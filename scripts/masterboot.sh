#yum install -y openssh-clients openssh
sudo firewall-cmd --add-port=6443/tcp
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld
#yum install -y container-selinux selinux-policy-base
#rpm -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
yum install -y curl net-tools
#curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.26.5+k3s1/k3s 
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --bind-address=192.168.56.110 --node-external-ip=192.168.56.110 --flannel-iface=eth1 " sh -


#sudo cp /etc/systemd/system/k3s.service /etc/systemd/system/k3s.service.tmp
#sudo head -n -1 /etc/systemd/system/k3s.service.tmp > /etc/systemd/system/k3s.service
#sudo echo "--flannel-iface 'eth1'" >> /etc/systemd/system/k3s.service

#sudo head -n -3 /etc/systemd/system/k3s.service > /etc/systemd/system/k3s.service.tmp
#sudo echo "ExecStart=/usr/local/bin/k3s server --flannel-iface 'eth1'" >> /etc/systemd/system/k3s.service.tmp
#sudo cp /etc/systemd/system/k3s.service.tmp /etc/systemd/system/k3s.service
#echo `cat /etc/systemd/system/k3s.service`

#sudo systemctl stop k3s
#k3s certificate rotate
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

sudo echo K3S_KUBECONFIG_MODE=\"644\" >> /etc/systemd/system/k3s.service.env
#chmod a+x /usr/local/bin/k3s
#sysctl -w net.ipv4.ip_forward=1
#nohup /usr/local/bin/k3s server --bind-address=192.168.56.110 --node-external-ip=192.168.56.110 --flannel-iface=eth1 --write-kubeconfig-mode=644
cp /var/lib/rancher/k3s/server/node-token /vagrant/.agent-token
sudo systemctl daemon-reload
sudo systemctl start k3s

#sudo apt install -y container-selinux selinux-policy-base
#rmp -i https://rpm.rancher.io/k3s-selinux-0.1.1-rc1.el7.noarch.rpm
#curl -sfL https://get.k3s.io/ | sh -
##sudo echo "--flannel-iface 'eth1'" > /etc/systemd/system/k3s.service
#systemctl daemon-reload
#systemctl restart k3s
#sudo apt install -y systemd
#sudo apt install -y openssh-client openssh-server
#cp /var/lib/rancher/k3s/server/node-token /vagrant
##| K3S_TOKEN='xaxagardelesecret' sh -s - server --write-kubeconfig-mode '0644' --node-taint 'node-role.kubernetes.io/master=true:NoSchedule' --disable 'servicelb' --disable 'traefik' --disable 'local-path' --kube-controller-manager-arg 'bind-address=0.0.0.0' --kube-proxy-arg 'metrics-bind-address=0.0.0.0' --kube-scheduler-arg 'bind-address=0.0.0.0' --kube-controller-manager-arg 'terminated-pod-gc-threshold=10'
