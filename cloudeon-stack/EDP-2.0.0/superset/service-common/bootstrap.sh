#!/usr/bin/env bash
set -xeuo pipefail

rm -rf logs
mkdir -p /workspace/logs
ln -s /workspace/logs logs

mkdir -p $SUPERSET_HOME/bin/
\cp -f /opt/service-render-output/superset.sh $SUPERSET_HOME/bin/
chmod +x $SUPERSET_HOME/bin/superset.sh

# 检查是否能连接到 MySQL
echo "正在尝试连接到 MySQL..."
if mysql -u$MYSQL_USERNAME -p$MYSQL_PASSWORD -h$MYSQL_HOST -P$MYSQL_PORT -e ";" 2>/dev/null
then
    echo "MySQL 连接成功"

    # 精确判断数据库是否存在
    db=$(mysql -u"$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -P"$MYSQL_PORT" \
        -sse "SHOW DATABASES LIKE '$MYSQL_DATABASE'" 2>/dev/null)

    # 发现连接数据库需要点时间，当执行了判断是否存在数据库可能还没查询返回结果，下面就先执行创建数据库了，导致会出现：数据库已经存在。所以需要等待会
    sleep 5

    if [[ "$db" == "$MYSQL_DATABASE" ]]; then
        echo "⚠️ 数据库 $MYSQL_DATABASE 已存在"
    else
        echo "✅ 数据库 $MYSQL_DATABASE 不存在，正在创建..."
        mysql -u"$MYSQL_USERNAME" -p"$MYSQL_PASSWORD" -h"$MYSQL_HOST" -P"$MYSQL_PORT" \
            -e "CREATE DATABASE $MYSQL_DATABASE DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;"

        echo "创建 Superset 的Python环境"
        $MINICONDA3_HOME/bin/conda create --name superset python=3.10.18 -y

        echo "更新 pip"
        $MINICONDA3_HOME/envs/superset/bin/pip install --upgrade pip -i https://pypi.douban.com/simple/

        echo "安装Superset"
        $MINICONDA3_HOME/envs/superset/bin/pip install "apache-superset==4.1.2" -i https://mirrors.aliyun.com/pypi/simple/
        ln -s $MINICONDA3_HOME/envs/superset /opt/superset

        echo "生成SECRET_KEY并修改配置SECRET_KEY"
        SECRET_KEY=$(openssl rand -base64 42)
        sed -i "s|SECRET_KEY = os.environ.get(\"SUPERSET_SECRET_KEY\") or CHANGE_ME_SECRET_KEY|SECRET_KEY = '${SECRET_KEY}'|" \
        $MINICONDA3_HOME/envs/superset/lib/python3.10/site-packages/superset/config.py

        echo "汉化操作"
        sed -i 's/BABEL_DEFAULT_LOCALE = "en"/BABEL_DEFAULT_LOCALE = "zh"/' \
        $MINICONDA3_HOME/envs/superset/lib/python3.10/site-packages/superset/config.py

        echo "正在配置数据库..."
        DB_URI="mysql://${MYSQL_USERNAME}:${MYSQL_PASSWORD}@${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE}?charset=utf8"
        sed -i "/^SQLALCHEMY_DATABASE_URI = (/,/^)/c\\SQLALCHEMY_DATABASE_URI = '${DB_URI}'" \
        $MINICONDA3_HOME/envs/superset/lib/python3.10/site-packages/superset/config.py

        echo "安装python msyql驱动"
        $MINICONDA3_HOME/envs/superset/bin/pip install mysqlclient -i https://mirrors.aliyun.com/pypi/simple/
        echo "修复superset db upgrade初始化Supetset数据库提示：TypeError: Field.init() got an unexpected keyword argument 'minLength'"
        $MINICONDA3_HOME/envs/superset/bin/pip install marshmallow==3.26.1 -i https://mirrors.aliyun.com/pypi/simple/

        echo "正在初始化superset元数据..."
        export FLASK_APP=superset
        $MINICONDA3_HOME/envs/superset/bin/superset db upgrade

        echo "正在创建管理员用户..."
        $MINICONDA3_HOME/envs/superset/bin/superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password yixiao666

        echo "修复运行`superset init`初始化角色和权限时提示：INFO:superset.utils.screenshots:No PIL installation found"
        $MINICONDA3_HOME/envs/superset/bin/pip install pillow -i https://mirrors.aliyun.com/pypi/simple/

        echo "正在初始化superset..."
        $MINICONDA3_HOME/envs/superset/bin/superset init

        echo "安装gunicorn-gunicorn是一个Python Web Server，可以和java中的TomCat类比"
        $MINICONDA3_HOME/envs/superset/bin/pip install gunicorn -i https://mirrors.aliyun.com/pypi/simple/

        echo "下载安装相关数据源"
        $MINICONDA3_HOME/envs/superset/bin/pip install psycopg2-binary  pydoris clickhouse-connect elasticsearch-dbapi starrocks thrift pyhive -i https://mirrors.aliyun.com/pypi/simple/
    fi
else
    echo "❌ 无法连接到 MySQL，请检查以下配置或服务状态："
    echo "用户名: $MYSQL_USERNAME"
    echo "主机: $MYSQL_HOST"
    echo "端口: $MYSQL_PORT"
    exit 1
fi


sleep 10
#$SUPERSET_HOME/bin/superset.sh start

exec $SUPERSET_HOME/bin/gunicorn \
    --workers 5 \
    --timeout 120 \
    --bind 0.0.0.0:8787 \
    --access-logfile /workspace/logs/superset.log \
    --error-logfile /workspace/logs/superset-error.log \
    'superset.app:create_app()'

#until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
#do
#  echo "`date`: Waiting for logs..."
#  sleep 2
#done
#find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null


