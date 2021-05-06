#!/bin/sh
#
echo "STARTING sidecar"

ls -l /s3fs-mnt
ls -l /s3fs-cache

echo "STARTING CAR"

touch /s3fs-mnt/test_from_heaven.txt
python3 -u sidecar.py

echo "MNT FILES AFTER CAR"

ls -l /s3fs-mnt

echo "CACHE FILES AFTER CAR"

ls -l /s3fs-cache/osparc-data

echo "FINISHED"
