#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

REMOTE_MASTER_IP=$(./get-environment-value.sh masterip)
SHA_TOKEN=$(./get-environment-value.sh shatoken)
K8S_TOKEN=$(./get-environment-value.sh k8stoken)

kubeadm join $REMOTE_MASTER_IP:6443 --token $K8S_TOKEN --discovery-token-ca-cert-hash sha256:$SHA_TOKEN
