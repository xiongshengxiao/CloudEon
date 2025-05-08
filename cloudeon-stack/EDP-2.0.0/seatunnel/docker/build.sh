docker build  -f Dockerfile -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/seatunnel:2.3.8  .
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/seatunnel:2.3.8

docker build  -f Dockerfile_web -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/seatunnel-web:1.0.2  .
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/seatunnel-web:1.0.2


