FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/rockylinux:9

LABEL baseos=rockylinux9

ENV SUPERSET_VERSION=1.20.1
ENV SUPERSET_HOME=/opt/superset
ENV MINICONDA3_HOME=/opt/miniconda3
ENV TZ=Asia/Shanghai
ENV FREEMARKER_GENERATOR_CLI_HOME=/opt/freemarker-generator-cli
ENV JAVA_HOME=/usr/lib/jvm/java-17/
ENV PATH=$PATH:$JAVA_HOME/bin:$FREEMARKER_GENERATOR_CLI_HOME/bin

ADD freemarker-generator-cli-0.2.0-SNAPSHOT-app.tar.gz /opt/

RUN \
    # 更换国内源
    sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
        -i.bak \
        /etc/yum.repos.d/rocky*.repo \
    # 设置时区
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo 'Asia/Shanghai' >/etc/timezone \
    && mv /opt/freemarker-generator-cli-* /opt/freemarker-generator-cli \
    # 安装 cron、nc、ps 等命令
    && dnf install -y cronie \
    && dnf install -y nmap \
    && dnf install -y procps \
    # 安装JDK
    && dnf install java-17-openjdk-devel -y \
    && dnf install -y wget vim \
    # 安装miniconda
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh\
    && sh /miniconda.sh -b -p $MINICONDA3_HOME \
    # 清理安装脚本
    && rm -rf /miniconda.sh \
    # 将 conda 添加到 PATH
    && echo "export PATH=$MINICONDA3_HOME/bin:$PATH" >> /etc/profile \
    && echo "export PATH=$MINICONDA3_HOME/bin:$PATH" >> ~/.bashrc \
    # 配置 conda 国内镜像
    && $MINICONDA3_HOME/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free \
    && $MINICONDA3_HOME/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main \
    && $MINICONDA3_HOME/bin/conda config --set show_channel_urls yes \
    #  安装Superset所需依赖
    && dnf install -y gcc gcc-c++ libffi-devel python-devel python-pip python-setuptools openssl-devel cyrus-sasl-devel openldap-devel pkg-config \
    # 安装 MySQL 开发包-需要先启动mysql或mariadb默认，否则下载安装会提示找不到包
    && dnf module enable mariadb -y \
    && dnf install -y mariadb-devel mysql \
    # 清理本地和下载的 rpm 安装包
    && dnf clean all \
    && rm -rf /var/cache/dnf/* \
    && rm -rf /tmp/* /var/tmp/*

WORKDIR $SUPERSET_HOME