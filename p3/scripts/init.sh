#!/bin/bash

NAMESPACE="argocd"

RED='\e[31m'    # Red text
GREEN='\e[32m'  # Green text
BLUE='\e[34m'   # Blue text
RESET='\e[0m'   # Reset text color to default

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
      echo -e "All pods in '$NAMESPACE' are in the '${GREEN}Running${RESET}' state."
      break
    else
      echo -e "Waiting for all pods in '$NAMESPACE' to be in the '${GREEN}Running${RESET}' state ($num_running_pods/$total_pods)..."
      sleep 5  # Adjust the sleep interval as needed
    fi
  done
}

#Install docker
sudo apt install -y docker.io

#Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
kubectl version --client

#Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

#Create the application cluster and connect the host port 8888 to the traefix port (default 80)
sudo k3d cluster create my-cluster --api-port 6443 --agents 2 -p 8888:80


sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl apply -n argocd -f ./confs/application.yaml

#Wait for argocd pods to be running...
check_pods_status



#port forward port 443 to port 8080 of the host to access argocd-UI
sudo kubectl port-forward service/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &

echo -n -e "The default Argo CD password is ${RED}" && sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d | tee .password
echo -e "${RESET}, you can find it in the .password file at the root of this part"
echo -e "${GREEN}ArgoCD-UI -> https://localhost:8080"
echo -e "${BLUE}Application -> http://localhost:8888"
