docker build -f Dockerfile_ubuntu_jdk8 -t registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:8-ubuntu .
docker push registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:8-ubuntu


docker build -t registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:latest .
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:latest


docker build -f DockerfileJdk17 -t registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:17 .
docker push  registry.cn-guangzhou.aliyuncs.com/bigdata200/jdk:17
