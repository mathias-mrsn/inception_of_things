FILENAME="make"
ARCH="$(uname -m)"
GITLAB_ACCESS_TOKEN="$(xxd -p /dev/urandom | head -c 32)"

printf "$FILENAME $1:\n\n"

run() {
    echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : $2"
    eval sudo $1 >/dev/null 
    if [ $? -eq 0 ]; then
        echo "[$(date +'%m_%d__%H:%M:%S')] SUCCESS : $3"
    else
        >&2 echo "[$(date +'%m_%d__%H:%M:%S')] ERROR   : Failed to run the command \"$1\"."
    fi
}

if [ $1 == "run" ]; then


   run \
       "k3d cluster create gitlab --port 80:80" \
       "Creating gitlab cluster..." \
       "Cluster created."

   run \
       "kubectl apply -f ./confs/namespace" \
       "Creating of gitlab namespace..." \
       "Namespace created."

   run \
       "kubectl apply -f ./confs/gitlab/$ARCH" \
       "Deploying of gitlab on $ARCH..." \
       "Gitlab deployed"


   while [ $(sudo kubectl get pods -n gitlab 2>/dev/null | grep "Running" | wc -l) != 1 ]
   do
       echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting gitlab to be deployed..."
       sleep 5;
   done

   while (( $(curl localhost:80 2>/dev/null | grep 'Bad Gateway\|too much time' | wc -l) == 1 || $(echo $?) != 0));
   do
       echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting gitlab to be accessible..."
       sleep 5;
   done

   run \
       "mkdir -p /etc/gitlab" \
       "Creating of gitlab directory..." \
       "Gitlab directory generated."

   run \
       "sh -c 'printf "$GITLAB_ACCESS_TOKEN" > /etc/gitlab/.gitlab_access_token'" \
       "Generating access token..." \
       "Access token generated."

   POD_ID="$(sudo kubectl get pods -n gitlab | grep "gitlab" | awk '{print $1}')"

   run \
       "kubectl exec ${POD_ID} -n gitlab -- gitlab-rails runner \"token = User.find_by_username('root').personal_access_tokens.create(scopes: ['api', 'read_api'], name: 'root token', expires_at: 365.days.from_now); token.set_token('$GITLAB_ACCESS_TOKEN'); token.save\"" \
       'Generating token access...' \
       'Token access generated.'

elif [ $1 == "clean" ]; then
    
    run \
        "k3d cluster delete gitlab" \
        "Deleting gitlab cluster..." \
        "Cluster deleted"
fi

