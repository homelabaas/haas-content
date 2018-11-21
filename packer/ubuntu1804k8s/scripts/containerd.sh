#!/bin/bash

wget https://github.com/containerd/containerd/releases/download/v1.1.2/containerd-1.1.2.linux-amd64.tar.gz
tar xf containerd-1.1.2.linux-amd64.tar.gz -C /usr/local

wget -O /usr/local/sbin/runc https://github.com/opencontainers/runc/releases/download/v1.0.0-rc5/runc.amd64
chmod 755 /usr/local/sbin/runc

curl -o /etc/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/cri/master/contrib/systemd-units/containerd.service
systemctl daemon-reload
systemctl enable containerd
systemctl start containerd
systemctl status containerd
