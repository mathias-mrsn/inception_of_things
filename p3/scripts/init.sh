sudo apt install gnome-terminal

NAMESPACE="argocd"

# Function to check if all pods are in the "Running" state
check_pods_status() {
  while true; do
    # Get the list of pods in the namespace and filter them by the "Running" status
    running_pods=$(sudo kubectl get pods -n "$NAMESPACE" --field-selector=status.phase=Running --output=jsonpath='{.items[*].status.phase}')

    # Count the number of running pods
    num_running_pods=$(echo "$running_pods" | grep -o "Running" | wc -l)

    # Get the total number of pods in the namespace
    total_pods=$(sudo kubectl get pods -n "$NAMESPACE" --output=jsonpath='{.items[*].metadata.name}' | wc -w)

    # Check if all pods are in the "Running" state
    if [ "$num_running_pods" -eq "$total_pods" ]; then
      echo "All pods in '$NAMESPACE' are in the 'Running' state."
      break
    else
      echo "Waiting for all pods in '$NAMESPACE' to be in the 'Running' state ($num_running_pods/$total_pods)..."
      sleep 5  # Adjust the sleep interval as needed
    fi
  done
}

sudo apt remove docker-desktop
rm -r $HOME/.docker/desktop
sudo rm /usr/local/bin/com.docker.cli
sudo apt purge docker-desktop
sudo apt install -y docker.io
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
kubectl version --client
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
sudo k3d cluster create my-cluster --api-port 6443 --agents 2
sudo kubectl create namespace argocd
#sudo kubectl create namespace dev
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#sudo kubectl apply -n dev -f deployment.yaml
#sudo kubectl port-forward service/xchalle-playground-service -n dev 8888:8888 && sudo kubectl port-forward service/argocd-server -n argocd 8080:443 &
sudo kubectl apply -n argocd -f ./../confs/application.yaml
#sudo kubectl wait pod --all --for=condition=Ready
check_pods_status
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > ../.password && echo "Argo CD password is in .password file on the root of the part"
