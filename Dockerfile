FROM ubuntu:16.04
MAINTAINER Michael Liu <mkliuyang@gmail.com>
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    ca-certificates \
    cmake \
    curl \
    g++ \
    git \
    make \
    unzip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY . /ltp

RUN cd /ltp && ./configure && make -j "$(nproc)" \
    && mv bin/ltp_server / && mv lib/libdynet.so /usr/lib/ && cd / && rm -fr ltp

WORKDIR /

RUN curl --silent -o ltp_data.zip http://ospm9rsnd.bkt.clouddn.com/model/ltp_data_v3.4.0.zip \
    && unzip ltp_data.zip && mv ltp_data_v3.4.0 ltp_data && rm -f ltp_data.zip

