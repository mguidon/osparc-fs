FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION 1.89

RUN apt-get update && apt-get install -y \
    automake \
    curl \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libfuse-dev \
    libtool \
    libxml2-dev mime-support \
    tar \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*



RUN curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v${VERSION}.tar.gz | tar zxv -C /usr/src
RUN cd /usr/src/s3fs-fuse-${VERSION} && ./autogen.sh && ./configure --prefix=/usr && make && make install

RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/bin

COPY entrypoint.sh /usr/local/bin/

WORKDIR /opt/s3fs

COPY benchmark.sh .

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]