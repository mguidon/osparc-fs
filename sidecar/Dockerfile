FROM ubuntu:18.04


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
    python3-dev \
    python3-pip \
    python3-venv \
    tar \
    pkg-config



RUN curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v${VERSION}.tar.gz | tar zxv -C /usr/src
RUN cd /usr/src/s3fs-fuse-${VERSION} && ./autogen.sh && ./configure --prefix=/usr && make && make install

RUN apt-get update && apt-get install -y \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc && chmod +x mc && mv mc /usr/bin


WORKDIR /work

COPY requirements.txt .

RUN pip3 install -r requirements.txt


RUN apt-get update && apt-get install -y \
    gosu \
    && rm -rf /var/lib/apt/lists/*

# supermash-user uid=8004(scu) gid=8004(scu) groups=8004(scu)
RUN addgroup --gid 8004 scu
RUN useradd --uid 8004 --gid 8004 --shell /bin/bash --home /home/scu scu

WORKDIR /home/scu

ENV INPUTS_FOLDER=/home/scu/work/inputs
ENV OUTPUTS_FOLDER=/home/scu/work/outputs

RUN mkdir -p ${INPUTS_FOLDER} && \
    mkdir -p ${OUTPUTS_FOLDER}/output_1

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY boot.sh .

COPY sidecar.py .
COPY trap.sh /usr/local/bin/

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
ENTRYPOINT [ "/tini", "-g", "--", "entrypoint.sh" ]
CMD ["/bin/bash", "boot.sh"]