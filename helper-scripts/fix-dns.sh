#!/bin/bash

cp /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart docker
