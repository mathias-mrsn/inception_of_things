ORIGINAL_DIR=$(pwd)

#Clone the app repo in GitLab
sudo apt-get install git
cd ~ && git clone https://github.com/xchalle/xchalle_appconf.git
cd xchalle_appconf && \
git checkout bonus && \
rm -rf .git && \
git init && \
git remote add origin http://root:ThisIsMyPassword42@127.0.0.1/root/xchalle_appconf.git && \
git add . && \
git commit -m 'script commit' && \
git push origin master && \
cd "$ORIGINAL_DIR" && \
rm -rf ~/xchalle_appconf && \

#Apply the ArgoCD application
sudo kubectl config use-context k3d-my-cluster
sudo kubectl apply -f ./confs/application/application.yaml
sudo kubectl config use-context k3d-gitlab
