#!/bin/bash

# 这里不递归修改
chown elasticsearch:elasticsearch /workspace
chown elasticsearch:elasticsearch /workspace/*
chown elasticsearch:elasticsearch /data/*

su -m elasticsearch -c "mkdir -p /workspace/logs"
su -m elasticsearch -c "mkdir -p /workspace/tmp"

\cp -f /opt/service-render-output/elasticsearch.yml $ES_HOME/config/
\cp -f /opt/service-render-output/jvm.options $ES_HOME/config/jvm.options.d/

su -m elasticsearch -c "elasticsearch -d -p /workspace/elasticsearch-pid"

sleep 5

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null
# 查看集群状态
curl -XGET "http://${HOSTNAME}:${ES_HTTP_PORT}/_cluster/health?pretty"
