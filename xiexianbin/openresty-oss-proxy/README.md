# openresty-oss-proxy

proxy aliyun private oss as web

## Build

```
make docker
```

## Usage

```
docker run -it -d --rm \
  -p 8080:80 \
  -e OSS_BUCKET="dev-blog-xiexianbin-cn" \
  -e ACCESSKEY_ID="xxx" \
  -e ACCESSKEY_SECRET="xxx" \
  -e OSS_URL="http://dev-blog-xiexianbin-cn.oss-cn-hangzhou.aliyuncs.com" \
  xiexianbin/openresty-oss-proxy:1
```
