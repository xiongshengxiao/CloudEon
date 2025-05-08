# FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/flink:1.15.4
# FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/flink:1.20.1
FROM rockylinux:9

LABEL baseos=rockylinux9

ENV FLINK_VERSION=1.20.1
ENV FLINK_BIG_VERSION=1.20
# ENV DINKY_VERSION=1.2.3
# ENV DINKY_HOME=/opt/dinky
# ENV PATH=$PATH:$DINKY_HOME/bin

ENV TZ=Asia/Shanghai  \
    FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV DINKY_HOME=/opt/dinky \
    DINKY_VERSION=1.2.3
ENV JAVA_HOME=/opt/jdk-11.0.24
ENV MYSQL_CLIENT_HOME=/opt/mysql-shell-8.4.4-linux-glibc2.28-x86-64bit
ENV PATH=$PATH:$JAVA_HOME/bin:$FREEMARKER_GENERATOR_CLI_HOME/bin:$DINKY_HOME/bin:$MYSQL_CLIENT_HOME/bin \
    LD_LIBRARY_PATH=$JAVA_HOME/lib/amd64/jli:$JAVA_HOME/lib/amd64

# TODO flink-1.20.1-conf.tgz 仅包含 flink/conf 目录及其配置文件（Dinky使用flink原生api提交任务，flink源码在提交任务过程中会读取dinky本地 /opt/flink/conf 下的文件作为容器内配置目录挂载，所以需要提前把 flink安装目录下的conf目录内文件全部复制到此，在集群配置处flink配置文件目录填写/opt/flink/conf即可。）
ADD freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz jdk-11.0.24_linux-x64_bin.tar.gz \
    mysql-community-client-8.4.4-el9.x86_64.tar.gz \
    dinky-release-1.20-1.2.3-with-dependencies.tar.gz flink-1.20.1-conf.tgz /opt/

RUN mv $DINKY_HOME-release-* $DINKY_HOME \
    && mv /opt/flink-1.20.1 /opt/flink \
    && mkdir /data \
    && mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
    # 安装 MySQL 官方客户端命令（相比 MySQL Shell，磁盘空间占用小） \
    && dnf install -y /opt/mysql-community-client-plugins-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-common-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-libs-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-client-8.4.4-1.el9.x86_64.rpm \
    # 安装 cron、nc、ps 等命令
    && dnf install -y cronie \
    && dnf install -y nmap \
    && dnf install -y procps \
    # 清理本地和下载的 rpm 安装包
    && rm -fv /opt/mysql-community-*.rpm \
    && dnf clean all

WORKDIR $DINKY_HOME
