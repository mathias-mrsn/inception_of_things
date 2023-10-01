FILENAME="make"
ARCH=$(uname -m)

printf "$FILENAME\n\n"

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

   while [ $(curl localhost:80 2>/dev/null | grep 'Bad Gateway\|too much time' | wc -l) == 1 ]
   do
       echo "[$(date +'%m_%d__%H:%M:%S')] INFO    : Waiting gitlab to be accessible..."
       sleep 5;
   done


elif [ $1 == "clean" ]; then
    
    run \
        "k3d cluster delete gitlab" \
        "Deleting gitlab cluster..." \
        "Cluster deleted"
fi

