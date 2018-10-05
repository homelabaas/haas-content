#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

export EXISTING_WORKER_TOKEN=`./get-environment-value.sh workertoken`
export MASTER_IP=`ip addr show ens192 | grep -Po 'inet \K[\d.]+'`
if [ $EXISTING_WORKER_TOKEN = "null" ]
then
    docker swarm init
    export WORKER_TOKEN=`docker swarm join-token worker -q`
    export MASTER_TOKEN=`docker swarm join-token manager -q`
    ./set-environment-value.sh workertoken $WORKER_TOKEN
    ./set-environment-value.sh mastertoken $MASTER_TOKEN
    ./set-environment-value.sh masterip $MASTER_IP
else
    export REMOTE_MASTER_IP=`./get-environment-value.sh masterip`
    export MASTER_TOKEN=`./get-environment-value.sh mastertoken`
    docker swarm join $REMOTE_MASTER_IP:2377 --token $MASTER_TOKEN
fi
