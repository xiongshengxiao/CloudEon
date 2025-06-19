#!/bin/bash

# 设置环境变量（如果未在外部设置）
export MINICONDA3_HOME=/opt/miniconda3
export PATH=${MINICONDA3_HOME}/bin:${PATH}
export SUPERSET_HOME=/opt/superset

superset_status() {
    result=$(ps -ef | awk '/gunicorn/ && !/awk/{print $2}' | wc -l)
    if [[ $result -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

superset_start() {
    superset_status >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 启动 Superset" >> /workspace/logs/superset.log

        # 使用 gunicorn 内置日志系统分别记录日志
        ${MINICONDA3_HOME}/envs/superset/bin/gunicorn \
            --workers 5 \
            --timeout 120 \
            --bind 0.0.0.0:8787 \
            --daemon \
            --access-logfile /workspace/logs/superset.log \
            --error-logfile /workspace/logs/superset-error.log \
            'superset.app:create_app()'

        echo "$(date '+%Y-%m-%d %H:%M:%S') - Superset 已启动" >> /workspace/logs/superset.log
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Superset 正在运行" >> /workspace/logs/superset.log
        echo "superset正在运行"
    fi
}

superset_stop() {
    superset_status >/dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "superset未在运行"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') - 停止 Superset" >> /workspace/logs/superset.log
        echo "停止 Superset"
        ps -ef | awk '/gunicorn/ && !/awk/{print $2}' | xargs kill -9
    fi
}

case $1 in
    start )
        echo "启动Superset"
        superset_start
    ;;
    stop )
        echo "停止Superset"
        superset_stop
    ;;
    restart )
        echo "重启Superset"
        superset_stop
        superset_start
    ;;
    status )
        superset_status >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            echo "superset未在运行"
        else
            echo "superset正在运行"
        fi
    ;;
    * )
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0