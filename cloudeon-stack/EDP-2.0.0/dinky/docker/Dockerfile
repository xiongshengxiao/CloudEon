FROM registry.cn-guangzhou.aliyuncs.com/bigdata200/flink:1.15.4


ENV FLINK_VERSION=1.15.4
ENV FLINK_BIG_VERSION=1.15
ENV DINKY_VERSION="1.1.0"
ENV DINKY_HOME="/opt/dinky"
ENV PATH=$PATH:$DINKY_HOME/bin

WORKDIR /tmp
RUN wget https://github.com/DataLinkDC/dinky/releases/download/v${DINKY_VERSION}/dinky-release-${FLINK_BIG_VERSION}-${DINKY_VERSION}.tar.gz \
    && tar zxvf dinky-release-*.tar.gz -C /opt && rm -f dinky-release-*.tar.gz \
    && mv /opt/dinky-release-* $DINKY_HOME

ENV MYSQL_JDBC_DRIVER_VERSION=8.0.30
RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_JDBC_DRIVER_VERSION}/mysql-connector-java-${MYSQL_JDBC_DRIVER_VERSION}.jar \
    && mv mysql-connector-java-${MYSQL_JDBC_DRIVER_VERSION}.jar $DINKY_HOME/lib/


RUN wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-connector-jdbc/1.15.4/flink-connector-jdbc-1.15.4.jar \
    && wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch7/1.15.4/flink-sql-connector-elasticsearch7-1.15.4.jar \
    && wget https://repo1.maven.org/maven2/org/apache/doris/flink-doris-connector-1.15/1.4.0/flink-doris-connector-1.15-1.4.0.jar \
    && wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/1.15.4/flink-sql-connector-kafka-1.15.4.jar \
    && wget https://repo1.maven.org/maven2/com/ververica/flink-sql-connector-mysql-cdc/2.4.1/flink-sql-connector-mysql-cdc-2.4.1.jar \
    && wget https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-hive-3.1.2_2.12/1.15.4/flink-sql-connector-hive-3.1.2_2.12-1.15.4.jar \
    && wget https://repo.maven.apache.org/maven2/org/apache/hudi/hudi-flink1.15-bundle/0.13.1/hudi-flink1.15-bundle-0.13.1.jar \
    && mv *.jar $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/
RUN wget https://repository.cloudera.com/artifactory/cloudera-repos/org/apache/flink/flink-shaded-hadoop-3-uber/3.1.1.7.2.9.0-173-9.0/flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar \
    && mv flink-shaded-hadoop-3-uber-3.1.1.7.2.9.0-173-9.0.jar $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/dinky/

WORKDIR $DINKY_HOME
