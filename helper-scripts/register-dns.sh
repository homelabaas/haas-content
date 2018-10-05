#!/bin/bash

export MY_IP=`ip addr show ens192 | grep -Po 'inet \K[\d.]+'`
export BUILDER_URL=`/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.builderurl"`
export MY_HOSTNAME=`hostname`
curl -s --header "Content-Type: application/json" --request POST --data "{\"ip\":\"$MY_IP\", \"name\":\"$MY_HOSTNAME\"}" $BUILDER_URL/api/dns
