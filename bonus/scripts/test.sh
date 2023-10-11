ORIGINAL_DIR=$(pwd)

RAND=$(date +'%m_%d__%H:%M:%S')
RED='\e[31m'    # Red text
GREEN='\e[32m'  # Green text
BLUE='\e[34m'   # Blue text
RESET='\e[0m'   # Reset text color to default

#Clone the app repo in GitLab
sudo apt-get install git
cd ~ && git clone https://github.com/xchalle/xchalle_appconf.git tmp_${RAND}
cd tmp_${RAND} && \
git checkout bonus && \
rm -rf .git && \
git init && \
git remote add origin http://root:ThisIsMyPassword42@127.0.0.1/root/xchalle_appconf.git && \
git add . && \
git config --global user.email "xchalle@student.42.fr" && \
git config --global user.name "Xavier Challe" && \
git commit -m 'script commit' && \
git push origin master && \
cd "$ORIGINAL_DIR" && \
rm -rf ~/tmp_${RAND} && \

#Apply the ArgoCD application
sudo kubectl config use-context k3d-my-cluster
sudo kubectl apply -f ./confs/application/application.yaml
sudo kubectl config use-context k3d-gitlab

echo -e "${BLUE}Bonus application -> http://localhost:8888/bonus"
