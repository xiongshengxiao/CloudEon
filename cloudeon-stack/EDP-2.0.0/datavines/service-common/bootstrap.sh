#!/usr/bin/env bash
set -xeuo pipefail

rm -rf logs
mkdir -p /workspace/logs
ln -s /workspace/logs logs

\cp -f /opt/service-render-output/* $DATAVINES_HOME/conf/

mkdir -p $DATAVINES_HOME/bin/
mkdir -p $DATAVINES_HOME/sql/
\cp -f /opt/service-common/datavines-daemon.sh $DATAVINES_HOME/bin/
chmod +x $DATAVINES_HOME/bin/datavines-daemon.sh
\cp -f /opt/service-common/datavines-mysql.sql $DATAVINES_HOME/sql/

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
    mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -D$MYSQL_DATABASE < /opt/datavines/sql/datavines-mysql.sql
fi

$DATAVINES_HOME/bin/datavines-daemon.sh start_with_jmx mysql

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null
