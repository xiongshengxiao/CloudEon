#!/bin/bash
#
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

# 导入认证信息、节点及存储路径等环境变量
source /opt/minio/conf/minio-env.sh

SCRIPT_PATH="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPT_PATH/../"
MINIO_BASE_PATH=`pwd`
echo "MINIO_BASE_PATH: ${MINIO_BASE_PATH}"

# 使用方法
usage() {
   echo "Usage: sh $0 {start|stop|status|restart}"
   exit 1
}

# 判断参数
if [ $# -lt 1 ]; then
    usage
    exit 1;
fi

start() {
    echo "Starting MinIO..."
    # 启动
#    nohup /opt/datasophon/minio/bin/minio server --anonymous --address "0.0.0.0:9000" ${MINIO_VOLUMES} > /opt/datasophon/minio/logs/minio-server.log 2>&1 &
#    nohup ${MINIO_BASE_PATH}/bin/minio server --anonymous ${MINIO_OPTS} ${MINIO_VOLUMES} > ${MINIO_SERVER_LOG_PATH} 2>&1 &
    nohup ${MINIO_BASE_PATH}/bin/minio server --anonymous ${MINIO_OPTS} ${MINIO_VOLUMES} > ${MINIO_LOG_DIR}/minio-server.log 2>&1 &
    # 启动失败
    if [ $? -ne 0 ]; then
      echo "Failed to start MinIO."
      exit 1
    fi

    echo "Started MinIO successfully."
}

stop() {
    echo "Stopping MinIO..."
    PID=$(ps -ef | grep 'minio server' | grep -v grep | awk '{print $2}')
    if [ "X${PID}" != "X" ]; then
        kill -9 ${PID}
        if [ $? -ne 0 ]; then
          echo "Failed to kill MinIO with PID (${PID})."
          exit 1
        fi
    fi

    echo "Stopped MinIO successfully."
}

status() {
    echo "Checking MinIO status..."
    PID=$(ps -ef | grep 'minio server' | grep -v grep | awk '{print $2}')
    if [ "X${PID}" = "X" ]; then
        echo "MinIO is not running."
        exit 1
    else
        echo "MinIO is running with PID (${PID})."
        exit 0
    fi
}

restart() {
    stop
    start
    sleep 5
    status
}


case "$1" in
        'start')
            start
            ;;

        'stop')
            stop
            ;;

        'status')
            status
            ;;

        'restart')
            restart
            ;;

        *)
            usage
            exit 1
            ;;
esac
exit 0
