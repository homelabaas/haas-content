#!/bin/bash

curl -o /usr/bin/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
chmod +x /usr/bin/mc

mkdir /minio

cat >/usr/bin/configureminio.sh <<EOL
#!/bin/bash

export MINIO_URL=\`/usr/bin/vmtoolsd --cmd "info-get guestinfo.minio.address"\`
export MINIO_ACCESS_KEY=\`/usr/bin/vmtoolsd --cmd "info-get guestinfo.minio.accesskey"\`
export MINIO_SECRET_KEY=\`/usr/bin/vmtoolsd --cmd "info-get guestinfo.minio.secretkey"\`

mc config host add minio \$MINIO_URL \$MINIO_ACCESS_KEY \$MINIO_SECRET_KEY
EOL

cat >/usr/bin/syncfiles.sh <<EOL
#!/bin/bash

export MINIO_BUCKET=\`/usr/bin/vmtoolsd --cmd "info-get guestinfo.minio.bucket"\`
mc cp minio/\$MINIO_BUCKET/ /minio --recursive
EOL

chmod +x /usr/bin/configureminio.sh
chmod +x /usr/bin/syncfiles.sh
