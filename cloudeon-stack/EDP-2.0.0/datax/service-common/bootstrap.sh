#!/bin/bash

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
# 检查数据库是否存在
if mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -e "SHOW DATABASES LIKE '$MYSQL_DATABASE';" | grep "$MYSQL_DATABASE" > /dev/null
then
    echo "数据库已存在"
else
    echo "数据库不存在"
    # 创建数据库
    mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;"
    echo "数据库已创建"
    # 执行 SQL 脚本
    mysql -u$MYSQL_USERNAME -P$MYSQL_PORT -p$MYSQL_PASSWORD -h$MYSQL_HOST -D$MYSQL_DATABASE < $DATAX_WEB_HOME/bin/db/datax_web.sql
fi

# 启动DataX Web服务
cd $DATAX_WEB_HOME
./bin/start-all.sh

# 保持容器运行
tail -f /dev/null