#!/bin/bash
AWS_S3_MOUNT=/opt/s3fs/bucket

AWS_S3_AUTHFILE=/opt/s3fs/passwd-s3fs
echo "${AWS_S3_ACCESS_KEY_ID}:${AWS_S3_SECRET_ACCESS_KEY}" > ${AWS_S3_AUTHFILE}
chmod 600 ${AWS_S3_AUTHFILE}
mkdir -p $AWS_S3_MOUNT

s3fs -o passwd_file=${AWS_S3_AUTHFILE} \
    -o url=${AWS_S3_URL} \
    -o use_path_request_style \
    ${AWS_S3_BUCKET} ${AWS_S3_MOUNT}

# s3fs -o passwd_file=${AWS_S3_AUTHFILE} \
#     -o use_cache=/tmp \
#     -o url=${AWS_S3_URL} \
#     -o use_path_request_style \
#     ${AWS_S3_BUCKET} ${AWS_S3_MOUNT}
# #    ${AWS_S3_BUCKET}:/sub1 ${AWS_S3_MOUNT}

mc alias set s3 ${AWS_S3_URL} ${AWS_S3_ACCESS_KEY_ID} ${AWS_S3_SECRET_ACCESS_KEY} --api S3v4

exec "$@"

