include ../.env
export

PHONY: build shell bench
build:
	docker build -t osparc-s3fs .

shell:
	docker run -it --privileged -e AWS_S3_URL=${S3_URL} -e AWS_S3_BUCKET=${S3_BUCKET} -e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} -e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} osparc-s3fs /bin/bash 

bench:
	docker run -it --privileged -e AWS_S3_URL=${S3_URL} -e AWS_S3_BUCKET=${S3_BUCKET} -e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} -e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} osparc-s3fs /bin/bash benchmark.sh