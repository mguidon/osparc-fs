FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION 1.89

RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/kahing/goofys/releases/latest/download/goofys && chmod +x goofys && mv goofys /usr/bin
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/bin

COPY entrypoint.sh /usr/local/bin/

WORKDIR /opt/goofys

COPY benchmark.sh .

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]