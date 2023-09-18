TITLE="K3S DOWNLOADER"

echo "[${TITLE}] Set timezone to Europe/Paris"
timedatectl set-timezone Europe/Paris

echo "[${TITLE}] Installation of curl and net-tools (ifconfig)"
apt install -y curl net-tools >/dev/null 2>&1

echo "[${TITLE}] Download k3s binary"
curl -Lo /usr/local/bin/k3s https://github.com/k3s-io/k3s/releases/download/v1.27.5+k3s1/k3s-arm64 >/dev/null
chmod a+x /usr/local/bin/k3s >/dev/null

echo "[${TITLE}] k3s installed"
