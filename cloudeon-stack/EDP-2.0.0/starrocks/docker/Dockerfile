FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/openjdk:11

ENV STARROCKS_VERSION=3.3.13
ENV STARROCKS_HOME=/opt/starrocks
ENV TZ=Asia/Shanghai  \
    FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV JAVA_HOME=/usr/local/openjdk-11
ENV PATH=$PATH:$STARROCKS_HOME/fe/bin:$STARROCKS_HOME/be/bin:$JAVA_HOME/bin:$FREEMARKER_GENERATOR_CLI_HOME/bin
ENV LD_LIBRARY_PATH="$JAVA_HOME/lib:$JAVA_HOME/lib/server"

WORKDIR /tmp

# 镜像过大建议下载到本地再上传解压到容器
ARG STARROCKS_DOWNLOAD_URL=https://releases.starrocks.io/starrocks/StarRocks-${STARROCKS_VERSION}-centos-amd64.tar.gz

ADD freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz /opt/

RUN wget "$STARROCKS_DOWNLOAD_URL" \
    && tar -xvf "StarRocks-${STARROCKS_VERSION}-centos-amd64.tar.gz" -C /opt \
    && rm -f "StarRocks-${STARROCKS_VERSION}-centos-amd64.tar.gz" \
    && mv "/opt/StarRocks-${STARROCKS_VERSION}-centos-amd64" "$STARROCKS_HOME" \
    && mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli

RUN sed -i 's/http:\/\/deb.debian.org\/debian/https:\/\/mirrors.aliyun.com\/debian/g' /etc/apt/sources.list \
    && sed -i 's/http:\/\/security.debian.org/deb http:\/\/security.debian.org.debian-security/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y mariadb-client cron

WORKDIR $STARROCKS_HOME $JAVA_HOME
