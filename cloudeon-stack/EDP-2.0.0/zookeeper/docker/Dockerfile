FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu

ENV ZOOKEEPER_HOME=/opt/zookeeper \
    ZOOKEEPER_VERSION=3.7.1
ENV PATH=${PATH}:${ZOOKEEPER_HOME}/bin \
    ZOOBINDIR=${ZOOKEEPER_HOME}/bin

RUN wget https://mirrors.huaweicloud.com/apache/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz \
    && tar -zxvf apache-zookeeper-*-bin.tar.gz -C /opt \
    && mv /opt/apache-zookeeper-* $ZOOKEEPER_HOME \
    && rm -f apache-zookeeper-*-bin.tar.gz

WORKDIR $ZOOKEEPER_HOME

