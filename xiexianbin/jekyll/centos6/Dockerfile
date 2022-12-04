# Create by Xie Xianbin, For Jekyll Dockerfile 
# v 0.0.1

# base image 
FROM xiexianbin/centos6:base

# remark 
MAINTAINER Xie Xianbin "xianbinxie@163.com"

# Dockerfile build cache 
ENV REFRESHED_AT 2015-11-29

# for base env
RUN rm -rf /etc/yum.repos.d/*
COPY Centos-6.repo /etc/yum.repos.d/
RUN rpm -ivh http://mirrors.zju.edu.cn/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum clean all
RUN yum -y install gcc git wget curl vim tar

# for jekyll env
RUN yum install nodejs libyaml -y
COPY ruby-1.9.3p545-1.el6.x86_64.rpm /opt/

RUN rpm -ivh /opt/ruby-1.9.3p545-1.el6.x86_64.rpm
RUN rm -rf /opt/ruby-1.9.3p545-1.el6.x86_64.rpm
RUN gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
RUN gem install jekyll --version "=1.4.2"
RUN gem install kramdown

RUN yum clean all
RUN history -c

EXPOSE 8080
ENTRYPOINT ["/bin/bash"]
