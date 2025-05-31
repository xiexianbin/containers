FROM ubuntu:24.04

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list.d/ubuntu.sources && \
  sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list.d/ubuntu.sources && \
  apt-get update && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y \
    bash-completion \
    ca-certificates \
    curl \
    dnsutils \
    git \
    vim \
    wget \
    tree \
    make \
    systemd \
    net-tools \
    iproute2 \
    iputils-ping \
    tzdata \
    openssh-server \
    openssl \
    python3 \
    python3-pip && \
    apt clean && \
    echo "[global]\nindex-url=http://mirrors.cloud.aliyuncs.com/pypi/simple/\n\n[install]\ntrusted-host=mirrors.cloud.aliyuncs.com\n" >> /etc/pip.conf && \
    mv /usr/lib/python`python3 --version | awk '{print $2}' | awk -F "." '{print $1"."$2}'`/EXTERNALLY-MANAGED /tmp

RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
  echo "root:\$1\$5s0r2YlV\$AufLCOKQ7zTUxHuXRDtoa1" | chpasswd -e
