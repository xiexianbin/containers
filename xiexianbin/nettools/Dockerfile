FROM ubuntu:20.04

RUN apt-get update && \
  apt install -y --no-install-recommends vim ca-certificates curl wget \
  gnupg2 git mercurial openssh-client procps autoconf automake bzip2 \
  dpkg-dev file g++ gcc make patch xz-utils zlib1g-dev iproute2 \
  net-tools ethtool tcptraceroute tcpdump && \
  wget https://github.com/cloverstd/tcping/releases/download/v0.1.1/tcping-linux-amd64-v0.1.1.tar.gz && \
  tar -zxvf tcping-linux-amd64-v*.tar.gz -C /usr/local/bin && \
  rm tcping-linux-amd64-v*.tar.gz && \
  apt clean all
