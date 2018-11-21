#!/bin/bash

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt update
apt install -y cri-tools ebtables ethtool kubeadm kubectl kubelet kubernetes-cni
swapoff -a
echo "runtime-endpoint: unix:///run/containerd/containerd.sock" > /etc/crictl.yaml
sysctl net.ipv4.ip_forward=1
