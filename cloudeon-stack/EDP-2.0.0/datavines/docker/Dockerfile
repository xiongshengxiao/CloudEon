FROM rockylinux:9

LABEL baseos=rockylinux9

ENV TZ=Asia/Shanghai  \
    FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV PATH=$PATH:$FREEMARKER_GENERATOR_CLI_HOME/bin
ENV DATAVINES_HOME=/opt/datavines \
    DATAVINES_VERSION=1.0.0
ENV PATH=${PATH}:${DATAVINES_HOME}/bin \
    DATAVINESBINDIR=${DATAVINES_HOME}/bin
ENV JAVA_HOME=/opt/jdk1.8.0_331
ENV MYSQL_CLIENT_HOME=/opt/mysql-shell-8.4.4-linux-glibc2.28-x86-64bit
ENV PATH=$JAVA_HOME/bin:$PATH \
    PATH=$MYSQL_CLIENT_HOME/bin:$PATH \
    LD_LIBRARY_PATH=$JAVA_HOME/lib/amd64/jli:$JAVA_HOME/lib/amd64

ADD freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz jdk-8u331-linux-x64.tar.gz \
    mysql-community-client-8.4.4-el9.x86_64.tar.gz datavines-1.0.0.tar.gz /opt/

RUN mv ${DATAVINES_HOME}-${DATAVINES_VERSION} ${DATAVINES_HOME} \
    && mkdir /data \
    && mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
    # 安装 MySQL 官方客户端命令（相比 MySQL Shell，磁盘空间占用小）
    && dnf install -y /opt/mysql-community-client-plugins-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-common-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-libs-8.4.4-1.el9.x86_64.rpm \
    && dnf install -y /opt/mysql-community-client-8.4.4-1.el9.x86_64.rpm \
    # 安装 cron、nc 等命令
    && dnf install -y cronie \
    && dnf install -y nmap \
    # 清理本地和下载的 rpm 安装包
    && rm -fv /opt/mysql-community-*.rpm \
    && dnf clean all
WORKDIR $DATAVINES_HOME
