#!/bin/bash

curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

systemctl stop systemd-resolved
systemctl disable systemd-resolved

docker-compose build
docker-compose up -d