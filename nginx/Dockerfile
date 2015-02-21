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
#RUN ["apt-get", "-y", "install", "nginx"]

ADD ./project01/ /usr/share/nginx/project01/

ADD ./default /etc/nginx/sites-enabled/default

EXPOSE 80

# ENTRYPOINT ["/etc/init.d/nginx", "start"] 

ENTRYPOINT ["/bin/bash"] 


# ENTRYPOINT ["/usr/sbin/nginx"]
# CMD ["-g","daemon off;"]
# CMD ["-h"]




