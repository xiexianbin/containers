# ossfs

docker build -t xiexianbin/ossfs:1.80.3 .

docker tag xiexianbin/ossfs:1.80.3 xiexianbin/ossfs:latest

https://github.com/aliyun/ossfs

## 运行命令

BUCKETNAME=maven-xiexianbin-cn
ACCESSKEYID=
ACCESSKEYSECRET=
OSS_ENDPOINT=oss-cn-qingdao.aliyuncs.com
NONEMPTY=1

docker run -d -t -i -v /var/local/ossfs:/tmp:rw --name ossfs-vol -e BUCKETNAME=${BUCKETNAME} -e ACCESSKEYID=${ACCESSKEYID} -e ACCESSKEYSECRET=${ACCESSKEYSECRET} -e OSS_ENDPOINT=${OSS_ENDPOINT} -e NONEMPTY=${NONEMPTY} --privileged xiexianbin/ossfs:latest

docker rm ossfs-vol

umount /var/local/ossfs

