#!/usr/bin/env bash
set -xeuo pipefail


rm -rf ${KYLIN_HOME}/logs
mkdir -p /workspace/logs
ln -s /workspace/logs ${KYLIN_HOME}/logs

\cp -f /opt/service-render-output/* $KYLIN_HOME/conf/
\cp -f /etc/hdfs-config/* $HADOOP_CONF_DIR
\cp -f /etc/yarn-config/* $HADOOP_CONF_DIR
\cp -f $KYLIN_HOME/conf/hive-site.xml $HIVE_HOME/conf
mkdir -p $KYLIN_HOME/hadoop_conf
\cp -r -f $HADOOP_CONF_DIR/* $KYLIN_HOME/hadoop_conf/
\cp -f $KYLIN_HOME/conf/hive-site.xml $KYLIN_HOME/hadoop_conf

hadoop fs -mkdir -p /kylin
check-env.sh
kylin.sh start


until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null

$KYLIN_HOME/bin/sample.sh

