#!/bin/bash

kubeadm init --ignore-preflight-errors=all --cri-socket /run/containerd/containerd.sock --pod-network-cidr=10.1.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

SHA_TOKEN=$(openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | openssl rsa -pubin -outform DER 2>/dev/null | sha256sum | cut -d' ' -f1)
K8S_TOKEN=$(kubeadm token list | cut -d' ' -f1 | sed -n 2p)
MASTER_IP=$(ip addr show ens192 | grep -Po 'inet \K[\d.]+')

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

./set-environment-value.sh masterip $WORKER_TOKEN
./set-environment-value.sh shatoken $SHA_TOKEN
./set-environment-value.sh k8stoken $K8S_TOKEN
