FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/hadoop:3.3.4

ENV SPARK_HOME=/opt/spark
ENV SPARK_VERSION=3.2.3
ENV PATH=$PATH:$SPARK_HOME/bin

WORKDIR /tmp

RUN wget https://mirrors.huaweicloud.com/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz \
    && tar -zxvf spark-*.tgz -C /opt \
    && rm -f spark-*.tgz && mv /opt/spark-*  ${SPARK_HOME}

# support iceberg
RUN wget https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-spark-runtime-3.2_2.12/1.2.1/iceberg-spark-runtime-3.2_2.12-1.2.1.jar \
    && mv iceberg-spark-runtime*.jar ${SPARK_HOME}/jars/

WORKDIR $SPARK_HOME