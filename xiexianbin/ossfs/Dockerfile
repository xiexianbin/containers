# Create by Xie Xianbin, For aliyun ossfs 
# v 1.0.0

# base image 
FROM xiexianbin/centos:latest

# remark 
MAINTAINER Xie Xianbin "me@xiexianbin.cn"

# Dockerfile build cache 
ENV REFRESHED_AT 2018-1-7

WORKDIR ~

RUN yum install automake gcc-c++ git libcurl-devel libxml2-devel fuse-devel make openssl-devel -y \
  && git clone https://github.com/aliyun/ossfs.git \
  && cd ossfs \
  && git checkout v1.80.3 \
  && ./autogen.sh \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && rm -rf /var/cache/apk/*

COPY start.sh ./

# CMD ["/root/start.sh"]
