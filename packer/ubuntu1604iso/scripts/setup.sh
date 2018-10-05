#!/bin/bash

apt-get update
apt-get -y dist-upgrade
apt-get -y install git

hostnamectl set-hostname $HOSTNAME_SET
echo -e "127.0.0.1\tlocalhost\n127.0.1.1\t$HOSTNAME_SET" > /etc/hosts
