#!/bin/bash

hostnamectl set-hostname $HOSTNAME_SET
echo -e "127.0.0.1\tlocalhost\n127.0.1.1\t$HOSTNAME_SET" > /etc/hosts
apt-get install -y aptitude build-essential git ntp ntpdate python-dev sudo
git clone -b stable/queens https://github.com/openstack/openstack-ansible.git /opt/openstack-ansible
cd /opt/openstack-ansible
scripts/bootstrap-ansible.sh
