#!/usr/bin/env bash


export MINIO_LOG_DIR=/workspace/logs
export MINIOPIDFILE=/workspace/minio-server.pid

### Exported environment variables ###

# 认证信息（使用 MINIO_ROOT_USER 和 MINIO_ROOT_PASSWORD 替代已 deprecated 的 MINIO_ACCESS_KEY 和 MINIO_SECRET_KEY）
#export MINIO_ROOT_USER=minio
#export MINIO_ROOT_PASSWORD=tox@123
export MINIO_ROOT_USER=${conf['MINIO_ROOT_USER']}
export MINIO_ROOT_PASSWORD=${conf['MINIO_ROOT_PASSWORD']}

# Volume to be used for Minio server.
#export MINIO_VOLUMES="/data"
#export MINIO_VOLUMES="http://data-dev0{5...8}/data/minio/data{1...2}"
#export MINIO_VOLUMES="http://data-prod0{6...9}/data/minio-data"
export MINIO_VOLUMES=${conf['MINIO_VOLUMES']}

# Use if you want to run Minio on a custom port.
#export MINIO_OPTS="--address :9000"
#export MINIO_OPTS="--address 0.0.0.0:9000"
export MINIO_OPTS="--address ${conf['bindHost']}:${conf['minio.server.port']}"

# 设置控制台地址
export MINIO_CONSOLE_ADDRESS=:9001

# MinIO 服务日志路径
#export MINIO_SERVER_LOG_PATH=/opt/minio/logs/minio-server.log
<#--
#export MINIO_SERVER_LOG_PATH=${MINIO_LOG_DIR}/minio-server.log
export MINIO_SERVER_LOG_PATH=${r'${MINIO_LOG_DIR}'}/minio-server.log
 -->

# 允许 Prometheus （不通过身份验证）直接获取 MinIO 集群的 metrics
export MINIO_PROMETHEUS_AUTH_TYPE=public
