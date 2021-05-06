#!/bin/sh
#

echo "$INFO" "Starting boot ... "$@" " 

export AWS_S3_MOUNT=/s3fs-mnt
export AWS_S3_CACHE=/s3fs-cache

AWS_S3_AUTHFILE=/etc/passwd-s3fs
echo "${AWS_S3_ACCESS_KEY_ID}:${AWS_S3_SECRET_ACCESS_KEY}" > ${AWS_S3_AUTHFILE}

chmod 600 ${AWS_S3_AUTHFILE}

mkdir -p $AWS_S3_MOUNT

DEVEL_MOUNT=/devel

USERNAME=scu
GROUPNAME=scu

chown -R $USERNAME:$GROUPNAME /s3fs-testing
chown -R $USERNAME:$GROUPNAME /s3fs-mnt
chown -R $USERNAME:$GROUPNAME /home/scu

s3fs -o passwd_file=${AWS_S3_AUTHFILE} \
    -o use_cache=${AWS_S3_CACHE} \
    -o url=${AWS_S3_URL} \
    -o use_path_request_style \
    -o dbglevel=info \
    -o uid=8004 \
    -o gid=8004 \
    -o allow_other \
    -o nonempty \
    ${AWS_S3_BUCKET} ${AWS_S3_MOUNT}

ls -l "${AWS_S3_MOUNT}"


mounted=$(mount | grep fuse.s3fs | grep "${AWS_S3_MOUNT}")
if [ -n "${mounted}" ]; then
    echo "Mounted bucket ${AWS_S3_BUCKET} onto ${AWS_S3_MOUNT}"
else
    echo "Mount failure"
fi

DOCKER_MOUNT=/var/run/docker.sock
if stat $DOCKER_MOUNT > /dev/null 2>&1
then
    echo "$INFO detected docker socket is mounted, adding user to group..."
    GROUPID=$(stat --format=%g $DOCKER_MOUNT)
    GROUPNAME=scdocker

    if ! addgroup --gid "$GROUPID" $GROUPNAME > /dev/null 2>&1
    then
        echo "$WARNING docker group with $GROUPID already exists, getting group name..."
        # if group already exists in container, then reuse name
        GROUPNAME=$(getent group "${GROUPID}" | cut --delimiter=: --fields=1)
        echo "$WARNING docker group with $GROUPID has name $GROUPNAME"
    fi
    adduser scu $GROUPNAME
fi

. trap.sh

gosu scu "$@" 