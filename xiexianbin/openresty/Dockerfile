FROM openresty/openresty:1.25.3.2-3-noble

RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list.d/ubuntu.sources && \
  apt-get update && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y \
  ca-certificates \
  curl \
  git \
  vim \
  wget \
  tree \
  net-tools \
  iproute2 \
  tzdata && \
  apt clean

COPY entrypoint.sh /usr/local/bin/
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak && \
  ln -s usr/local/bin/entrypoint.sh /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
# CMD ["openresty"]
