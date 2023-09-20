# Test SSH
rm -rf ~/.ssh/known_hosts
ssh vagrant@192.168.56.110
Password : vagrant

# Check nodes
vagrant ssh mamauraiS
k get nodes -o wide

# Check hostname
hostname
