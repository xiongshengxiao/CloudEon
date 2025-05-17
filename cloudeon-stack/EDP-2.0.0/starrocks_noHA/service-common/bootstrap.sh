#!/usr/bin/env bash
set -xeuo pipefail

# 创建目录
mkdir -p /workspace/logs
mkdir -p /data/1/fe/metastore
mkdir -p /data/1/be/storage
mkdir -p /data/1/be/spill_storage

# 复制配置文件
mkdir -p /workspace/filebeat/inputs/
\cp -f /opt/service-render-output/filebeat.input.yml /workspace/filebeat/inputs/
\cp -f /opt/service-render-output/fe.conf $STARROCKS_HOME/fe/conf/
\cp -f /opt/service-render-output/be.conf $STARROCKS_HOME/be/conf/

# 设置系统参数
# sysctl -w vm.max_map_count=2000000
echo 'vm.max_map_count = 2000000' >> /etc/sysctl.conf
sysctl -p

# 定义辅助函数
check_fe_status() {
    local fe_ip=$1
    local fe_query_port=$2
    local expected_role=$3

    # 等待FE启动完成
    max_attempts=20  # 最大尝试次数
    attempts=0  # 当前尝试次数
    until mysql -uroot -P${fe_query_port} -h${fe_ip} -e "show frontends;" &> mysql_log.log
    do
        if [ $attempts -ge $max_attempts ]; then
            echo "FE启动超时，但将继续执行脚本。"
            return 1
        fi
        echo "等待FE启动完成..."
        echo "当前尝试次数：$attempts"
        echo "FE IP: ${fe_ip}, FE 端口: ${fe_query_port}"
        echo "日志如下："
        cat mysql_log.log
        sleep 5
        attempts=$((attempts+1))
    done

    # 检查FE状态
    # 执行 mysql 命令并提取相应的数据
    status=$(mysql -uroot -P${fe_query_port} -h${fe_ip} -e "show frontends;" | grep ${fe_ip} | awk '{print $12, $11, $9}')

    # 提取 alive, joined 和 is_master 字段
    alive=$(echo $status | awk '{print $1}')
    joined=$(echo $status | awk '{print $2}')
    is_master=$(echo $status | awk '{print $3}')

    # 输出提取的数据
    echo "Alive: $alive"
    echo "Joined: $joined"
    echo "IsMaster: $is_master"

    if [[ "$alive" != "true" || "$joined" != "true" ]]; then
        echo "警告: FE节点未正确启动或加入集群，但将继续执行脚本。"
        return 1
    fi

    if [[ "$expected_role" == "master" && "$is_master" != "true" ]]; then
        echo "警告: FE节点不是Master，但将继续执行脚本。"
        return 1
    elif [[ "$expected_role" != "master" && "$is_master" == "true" ]]; then
        echo "警告: FE节点不应该是Master，但将继续执行脚本。"
        return 1
    fi

    echo "FE节点状态正常"
    return 0
}

register_fe_node() {
    local master_ip=$1
    local master_query_port=$2
    local new_fe_ip=$3
    local new_fe_edit_log_port=$4
    local node_type=$5

    mysql -uroot -P${master_query_port} -h${master_ip} -e "ALTER SYSTEM ADD ${node_type} \"${new_fe_ip}:${new_fe_edit_log_port}\";"
    if [ $? -ne 0 ]; then
        echo "警告: 注册${node_type}节点失败，但将继续执行脚本。"
        return 1
    fi
    echo "${node_type}节点注册成功"
    return 0
}
register_be_node() {
    local master_ip=$1
    local master_query_port=$2
    local be_ip=$3
    local be_port=$4

    mysql -uroot -P${master_query_port} -h${master_ip} -e "ALTER SYSTEM ADD BACKEND \"${be_ip}:${be_port}\";"
    if [ $? -ne 0 ]; then
        echo "警告: 注册be节点(${be_ip}:${be_port})失败，但将继续执行脚本。"
        return 1
    fi
    echo "be节点注册成功: ${be_ip}:${be_port}"
    return 0
}
# 根据 ROLE_FULL_NAME 启动相应的服务
case "${ROLE_FULL_NAME}" in
    "starrocks-fe-master")
        echo "启动 STARROCKS FE Master..."
        start_fe.sh --daemon
        check_fe_status "${MASTER_FE_IP}" "${FE_QUERY_PORT}" "master" || echo "FE Master 检查失败，但将继续执行脚本。"
        ;;
    "starrocks-be")
        echo "启动 STARROCKS BE..."
        start_be.sh --daemon
        if ! mysql -uroot -P${FE_QUERY_PORT} -h${MASTER_FE_IP} -e "show backends;" | grep -q ${POD_IP}; then
            register_be_node "${MASTER_FE_IP}" "${FE_QUERY_PORT}" "${POD_IP}" "${BE_HEARTBEAT_SERVICE_PORT}" || echo "BE 注册失败，但将继续执行脚本。"
        fi
        ;;
    *)
        echo "错误: 未知的角色 ${ROLE_FULL_NAME}"
        # 即使角色未知，我们也不退出脚本
        ;;
esac

# 等待日志文件生成
until find /workspace/logs -mmin -1 -type f -name '*' ! -name '*gc*' | grep -q .
do
    echo "$(date): 等待日志生成..."
    sleep 2
done

# 持续输出最新的日志
find /workspace/logs -mmin -1 -type f -name '*' ! -name '*gc*' -exec tail -F {} +

echo "---------------------------------------------开始----------------------------------------------"
# 保持容器运行
tail -f /dev/null