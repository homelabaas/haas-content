#!/bin/bash

export ENVIRONMENT_NAME=`/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.environment"`
export BUILDER_URL=`/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.builderurl"`
curl -s --header "Content-Type: application/json" --request POST --data "{\"$1\":\"$2\"}" $BUILDER_URL/api/environmentsetting/$ENVIRONMENT_NAME
