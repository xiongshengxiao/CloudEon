docker build -f Dockerfile_ubuntu_jdk8 -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu .
docker push registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu


docker build -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:latest .
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:latest


docker build -f DockerfileJdk17 -t registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:17 .
docker push  registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:17
