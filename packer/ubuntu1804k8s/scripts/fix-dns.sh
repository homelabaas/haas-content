#!/bin/bash

apt-get update
apt-get install -y dnsmasq resolvconf

# Fix dns on ubuntu 18.04 for docker containers (requires dnsmasq and resolvconf installed)

# Edit /etc/dnsmsaq.conf and add these lines:
echo "interface=docker0" >> /etc/dnsmsaq.conf
echo "bind-interfaces" >> /etc/dnsmsaq.conf
echo "listen-address=172.17.0.1" >> /etc/dnsmsaq.conf

# Create/edit /etc/resolvconf/resolv.conf.d/tail and add this line:
echo "nameserver 172.17.0.1" >> /etc/resolvconf/resolv.conf.d/tail

systemctl restart dnsmasq.service
resolvconf -u
systemctl restart docker
