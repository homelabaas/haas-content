#!/bin/bash

# Note: this script still needs a reasonable amount of work.

kubeadm init --ignore-preflight-errors=all --cri-socket /run/containerd/containerd.sock --pod-network-cidr=10.1.0.0/16
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

kubeadm join 192.168.0.201:6443 --token 6xp864.lo2e5uvuiwp53jjl --discovery-token-ca-cert-hash sha256:aef8fbe4f2c38f1dd2ad71a659646084846b56edb56c3b2384e34a93f2f7bc9b

SHA_TOKEN=`openssl x509 -in /etc/kubernetes/pki/ca.crt -noout -pubkey | openssl rsa -pubin -outform DER 2>/dev/null | sha256sum | cut -d' ' -f1`
K8S_TOKEN=`kubeadm token list | cut -d' ' -f1 | sed -n 2p`
