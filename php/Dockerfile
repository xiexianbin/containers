# Create by Xie Xianbin, For PHP Dockerfile 
#
# docker run -d -t -i -p 8082:8082 -v /var/local/www/:/var/www/html:rw --name php xiexianbin/centos6:php
#
# v 1.0.0 

# base image 
FROM xiexianbin/centos6:base

# remark 
MAINTAINER Xie Xianbin "xianbinxie@163.com"

# Dockerfile build cache 
ENV REFRESHED_AT 2016-02-13

RUN rm -rf /etc/yum.repos.d/*
COPY Centos-6.repo /etc/yum.repos.d/
RUN yum clean all
RUN yum -y install wget curl vim tar

RUN yum install httpd -y
RUN yum install php php-devel -y
RUN yum install php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc -y

RUN chkconfig httpd on

RUN yum clean all
RUN history -c

EXPOSE 8082
ENTRYPOINT ["/bin/bash"]
