#!/bin/bash
set -e

mkdir -p /workspace/logs

\cp -f /opt/service-render-output/* $KAFKA_HOME/config/

## 打印调试信息
#echo "当前工作目录: $(pwd)"
#echo "KAFKA_HOME: $KAFKA_HOME"
#
#echo "查找文件"
#ls -l /
#ls -l /cluster_id.txt

# 从 cluster_id.txt 文件中读取 CLUSTER_ID
if [[ -f "/cluster_id.txt" ]]; then
    CLUSTER_ID=$(cat /cluster_id.txt | tr -d '\r\n')
    echo "Cluster ID 读取成功: $CLUSTER_ID"
else
    echo "错误：未找到 cluster_id.txt 文件，请检查路径 /cluster_id.txt"
    exit 1
fi

# 格式化存储目录
$KAFKA_HOME/bin/kafka-storage.sh format -t "$CLUSTER_ID" -c $KAFKA_HOME/config/server.properties
#bin/kafka-storage.sh format --standalone -t $CLUSTER_ID -c config/server.properties

# 加载环境变量
source $KAFKA_HOME/config/kafka-env.sh
# 启动Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

echo "---------------------------------------------开始----------------------------------------------"
tail -f /dev/null

# 功能测试，不会自动执行

kafka-topics.sh --zookeeper $HOSTNAME:$ZK_CLIENT_PORT/kafka --create --topic t1 --partitions 1 --replication-factor 1
kafka-topics.sh --zookeeper $HOSTNAME:$ZK_CLIENT_PORT/kafka --list

kafka-console-producer.sh --bootstrap-server $HOSTNAME:$KAFKA_PORT --topic t1
kafka-console-consumer.sh --bootstrap-server $HOSTNAME:$KAFKA_PORT --from-beginning  --topic t1