FROM ubuntu:20.04

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
  sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

RUN apt-get update && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y \
    bash-completion \
    ca-certificates \
    curl \
    git \
    vim \
    wget \
    tree \
    make \
    systemd \
    net-tools \
    iproute2 \
    tzdata \
    openssh-server && \
    apt clean
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
  echo "root:\$1\$5s0r2YlV\$AufLCOKQ7zTUxHuXRDtoa1" | chpasswd -e
