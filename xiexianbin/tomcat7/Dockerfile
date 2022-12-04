# Create by Xie Xianbin, For nginx Dockerfile 
# v 0.0.1 

# base image 
FROM xiexianbin/centos6:base

# remark 
MAINTAINER Xie Xianbin "xianbinxie@163.com"

# Dockerfile build cache 
ENV REFRESHED_AT 2015-08-09

RUN rm -rf /etc/yum.repos.d/*
COPY Centos-6.repo /etc/yum.repos.d/
RUN yum clean all
RUN yum -y install wget curl vim tar
COPY apache-tomcat-7.0.63.tar.gz /opt/
COPY jdk-7u79-linux-x64.rpm /opt/

RUN rpm -ivh /opt/jdk-7u79-linux-x64.rpm
RUN tar -zxf /opt/apache-tomcat-7.0.63.tar.gz -C /opt/

RUN rm -rf /opt/jdk-7u79-linux-x64.rpm
RUN echo "sh /opt/apache-tomcat-7.0.63/bin/startup.sh" >> /etc/rc.local
RUN rm -rf /opt/apache-tomcat-7.0.63/webapps/docs
RUN rm -rf /opt/apache-tomcat-7.0.63/webapps/examples
RUN rm -rf /opt/apache-tomcat-7.0.63/webapps/host-manager
RUN rm -rf /opt/apache-tomcat-7.0.63/webapps/manager

RUN yum clean all
RUN history -c

EXPOSE 8080
ENTRYPOINT ["/bin/bash"]
