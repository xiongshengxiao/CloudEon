FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/rockylinux:9

LABEL baseos=rockylinux9

ENV TZ=Asia/Shanghai  \
    FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV PATH=$PATH:$FREEMARKER_GENERATOR_CLI_HOME/bin
ENV MINIO_HOME=/opt/minio \
    MINIO_VERSION=2025-04-22T22-12-26Z
ENV PATH=${PATH}:${MINIO_HOME}/bin \
    MINIOBINDIR=${MINIO_HOME}/bin
ENV JAVA_HOME=/opt/jdk1.8.0_331
ENV PATH=$JAVA_HOME/bin:$PATH \
    LD_LIBRARY_PATH=$JAVA_HOME/lib/amd64/jli:$JAVA_HOME/lib/amd64

ADD freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz jdk-8u331-linux-x64.tar.gz /opt/

RUN mkdir -p $MINIO_HOME/bin \
    && mkdir $MINIO_HOME/conf \
    && mkdir /data \
    && curl -o $MINIO_HOME/bin/minio http://dl.minio.org.cn/server/minio/release/linux-amd64/minio.RELEASE.${MINIO_VERSION} \
    && chmod +x $MINIO_HOME/bin/minio \
    && mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
    # 安装 cron、nc 等命令
    && dnf install -y cronie \
    && dnf install -y nmap \
    && dnf clean all
WORKDIR $MINIO_HOME
