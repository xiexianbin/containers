FROM alpine:3.14.4

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  /sbin/apk add --no-cache bind-tools curl wget && \
  rm -r /var/cache/
