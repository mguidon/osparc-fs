include ../.env

SHELL := /bin/bash

PHONY: build shell build-car shell-car
build:
	docker build -t osparc-sidecar .

build-car:
	docker build -f Dockerfile.car -t osparc-car .

shell:
	{ \
	docker run --rm -it \
	--device /dev/fuse \
	--cap-add SYS_ADMIN \
	--security-opt "apparmor=unconfined" \
	-v s3fs-cache:/s3fs-cache \
	-v /tmp/bla:/s3fs-mnt:rshared \
	-v s3fs-testing:/s3fs-testing \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-e AWS_S3_URL=${S3_URL} \
	-e AWS_S3_BUCKET=${S3_BUCKET} \
	-e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} \
	-e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} \
	osparc-sidecar /bin/bash ;\
	}

run:
	{ \
	docker run --rm \
	--device /dev/fuse \
	--cap-add SYS_ADMIN \
	--security-opt "apparmor=unconfined" \
	-v s3fs-cache:/s3fs-cache \
	-v /tmp/bla:/s3fs-mnt:rshared \
	-v s3fs-testing:/s3fs-testing \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-e AWS_S3_URL=${S3_URL} \
	-e AWS_S3_BUCKET=${S3_BUCKET} \
	-e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} \
	-e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} \
	osparc-sidecar ;\
    }

clear-volumes:
	docker volume rm s3fs-testing
	docker volume rm s3fs-cache