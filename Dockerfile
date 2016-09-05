FROM ubuntu:16.04
MAINTAINER John Starich <johnstarich@johnstarich.com>

# Install set up tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        tar

# Prepare the Pintos directory
WORKDIR /tmp
RUN curl -o pintos.tar.gz \
    -L http://www.stanford.edu/class/cs140/projects/pintos/pintos.tar.gz
RUN tar -xzf pintos.tar.gz && \
    mv ./pintos/src /pintos && \
    rm -rf ./pintos.tar.gz ./pintos
WORKDIR /pintos

# Install useful user programs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        coreutils \
        wget \
        vim emacs \
        gcc clang make \
        gdb ddd \
        qemu

# Clean up apt-get's files
RUN apt-get clean autoclean && \
    rm -rf /var/lib/apt/* /var/lib/cache/* /var/lib/log/*
