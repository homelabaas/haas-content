#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

export WORKER_TOKEN=`./get-environment-value.sh workertoken`
export MASTER_IP=`./get-environment-value.sh masterip`
docker swarm join $MASTER_IP:2377 --token $WORKER_TOKEN
