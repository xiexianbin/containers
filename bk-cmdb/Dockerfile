FROM ccr.ccs.tencentyun.com/bk.io/cmdb-standalone:v3.9.28 as builder
RUN echo "download CMDB Base Image Done."

FROM centos:7
WORKDIR /data
COPY --from=builder /data/down.sh /data/run.sh /data
COPY --from=builder /data/sidecar /data/sidecar

CMD ["/bin/bash", "./run.sh"]
