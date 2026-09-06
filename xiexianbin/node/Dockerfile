# FROM node:24
FROM m.daocloud.io/docker.io/library/node:24

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources && \
  sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list.d/debian.sources && \
  apt-get update && \
  apt clean && \
  npm config set registry https://registry.npmmirror.com -g
