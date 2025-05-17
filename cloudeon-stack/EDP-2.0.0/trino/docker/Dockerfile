FROM ghcr.io/airlift/jvmkill:latest AS jvmkill

FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/jdk:17

ENV TRINO_HOME=/opt/trino
ENV PATH=$PATH:$TRINO_HOME/bin

WORKDIR /tmp

RUN wget https://repo1.maven.org/maven2/io/trino/trino-server/424/trino-server-424.tar.gz  \
    && tar -zxvf trino-server-*.tar.gz -C /opt \
    && rm -f trino-server-*.tar.gz && mv /opt/trino-server-*  $TRINO_HOME  \
    && wget https://repo1.maven.org/maven2/io/trino/trino-cli/424/trino-cli-424-executable.jar \
    && mv trino-cli-*-executable.jar $TRINO_HOME/bin/trino-cli && chmod +x $TRINO_HOME/bin/trino-cli

COPY --from=jvmkill /libjvmkill.so $TRINO_HOME/bin/
RUN yum install -y less

WORKDIR $TRINO_HOME