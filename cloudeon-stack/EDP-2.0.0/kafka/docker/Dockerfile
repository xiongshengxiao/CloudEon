# FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu
FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:17


ENV KAFKA_HOME=/opt/kafka \
    # KAFKA_VERSION=2.8.2
    KAFKA_VERSION=4.0.0
ENV PATH=${PATH}:${KAFKA_HOME}/bin

# 安装 bash
# RUN apk add --no-cache bash

# RUN wget https://mirrors.huaweicloud.com/apache/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz \
RUN wget https://mirrors.aliyun.com/apache/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz \
    && tar -zxvf kafka*.tgz -C /opt \
    && mv /opt/kafka* $KAFKA_HOME \
    && rm -f kafka*.tgz

# 生成 cluster_id 并写入文件
RUN $KAFKA_HOME/bin/kafka-storage.sh random-uuid > /cluster_id.txt

WORKDIR $KAFKA_HOME
