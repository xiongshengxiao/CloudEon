#!/bin/bash
set -e

mkdir -p /workspace/logs

# Tips: 这里的 service-render-output/xxx 就是 service-render 目录下的 freemarker 模板文件编译出来的！
\cp -f /opt/service-render-output/minio-env.sh $MINIO_HOME/conf/
\cp -f /opt/service-common/control.sh $MINIO_HOME/bin/
chmod +x $MINIO_HOME/bin/control.sh

$MINIO_HOME/bin/control.sh start

sleep 5

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null
