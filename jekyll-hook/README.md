# xiexianbin/jekyll-hook-docker

ref：https://github.com/xiexianbin/jekyll-hook

## build

```
docker build -t xiexianbin/jekyll-hook-docker .
docker push xiexianbin/jekyll-hook-docker
```

## use

### 获取镜像：

```
docker pull xiexianbin/jekyll-hook-docker
```

### 启动容器：

```
GH_SERVER=github.com
IS_PUBLIC_REPO=false
WEB_HOOK_SECRET=xiexianbin.cn
EMAIL_IS_ACTIVATED=true
EMAIL_USER=jekyll-hook@jcloud.xyz
EMAIL_PASSWORD=jh@jcloud.xyz
EMAIL_HOST=smtp.ym.163.com
EMAIL_PORT=994
EMAIL_TLS=false
EMAIL_SSL=true
NOTIFY_EMAIL=me@xiexianbin.cn
GITHUB_ACCOUNTS=xiexianbin
ID_RSA="-----BEGIN RSA PRIVATE KEY-----
MIIEpgIBAAKCAQEA78sCgPP8B+sD8gw9geseujbXdndzag9vOItf8QAGaCw/hHzr
pDhG0ECoQCiAaTAEE4XQtcL0rVI9vPFR1jPNEikhkCo+y3CTHoJhN0kMFLkymW1V
zK84okMy+x5vaVhxvZ2JxXj+1PdvizblL9BF2eNPIAsKnPQoMoYTsBEYxeDybqeT
/SgRm2K6yLDvYSMOOpXTrPSo72nLLUmI271RiqFuy96WiC9ntlgoaQ91KczOPLZA
aW3UkXZbse0BKHfzpXQ65+kG9/HCA+bGZajvt4Gc/UnmqUw6cKxsf4I1pdv8ge5e
jlAW33399LoZC81Ig6cvWJAZDkg6DDrm5Ybj0QIDAQABAoIBAQDjudk72/nrDx8l
HMjA/CinUfPXluNtwxCuE3be6lYrUnJUAUrMH4Hovq7Kl2wz+Ry16axnIam6fFMT
f95nXbSQXa15OxV9oQCmxc1LcrzdZXAPU01bYMCZINZms+W8lvkVyWoQtrLUT9SH
0m9ftBzSK1R2quW+XwVZzgkeeW4cZIlTGK9OxGU6Ego4/S6RObK4nEprD4IC3SGn
qAo6RkiWIGcXbwbOvJxphO+t5H9OqfaGyV6DJTmjN6Pr4rEyP0Z1WSaPLV5qzKKo
8Njyk5muhai2dMU2hAeMYXn/KstRlWrh0+jLMJqE0FyRTLtq0md+uaMKKl43n9wA
/8JY103NAoGBAPszvxNSHTNEzxT2I75BJpjlHdh1jI08JJHC/30kFsb74mpZ+4Bk
9PYsrm1n9Bcboa/Yw/mp7lGSsoEKu6bT/p0gDKCVbxBxtpd214c6VFtq+ciP0ggi
hTsTZn98FtifRSxiZ1jAcFJDiRqOMksQU+lwrWTAWs9uJqwfUYmYWC/LAoGBAPRf
enpDFlYIqOUsah/xScYgslKO7EwT8zWi1IlymstpmJMgpbAnAa9nS8W6Y2m5SKA4
QbRmK1DcqVxOdffxayP3tRZUOH/UZ+t4Djsz0VbPgUwPEq2guwDTsxq8pRLIBlCv
AABAQXtZAtJ42W6IpbS9HNYsiS2qBu1eQEp5F49TAoGBAMzDAHTSUWUSKK7QeJBD
8R9eW7avEvOpW7HJPpMWUM7AUW4ZjQ26vYbRIxmhS/FuH50EV7LyFoY9yu2u/wlc
8sXHcyOOy6qe1pSeVc8v98VQ7OzUdwMUiH+AL+OpFcJcCXnFeLJ6otQbou2XjV1s
oMm/hEeFGEDPbAyPttou6WuDAoGBAPQW7mpy2jujOLh4jaRMSck53YRzN/mhr7uy
YiLMM2vclMbYxEbYH2nJfrkIvMXciXtn1dFQgBGr5wrJYDIBlWf+w4WDKFAepJJh
f62Iy5+vctG6+IgvVLq1ul+JcET7QLuUoSafCAkh1pzOkzhCC2olv0j6gSb4fyTX
kNYScAL7AoGBAKrFtAgXB3Cr9C8C1gwJdlcDoEWaorDGeI1nzCmIDM/5DfFbaF2b
3SfSYnCnMdQ+/WG6vFKN3AefwgPhnaDe8ERV64lB6AdeUzFzm7trSg/igcYP3Ew/
59/2Mzy/kLv0CNb7Ssp1sPA1nMUu3SP2VlDmOklfsU/P9Z5VEkd81py8
-----END RSA PRIVATE KEY-----"
```

```
docker run -i -t -d \
  --restart=always \
  --name jekyll_hook \
  -p 8081:80 \
  -v /var/local/jekyll-docker/sources:/srv/sources:rw \
  -v /var/local/jekyll-docker/logs:/srv/logs:rw \
  -v /var/local/jekyll-docker/website:/srv/website:rw \
  -e GH_SERVER=$GH_SERVER \
  -e IS_PUBLIC_REPO=$IS_PUBLIC_REPO \
  -e WEB_HOOK_SECRET=$WEB_HOOK_SECRET \
  -e EMAIL_IS_ACTIVATED=$EMAIL_IS_ACTIVATED \
  -e EMAIL_USER=$EMAIL_USER \
  -e EMAIL_PASSWORD=$EMAIL_PASSWORD \
  -e EMAIL_HOST=$EMAIL_HOST \
  -e EMAIL_PORT=$EMAIL_PORT \
  -e EMAIL_TLS=$EMAIL_TLS \
  -e EMAIL_SSL=$EMAIL_SSL \
  -e NOTIFY_EMAIL=$NOTIFY_EMAIL \
  -e GITHUB_ACCOUNTS=$GITHUB_ACCOUNTS \
  -e ID_RSA="$ID_RSA" \
  xiexianbin/jekyll-hook-docker
```

说明：

- 默认端口 8080
- 需要域名解析，http://webhooks.domain:8080/hooks/jekyll/:branch，:branch 为对应的分支，不同分支应添加不同branch的webhooks
- 通过 http://webhooks.domain:8081 访问gitpages
- 支持邮件发送

### 添加 webhook

ref : https://github.com/xiexianbin/jekyll-hook#webhook-setup-on-github
