FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:8-ubuntu

ENV HADOOP_HOME=/opt/hadoop \
    HADOOP_VERSION=3.3.4
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

RUN wget https://mirrors.huaweicloud.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && tar -zxvf hadoop-${HADOOP_VERSION}.tar.gz -C /opt \
    && rm -f hadoop-*.tar.gz && mv /opt/hadoop-*  ${HADOOP_HOME}

WORKDIR $HADOOP_HOME

ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop