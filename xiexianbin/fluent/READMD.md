
docker build -t fluent/fluentd:v1.11-debian ./
docker run -d -p 24224:24224 -p 24224:24224/udp fluent/fluentd:v1.11-debian
