#!/bin/bash

apt-get install -y cloud-init
mkdir -p /var/lib/cloud/seed/nocloud-net
rm  /etc/cloud/cloud.cfg.d/90_dpkg.cfg
sed -i '/preserve_hostname: false/a datasource_list: [ NoCloud, None]' /etc/cloud/cloud.cfg
sed -i '/TimeoutStopSec=5/a ExecStartPost=+/usr/bin/getUserMetaData.sh'  /lib/systemd/system/open-vm-tools.service

cat >/usr/bin/getUserMetaData.sh <<EOL
#!/bin/bash

/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.metadata" | base64 -d > /var/lib/cloud/seed/nocloud-net/meta-data
/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.userdata" | base64 -d > /var/lib/cloud/seed/nocloud-net/user-data
/usr/bin/vmtoolsd --cmd "info-get guestinfo.cloudconfig.networkconfig" | base64 -d > /var/lib/cloud/seed/nocloud-net/network-config
EOL

chmod +x /usr/bin/getUserMetaData.sh
systemctl daemon-reload
