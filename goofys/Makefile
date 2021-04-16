include ../.env
export

PHONY: builc, shell, benchmark
build:
	docker build -t osparc-goofys .

shell:
	docker run -it --privileged -e AWS_S3_URL=${S3_URL} -e AWS_S3_BUCKET=${S3_BUCKET} -e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} -e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} osparc-goofys /bin/bash

bench:
	docker run -it --privileged -e AWS_S3_URL=${S3_URL} -e AWS_S3_BUCKET=${S3_BUCKET} -e AWS_S3_ACCESS_KEY_ID=${S3_ACCESS_KEY} -e AWS_S3_SECRET_ACCESS_KEY=${S3_SECRET_KEY} osparc-goofys /bin/bash benchmark.sh