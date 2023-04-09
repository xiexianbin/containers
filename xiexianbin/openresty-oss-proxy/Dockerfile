FROM openresty/openresty:1.21.4.1-6-focal

# RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
#   apt update

ADD oss.conf /etc/nginx/conf.d/
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD oss_auth.lua /usr/local/openresty/nginx/lua/oss_auth.lua

COPY docker-entrypoint.sh /usr/local/bin/
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak && \
  ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]

# CMD ["openresty"]
