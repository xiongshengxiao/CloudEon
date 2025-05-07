#!/usr/bin/env bash
set -xeuo pipefail

<#assign SPRING_DATASOURCE_URL = conf['jdbc.mysql.address']>
<#assign MYSQL_HOST = SPRING_DATASOURCE_URL?split("//")[1]?split(":")[0]>
<#assign MYSQL_PORT = SPRING_DATASOURCE_URL?split("//")[1]?split(":")[1]?split("/")[0]>
<#assign MYSQL_DATABASE = SPRING_DATASOURCE_URL?split("/")[3]>
export MYSQL_HOST=${MYSQL_HOST}
export MYSQL_PORT=${MYSQL_PORT}
export MYSQL_DATABASE=${MYSQL_DATABASE}
export MYSQL_USERNAME=${conf['jdbc.mysql.username']}
export MYSQL_PASSWORD=${conf['jdbc.mysql.password']}
echo "mysql_host: $MYSQL_HOST, mysql_port: $MYSQL_PORT, mysql_database: $MYSQL_DATABASE, mysql_username: $MYSQL_USERNAME"
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
    bash tools/bin/upgrade-schema.sh
    echo "数据库已升级"
fi
