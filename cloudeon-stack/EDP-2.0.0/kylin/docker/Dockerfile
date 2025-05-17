FROM registry.cn-shenzhen.aliyuncs.com/yixiao_cloudeon/hive:3.1.3

ENV KYLIN_HOME=/opt/kylin
ENV PATH=$PATH:$KYLIN_HOME/bin
WORKDIR /home/hadoop/

RUN wget --no-check-certificate  https://mirrors.huaweicloud.com/apache/kylin/apache-kylin-5.0.0-beta/apache-kylin-5.0.0-beta-bin.tar.gz \
    && tar -zxvf apache-kylin-*-bin.tar.gz -C /opt/  \
    && rm -f apache-kylin-*-bin.tar.gz && mv /opt/apache-kylin-*  $KYLIN_HOME
WORKDIR $KYLIN_HOME

RUN $KYLIN_HOME/sbin/download-spark-user.sh && rm -rf spark-newten-*.tgz && rm -rf hive_*.tar.gz
RUN mv $HIVE_HOME/lib/mysql-connector-java.jar $KYLIN_HOME/lib/ext/