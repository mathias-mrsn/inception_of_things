curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

/usr/local/bin/k3s kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io
helm install gitlab gitlab/gitlab \
  --namespace gitlab \
  --set global.hosts.domain=your-domain.com \
  --set certmanager-issuer.email=your-email@example.com

