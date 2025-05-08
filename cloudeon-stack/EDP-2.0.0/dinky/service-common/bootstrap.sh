#!/usr/bin/env bash
set -xeuo pipefail

rm -rf logs
mkdir -p /workspace/logs
ln -s /workspace/logs logs

\cp -f /opt/service-render-output/* $DINKY_HOME/config/
#\cp -f /etc/hdfs-config/* $HADOOP_CONF_DIR
#\cp -f /etc/yarn-config/* $HADOOP_CONF_DIR
#\cp -f /etc/flink-config/* $FLINK_HOME/conf/

mkdir -p $DINKY_HOME/bin/
\cp -f /opt/service-common/auto.sh $DINKY_HOME/bin/
chmod +x $DINKY_HOME/bin/auto.sh
#\cp -f $FLINK_HOME/lib/* $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/
# 需要替换 flink-table-planner-loader jar包
#rm -f $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/flink-table-planner-loader*.jar
#\cp -f $FLINK_HOME/opt/flink-table-planner*.jar $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/

# 检查数据库是否存在
if mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';" | grep "$MYSQL_DATABASE" > /dev/null
then
    echo "数据库已存在"
else
    echo "数据库不存在"
    # 创建数据库
    mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -e "CREATE DATABASE $MYSQL_DATABASE;"
    echo "数据库已创建"
    # 执行 SQL 脚本
    mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -D$MYSQL_DATABASE < /opt/dinky/sql/dinky-mysql.sql
fi

# 检查对应hdfs目录是否存在
#if hadoop fs -test -d /dinky
#then
#    echo "hdfs目录已存在"
#else
#    echo "hdfs目录不存在,创建hdfs目录,并上传jar包到hdfs"
#    hadoop fs -mkdir -p /dinky/jar/
#    hadoop fs -mkdir -p /dinky/flink-lib/1.15.4/
#    hadoop fs -put $DINKY_HOME/extends/flink$FLINK_BIG_VERSION/*.jar  /dinky/flink-lib/1.15.4/
#    cp jar/dinky-app-*.jar /tmp/dinky-app-$FLINK_BIG_VERSION-$DINKY_VERSION.jar
#    hadoop fs -put /tmp/dinky-app-$FLINK_BIG_VERSION-$DINKY_VERSION.jar /dinky/jar/
#fi

auto.sh startWithJmx

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null


