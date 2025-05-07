docker build  -f Dockerfile -t registry.cn-guangzhou.aliyuncs.com/bigdata200/seatunnel:2.3.7  .
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/seatunnel:2.3.7

docker build  -f Dockerfile_web -t registry.cn-guangzhou.aliyuncs.com/bigdata200/seatunnel-web:1.0.1  .
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/seatunnel-web:1.0.1


