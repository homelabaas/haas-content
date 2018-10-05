#!/bin/bash

sed -i 's/^ExecStart=\/usr\/bin\/dockerd.*/ExecStart=\/usr\/bin\/dockerd -H fd:\/\/ -H tcp:\/\/0.0.0.0:2376/' /lib/systemd/system/docker.service
systemctl daemon-reload
systemctl restart docker.service
docker plugin install --grant-all-permissions --alias vsphere vmware/vsphere-storage-for-docker:latest
