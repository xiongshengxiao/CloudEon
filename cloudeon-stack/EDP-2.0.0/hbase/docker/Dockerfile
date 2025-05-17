FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/hadoop:3.3.4

ENV HBASE_HOME=/opt/hbase
ENV HBASE_VERSION=2.4.16
ENV PATH=$PATH:$HBASE_HOME/bin

WORKDIR /tmp/

RUN wget https://mirrors.huaweicloud.com/apache/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz \
    && tar -zxvf hbase-*-bin.tar.gz -C /opt \
    && rm -f hbase-*-bin.tar.gz && mv /opt/hbase-* $HBASE_HOME

WORKDIR $HBASE_HOME








