# Create by Xie Xianbin, For nginx Dockerfile 
# v 0.0.1 

# base image 
FROM ubuntu:14.04

# remark 
MAINTAINER Xie Xianbin "xianbinxie@163.com"

# Dockerfile build cache 
ENV REFRESHED_AT 2015-02-18

# update 
RUN apt-get update 

# install 
RUN apt-get -y install nginx 

ONBUILD ADD . /usr/share/nginx/

EXPOSE 8083

ENTRYPOINT ["/usr/sbin/nginx"]
CMD ["-g","daemon off;"]




