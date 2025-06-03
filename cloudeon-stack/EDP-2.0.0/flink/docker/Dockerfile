# TODO
# Dinky 支持：
# Python 支持： 将 Flink 自身的 PyFlink 相关 jar 包依赖放到合适的位置；
# MinIO S3 支持：将 $FLINK_HOME/opt/flink-s3-fs-presto-1.20.0.jar 复制到 $FLINK_HOME/plugins/s3-fs-presto 目录；
# Flink-CDC 支持
# Doris Flink Connector 支持
# Kafka 支持
# Paimon 支持
# 常用数据库驱动：MySQL, Postgres, Oracle, SQLServer, 

ARG FLINK_VERSION=1.20.1

# flink官方镜像tag（如 1.20.0-scala_2.12-java8, 1.20.0-scala_2.12-java11, 1.18.1-scala_2.12-java8, 1.19.1-scala_2.12-java8）
# FROM flink:${FLINK_VERSION}-scala_2.12
FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/flink:${FLINK_VERSION}-scala_2.12

ARG FLINK_VERSION

ENV FLINK_HOME=/opt/flink
#ENV PYTHON_HOME=/opt/miniconda3

ENV HADOOP_VERSION=3.3.4
ENV HADOOP_HOME=/opt/hadoop
#ADD hadoop-${HADOOP_VERSION}.tar.gz /opt
#RUN ln -s /opt/hadoop-${HADOOP_VERSION} ${HADOOP_HOME}
RUN wget https://mirrors.huaweicloud.com/apache/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz \
    && tar -zxvf  hadoop-${HADOOP_VERSION}.tar.gz \
    && mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} \
    && rm -rf hadoop-${HADOOP_VERSION}.tar.gz
ENV HADOOP_CLASSPATH=${HADOOP_HOME}/etc/hadoop:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/hdfs:${HADOOP_HOME}/share/hadoop/hdfs/lib/*:${HADOOP_HOME}/share/hadoop/hdfs/*:${HADOOP_HOME}/share/hadoop/yarn/lib/*:${HADOOP_HOME}/share/hadoop/yarn/*:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HOME}/share/hadoop/mapreduce/*:${HADOOP_HOME}/contrib/capacity-scheduler/*.jar
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/conf
ENV PATH=${PATH}:${HADOOP_CLASSPATH}:${HADOOP_CONF_DIR}:${HADOOP_HOME}/bin

USER root

#RUN wget "https://s3.jcloud.sjtu.edu.cn/899a892efef34b1b944a19981040f55b-oss01/anaconda/miniconda/Miniconda3-py38_4.9.2-Linux-x86_64.sh" -O "miniconda.sh" && chmod +x miniconda.sh
#RUN ./miniconda.sh -b -p $PYTHON_HOME && chown -R flink $PYTHON_HOME && ls $PYTHON_HOME

#RUN wget "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-py311_25.1.1-1-Linux-x86_64.sh" -O "miniconda.sh" && chmod +x miniconda.sh
#RUN ./miniconda.sh -b -p $PYTHON_HOME && chown -R flink $PYTHON_HOME && ls $PYTHON_HOME

# 把当前extends目录下的jar添加进依赖目录
# dinky-*相关依赖包来源于dinky的extends和lib目录
# flink-connector-starrocks-1.2.11_flink-1.20.jar需要提前自己编译
# flink-shaded-zookeeper-3.5.9.jar来源于Flink低版本比如1.16
ADD extends $FLINK_HOME/lib

#ENV PATH=$PYTHON_HOME/bin:$PATH
#RUN pip install "apache-flink==${FLINK_VERSION}" -i http://pypi.douban.com/simple/ --trusted-host pypi.douban.com

# 此用户会有权限问题，即后面报错“cp: cannot create regular file '/opt/flink/lib/flink-python-1.20.0.jar': Permission denied”
#USER flink
# 删除loader包，替换为不带loader的
RUN echo "deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt update \
    && apt install -y python3.10 \
    && ln -s /usr/bin/python3.10 /usr/local/bin/python \
    && apt install -y python3-pip \
    # 清理 apt 安装软件包后的缓存
    && apt-get install -y wget \
    && apt-get clean \
    && mv $FLINK_HOME/opt/flink-table-planner_2.12-*.jar $FLINK_HOME/lib \
    && cp $FLINK_HOME/opt/flink-python-*.jar $FLINK_HOME/lib \
    && mkdir $FLINK_HOME/plugins/s3-fs-presto \
    && cp $FLINK_HOME/opt/flink-s3-fs-presto-*.jar $FLINK_HOME/plugins/s3-fs-presto \
    && chown -R flink:flink $FLINK_HOME \
    && pip install apache-flink==${FLINK_VERSION} -i https://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com \
    # 下载相关jar依赖添加进依赖目录 \
    # && wget https://repo1.maven.org/maven2/org/apache/flink/flink-s3-fs-hadoop/1.20.1/flink-s3-fs-hadoop-1.20.1.jar -O /opt/flink/lib/flink-s3-fs-hadoop-1.20.1.jar \
    # && wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/1.12.645/aws-java-sdk-s3-1.12.645.jar -O /opt/flink/lib/aws-java-sdk-s3-1.12.645.jar \
    && wget -P $FLINK_HOME/lib \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-s3-fs-hadoop/1.20.1/flink-s3-fs-hadoop-1.20.1.jar \
    https://maven.aliyun.com/repository/public/com/amazonaws/aws-java-sdk-s3/1.12.645/aws-java-sdk-s3-1.12.645.jar \
    https://maven.aliyun.com/repository/public/org/apache/avro/avro/1.11.3/avro-1.11.3.jar \
    https://maven.aliyun.com/repository/public/commons-cli/commons-cli/1.9.0/commons-cli-1.9.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-avro/1.20.1/flink-avro-1.20.1.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-common/3.4.0/flink-cdc-common-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-doris/3.4.0/flink-cdc-pipeline-connector-doris-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-elasticsearch/3.4.0/flink-cdc-pipeline-connector-elasticsearch-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-kafka/3.4.0/flink-cdc-pipeline-connector-kafka-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-mysql/3.4.0/flink-cdc-pipeline-connector-mysql-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-paimon/3.4.0/flink-cdc-pipeline-connector-paimon-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-pipeline-connector-starrocks/3.4.0/flink-cdc-pipeline-connector-starrocks-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-cdc-runtime/3.4.0/flink-cdc-runtime-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-connector-jdbc/3.3.0-1.20/flink-connector-jdbc-3.3.0-1.20.jar \
    https://maven.aliyun.com/repository/public/org/apache/doris/flink-doris-connector-1.20/24.1.0/flink-doris-connector-1.20-24.1.0.jar \
    # 注意：阿里云不提供 Cloudera 包，可以使用清华或华为镜像，或者保留原地址
    https://repository.cloudera.com/repository/cloudera-repos/org/apache/flink/flink-shaded-hadoop-3-uber/3.1.1.7.2.9.0-173-9.0/flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar \
    # https://maven.aliyun.com/repository/public/org/apache/zookeeper/zookeeper/3.5.9/zookeeper-3.5.9.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-kafka/3.4.0-1.20/flink-sql-connector-kafka-3.4.0-1.20.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-mysql-cdc/3.4.0/flink-sql-connector-mysql-cdc-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-oracle-cdc/3.4.0/flink-sql-connector-oracle-cdc-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-postgres-cdc/3.4.0/flink-sql-connector-postgres-cdc-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-sqlserver-cdc/3.4.0/flink-sql-connector-sqlserver-cdc-3.4.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/flink/flink-sql-connector-tidb-cdc/3.4.0/flink-sql-connector-tidb-cdc-3.4.0.jar \
    https://maven.aliyun.com/repository/public/com/h2database/h2/1.4.200/h2-1.4.200.jar \
    https://maven.aliyun.com/repository/public/org/apache/httpcomponents/httpclient/4.5.13/httpclient-4.5.13.jar \
    https://maven.aliyun.com/repository/public/org/apache/httpcomponents/client5/httpclient5/5.1.4/httpclient5-5.1.4.jar \
    https://maven.aliyun.com/repository/public/org/apache/httpcomponents/httpcore/4.4.16/httpcore-4.4.16.jar \
    https://maven.aliyun.com/repository/public/org/apache/httpcomponents/core5/httpcore5/5.1.5/httpcore5-5.1.5.jar \
    https://maven.aliyun.com/repository/public/javax/ws/rs/javax.ws.rs-api/2.0.1/javax.ws.rs-api-2.0.1.jar \
    https://maven.aliyun.com/repository/public/org/apache/kafka/kafka_2.13/4.0.0/kafka_2.13-4.0.0.jar \
    https://maven.aliyun.com/repository/public/org/apache/kafka/kafka-clients/4.0.0/kafka-clients-4.0.0.jar \
    https://maven.aliyun.com/repository/public/com/microsoft/sqlserver/mssql-jdbc/12.6.1.jre11/mssql-jdbc-12.6.1.jre11.jar \
    https://maven.aliyun.com/repository/public/com/mysql/mysql-connector-j/8.4.0/mysql-connector-j-8.4.0.jar \
    https://maven.aliyun.com/repository/public/com/oracle/database/jdbc/ojdbc8/23.6.0.24.10/ojdbc8-23.6.0.24.10.jar \
    https://maven.aliyun.com/repository/public/com/oracle/database/nls/orai18n/23.6.0.24.10/orai18n-23.6.0.24.10.jar \
    https://maven.aliyun.com/repository/public/org/apache/paimon/paimon-flink-1.20/1.0.1/paimon-flink-1.20-1.0.1.jar \
    https://maven.aliyun.com/repository/public/org/apache/paimon/paimon-flink-action/1.0.1/paimon-flink-action-1.0.1.jar \
    https://maven.aliyun.com/repository/public/org/apache/paimon/paimon-flink-cdc/1.0.1/paimon-flink-cdc-1.0.1.jar \
    https://maven.aliyun.com/repository/public/org/apache/paimon/paimon-s3/1.0.1/paimon-s3-1.0.1.jar \
    https://maven.aliyun.com/repository/public/org/postgresql/postgresql/42.7.3/postgresql-42.7.3.jar \
    # Java 11环境下缺少JAXB实现，添加相关依赖
    https://maven.aliyun.com/repository/public/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar \
    https://maven.aliyun.com/repository/public/com/sun/xml/bind/jaxb-core/2.3.0.1/jaxb-core-2.3.0.1.jar \
    https://maven.aliyun.com/repository/public/com/sun/xml/bind/jaxb-impl/2.3.1/jaxb-impl-2.3.1.jar \
    https://maven.aliyun.com/repository/public/javax/activation/activation/1.1.1/activation-1.1.1.jar \
    https://maven.aliyun.com/repository/public/com/sun/istack/istack-commons-runtime/3.0.8/istack-commons-runtime-3.0.8.jar \
#    && wget https://github.com/DataLinkDC/dinky/releases/download/v1.2.3/dinky-release-1.20-1.2.3.tar.gz \
#    && tar -zxvf dinky-release-1.20-1.2.3.tar.gz \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/jar/dinky-app-1.20-1.2.3-jar-with-dependencies.jar $FLINK_HOME/lib \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/extends/flink1.20/dinky/dinky-catalog-mysql-1.20-1.2.3.jar $FLINK_HOME/lib \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/extends/flink1.20/dinky/dinky-catalog-postgres-1.20-1.2.3.jar $FLINK_HOME/lib \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/extends/flink1.20/dinky/dinky-client-1.20-1.2.3.jar $FLINK_HOME/lib \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/lib/dinky-client-base-1.2.3.jar $FLINK_HOME/lib \
#    && cp $FLINK_HOME/lib/dinky-release-1.20-1.2.3/lib/dinky-common-1.2.3.jar $FLINK_HOME/lib \
    # && wget https://mirrors.aliyun.com/apache/flink/flink-1.20.1/flink-1.20.1-bin-scala_2.12.tgz \
    && wget https://mirrors.tuna.tsinghua.edu.cn/apache/flink/flink-1.20.1/flink-1.20.1-bin-scala_2.12.tgz \
    && tar -zxvf flink-1.20.1-bin-scala_2.12.tgz \
    && cp flink-1.20.1/lib/*  $FLINK_HOME/lib \
    # 清理压缩包缓存  \
    && rm -rf $FLINK_HOME/lib/dinky-release-1.20-1.2.3.tar.gz flink-1.20.1-bin-scala_2.12.tgz $FLINK_HOME/lib/dinky-release-1.20-1.2.3 flink-1.20.1 \
    && rm -rf $FLINK_HOME/lib/flink-table-planner-loader-*.jar \
    # 清理 pip 所有缓存
    && pip cache purge

USER flink