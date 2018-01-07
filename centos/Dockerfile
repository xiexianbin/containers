# Create by Xie Xianbin, For centos 
# v 1.0.0

# base image 
FROM centos:7.4.1708

RUN find /etc/yum.repos.d/ -type f -name "*.repo" | xargs -i mv {} {}.bak \
  && ls -al /etc/yum.repos.d/ \
  && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
  && curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
