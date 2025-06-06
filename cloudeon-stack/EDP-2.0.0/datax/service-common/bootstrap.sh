#!/bin/bash
set -xeuo pipefail

sleep 30
# 创建必要的目录
mkdir -p /workspace/logs

# 检查目标目录是否存在
if [ ! -d "$DATAX_WEB_HOME/modules" ]; then
    echo "Error: $DATAX_WEB_HOME/modules directory does not exist"
    exit 1
fi
# 复制已处理好的配置文件
\cp -f /opt/service-render-output/bootstrap-properties $DATAX_WEB_HOME/modules/datax-admin/conf/bootstrap.properties
\cp -f /opt/service-render-output/admin-env-properties $DATAX_WEB_HOME/modules/datax-admin/bin/env.properties
\cp -f /opt/service-render-output/executor-env-properties $DATAX_WEB_HOME/modules/datax-executor/bin/env.properties

echo
# 检查是否能连接到 MySQL
echo "正在尝试连接到 MySQL..."
if mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$MYSQL_HOST -P$MYSQL_PORT -e ";" 2>/dev/null
then
    echo "MySQL 连接成功"

    # 检查数据库是否存在
    if mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$MYSQL_HOST -P$MYSQL_PORT -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';" | grep "$MYSQL_DATABASE" > /dev/null
    then
        echo "数据库已存在"
    else
        echo "数据库不存在，正在创建..."
        mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$MYSQL_HOST -P$MYSQL_PORT -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"
        echo "数据库已创建"

        echo "正在导入 SQL 脚本..."
        mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$MYSQL_HOST -P$MYSQL_PORT -D$MYSQL_DATABASE < $DATAX_WEB_HOME/bin/db/datax_web.sql
        echo "SQL 脚本导入完成"
    fi
else
    echo "❌ 无法连接到 MySQL，请检查以下配置或服务状态："
    echo "用户名: $MYSQL_USERNAME"
    echo "主机: $MYSQL_HOST"
    echo "端口: $MYSQL_PORT"
    exit 1
fi

sleep 10
# 启动DataX Web服务
cd $DATAX_WEB_HOME
./bin/start-all.sh

# 保持容器运行
tail -f /dev/null