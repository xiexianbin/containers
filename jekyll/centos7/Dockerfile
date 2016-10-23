# Create by Xie Xianbin, For Jekyll Dockerfile 
# v 1.1.0

# base image 
FROM xiexianbin/centos7:latest

# remark 
MAINTAINER Xie Xianbin "me@xiexianbin.cn"

# Dockerfile build cache 
ENV REFRESHED_AT 2016-10-23

# for base env
RUN rm -rf /etc/yum.repos.d/*
COPY Centos-7.repo /etc/yum.repos.d/
RUN yum clean all
RUN yum -y install gcc git net-tools vim wget libxslt zlib-devel curl tar libyaml openssl make openssl-libs

# for jekyll env
COPY *.rpm /opt/
COPY Gemfile /opt/

RUN yum install -y /opt/ruby-*.rpm
RUN yum install -y /opt/libuv*.rpm /opt/nodejs*.rpm /opt/npm*.rpm
RUN gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
RUN gem install bundler 

RUN cd /opt/; bundle install

RUN rm -rf /opt/*; yum clean all; history -c

EXPOSE 8080
ENTRYPOINT ["/bin/bash"]
