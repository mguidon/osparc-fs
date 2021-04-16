#!/bin/bash

AWS_S3_MOUNT=/opt/goofys/bucket

mkdir -p $AWS_S3_MOUNT

# Run syslog-ng
syslog-ng

# Build credentials file
mkdir -p /root/.aws/ /mnt/s3
chmod 700 /root/.aws
cat - > /root/.aws/credentials <<CREDENTIALS
[default]
aws_access_key_id = ${AWS_S3_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_S3_SECRET_ACCESS_KEY}
CREDENTIALS

# This always usse a cache by default
goofys -o allow_other -f --endpoint=${AWS_S3_URL} ${AWS_S3_BUCKET} /opt/goofys/bucket &

mc alias set s3 ${AWS_S3_URL} ${AWS_S3_ACCESS_KEY_ID} ${AWS_S3_SECRET_ACCESS_KEY} --api S3v4

exec "$@"

