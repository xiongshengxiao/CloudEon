#!/usr/bin/env bash
set -xeuo pipefail

ETC_DIR=$TRINO_HOME/conf

mkdir -p /workspace/logs
mkdir -p $TRINO_HOME/conf/catalog

\cp -f /opt/service-render-output/* $TRINO_HOME/conf/
\cp -f /etc/hdfs-config/* $TRINO_HOME/conf/
for file in "$TRINO_HOME/conf/catalog-"*; do
  filename=$(basename "$file")
  mv "$file" "$TRINO_HOME/conf/catalog/${filename#catalog-}"
done

if [[ "${ROLE_FULL_NAME}" == "trino-coordinator" ]]; then
launcher --etc-dir=$ETC_DIR  \
--node-config=$ETC_DIR/coordinator-node.properties  \
--jvm-config=$ETC_DIR/coordinator-jvm.config \
--config=$ETC_DIR/coordinator-config.properties \
--log-levels-file=$ETC_DIR/coordinator-log.properties \
--server-log-file=/workspace/logs/coordinator-server.log  \
--launcher-log-file=/workspace/logs/coordinator-launcher.log  \
start
fi

if [[ "${ROLE_FULL_NAME}" == "trino-worker" ]]; then
launcher --etc-dir=$ETC_DIR  \
--node-config=$ETC_DIR/worker-node.properties  \
--jvm-config=$ETC_DIR/worker-jvm.config \
--config=$ETC_DIR/worker-config.properties \
--log-levels-file=$ETC_DIR/worker-log.properties \
--server-log-file=/workspace/logs/worker-server.log  \
--launcher-log-file=/workspace/logs/worker-launcher.log  \
start
fi

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null

# 使用trino-cli连接
trino-cli --server localhost:8085 --catalog hive --schema default

# 连接后执行测试用的sql
# 查看数据库
show schemas;
# 参考hive的命令进行测试,注意建表语句不完全一样
show tables;
CREATE TABLE IF NOT EXISTS trino_test_table (
  col1 integer COMMENT 'Integer Column',
  col2 varchar COMMENT 'String Column'
)
WITH (
  format = 'TEXTFILE'
);
insert into trino_test_table values(101,'101a');
select * from trino_test_table limit 100;

