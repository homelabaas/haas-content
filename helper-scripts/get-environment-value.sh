#!/bin/bash

export ENVIRONMENT_NAME=`/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.environment"`
export BUILDER_URL=`/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.builderurl"`
curl -s $BUILDER_URL/api/environmentsetting/$ENVIRONMENT_NAME/$1  | sed -e 's/^"//' -e 's/"$//'
