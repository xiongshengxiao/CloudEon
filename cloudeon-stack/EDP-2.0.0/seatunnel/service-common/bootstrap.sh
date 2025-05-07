#!/usr/bin/env bash
set -xeuo pipefail

rm -rf logs
mkdir -p /workspace/logs
ln -s /workspace/logs logs

\cp -f /opt/service-render-output/* $SEATUNNEL_HOME/config/
mkdir -p /opt/seatunnel/hadoop_conf/
\cp -f /etc/hdfs-config/* /opt/seatunnel/hadoop_conf/


if [[ "${ROLE_FULL_NAME}" == "seatunnel-master" ]]; then
  seatunnel-cluster.sh -d -r master
fi

if [[ "${ROLE_FULL_NAME}" == "seatunnel-worker" ]]; then
  seatunnel-cluster.sh -d -r worker
fi

if [[ "${ROLE_FULL_NAME}" == "seatunnel-web" ]]; then
  \cp -f /opt/service-render-output/seatunnel_server_env.sh $SEATUNNEL_WEB_HOME/script/
  \cp -f /opt/service-render-output/application.yml $SEATUNNEL_WEB_HOME/conf/
  \cp -f $SEATUNNEL_HOME/config/hazelcast-client.yaml $SEATUNNEL_WEB_HOME/conf/
  \cp -f $SEATUNNEL_HOME/connectors/plugin-mapping.properties $SEATUNNEL_WEB_HOME/conf/

  source $SEATUNNEL_WEB_HOME/script/seatunnel_server_env.sh
  # 检查数据库是否存在
  if mysql -u$USERNAME -P$PORT -p$PASSWORD -h$HOSTNAME -e "SHOW DATABASES LIKE 'seatunnel';" | grep "seatunnel" > /dev/null
  then
      echo "数据库已存在"
  else
      echo "数据库不存在"
      bash $SEATUNNEL_WEB_HOME/script/init_sql.sh
  fi
  bash bin/seatunnel-backend-daemon.sh start
  tail -f /dev/null
fi

until find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' | grep -q .
do
  echo "`date`: Waiting for logs..."
  sleep 2
done
find /workspace/logs -mmin -1 -type f -name '*.log' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null
seatunnel.sh --config $SEATUNNEL_HOME/config/v2.batch.config.template