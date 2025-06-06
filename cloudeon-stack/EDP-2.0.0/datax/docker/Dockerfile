FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/rockylinux:9

# 设置环境变量
# 设置环境变量
ENV DATAX_HOME="/opt/datax"
ENV DATAX_WEB_VERSION="2.1.2"
ENV DATAX_WEB_HOME="/opt/datax-web"
ENV PATH=$PATH:$DATAX_WEB_HOME/bin
ENV PYTHON_PATH="$DATAX_HOME/bin/datax.py"
ENV TZ=Asia/Shanghai  \
    FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV JAVA_HOME=/opt/jdk-11.0.24
ENV MYSQL_CLIENT_HOME=/opt/mysql-shell-8.4.4-linux-glibc2.28-x86-64bit
ENV PATH=$PATH:$JAVA_HOME/bin:$FREEMARKER_GENERATOR_CLI_HOME/bin:$MYSQL_CLIENT_HOME/bin \
    LD_LIBRARY_PATH=$JAVA_HOME/lib/amd64/jli:$JAVA_HOME/lib/amd64

# 使用 ADD 自动解压 datax.tar.gz
ADD datax-web-${DATAX_WEB_VERSION}.tar.gz \
    datax.tar.gz \
    freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz \
    jdk-11.0.24_linux-x64_bin.tar.gz \
    mysql-community-client-8.4.4-el9.x86_64.tar.gz /opt/

RUN mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli \
    && mv /opt/datax-web-* $DATAX_WEB_HOME \
    # 解决DataX执行需要用到Python环境
    && dnf install -y python3 python3-pip \
    && ln -s /usr/bin/python3 /usr/bin/python \
    # 解决DataX执行任务报错：在有总bps限速条件下,单个channel的bps值不能为空,也不能为非正数
    && sed -i 's/"byte": -1/"byte": 2000000/' "$DATAX_HOME/conf/core.json" \
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
    && dnf clean all \
    # 执行安装脚本并验证安装结果
    && chmod +x $DATAX_WEB_HOME/bin/install.sh \
    && { echo "y"; } | $DATAX_WEB_HOME/bin/install.sh --force \
    # 验证安装结果
    && test -d "$DATAX_WEB_HOME/modules" || { echo "Installation failed: modules directory not created"; exit 1; }

# 暴露端口
EXPOSE 8080 9999 9527

# 设置工作目录
WORKDIR $DATAX_HOME
WORKDIR $DATAX_WEB_HOME